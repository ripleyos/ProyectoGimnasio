
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../services/auth_service.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _authService = AuthService();
  List<String> _profileImageUrls = [
    "https://store.playstation.com/store/api/chihiro/00_09_000/container/AR/es/19/UT0016-NPUO00020_00-AVAPLUSXTOPDAWG0/image?w=320&h=320&bg_color=000000&opacity=100&_version=00_09_000",
    "url_de_la_imagen_2",
    "url_de_la_imagen_3",
  ];

  bool _validador = false;
  String? _selectedImageUrl;
  XFile? _image;
  String? _validateHeight(String value) {
    if (value.isEmpty) {
      return 'Ingrese su altura';
    }
    final RegExp regex = RegExp(r'^\d{3}$');
    if (!regex.hasMatch(value)) {
      return 'La altura debe tener el formato "170"';
    }
    return null;
  }

  // Validador para verificar que el campo de peso tenga el formato "50.32"
  String? _validateWeight(String value) {
    if (value.isEmpty) {
      return 'Ingrese su peso';
    }
    final RegExp regex = RegExp(r'^\d{2,3}(\.\d{1,2})?$');
    if (!regex.hasMatch(value)) {
      return 'El peso debe tener el formato "50.32"';
    }
    return null;
  }

  // Validador para verificar que el campo de teléfono tenga una longitud de 9 y sean solo números
  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return 'Ingrese su teléfono';
    }
    final RegExp regex = RegExp(r'^\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'El teléfono debe tener 9 dígitos';
    }
    return null;
  }

  Future<void> _register() async {
    setState(() {
      _validador = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      _mostrarErrorDialog("Las contraseñas no coinciden");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Validación de peso
    if (_pesoController.text.isEmpty) {
      _mostrarErrorDialog("Ingrese su peso");
      setState(() {
        _validador = false;
      });
      return;
    }

    final pesoRegex = RegExp(r'^\d{2,3}(\.\d{1,2})?$');
    if (!pesoRegex.hasMatch(_pesoController.text)) {
      _mostrarErrorDialog("El peso debe tener el formato '50.32'");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Validación de altura
    if (_alturaController.text.isEmpty) {
      _mostrarErrorDialog("Ingrese su altura");
      setState(() {
        _validador = false;
      });
      return;
    }

    final alturaRegex = RegExp(r'^\d{3}$');
    if (!alturaRegex.hasMatch(_alturaController.text)) {
      _mostrarErrorDialog("La altura debe tener el formato '170'");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Validación de teléfono
    if (_telefonoController.text.isEmpty) {
      _mostrarErrorDialog("Ingrese su teléfono");
      setState(() {
        _validador = false;
      });
      return;
    }

    final telefonoRegex = RegExp(r'^\d{9}$');
    if (!telefonoRegex.hasMatch(_telefonoController.text)) {
      _mostrarErrorDialog("El teléfono debe tener 9 dígitos");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Si todos los campos son válidos, procedemos con el registro
    String? errorMessage = await _authService.signup(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _validador = false;
    });

    if (errorMessage == null) {
      _mostrarSuccessDialog();
      await _insertarNuevoCliente();
    } else {
      _mostrarErrorDialog(errorMessage);
    }
  }


  Future<void> _insertarNuevoCliente() async {
    final String correo = _emailController.text;
    final String nombre = _nombreController.text;
    final String peso = _pesoController.text;
    final String altura = _alturaController.text;
    final String telefono = _telefonoController.text;
    final String kcalMensual = "1"; // Valor predeterminado para kcalMensual
    final String estrellas = "0"; // Valor predeterminado para estrellas
    final String imageUrl = ""; // Se establece la URL de la imagen en vacío

    // Aquí debes establecer el idgimnasio y el objetivomensual según tu lógica de negocio
    final String idgimnasio = "1"; // Por ejemplo, se establece el idgimnasio en "1"
    final String objetivomensual = "5000"; // Por ejemplo, se establece el objetivomensual en "0"

    // Sube la imagen a Firebase Storage si es necesario

    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json';

    Map<String, dynamic> data = {
      "correo": correo,
      "nombre": nombre,
      "peso": peso,
      "altura": altura,
      "telefono": telefono,
      "kcalMensual": kcalMensual,
      "estrellas": estrellas,
      "imagenUrl": imageUrl,
      "amigos": [], // Lista de amigos inicialmente vacía
      "objetivomensual": objetivomensual,
      "idgimnasio": idgimnasio,
    };

    try {
      final response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        print("Nuevo cliente insertado correctamente");
      } else {
        print('Error al agregar nuevo cliente: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }
  }


  Future<String> _uploadImageToFirebaseStorage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child('clientes').child(DateTime.now().toString() + '.jpg');

      final firebase_storage.UploadTask uploadTask = storageRef.putFile(File(pickedImage.path));
      final firebase_storage.TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();

      return url;
    }

    return "";
  }

  void _mostrarSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registro exitoso'),
          content: Text('¡Bienvenido! Tu registro ha sido exitoso.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error en el registro'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Color(0xFF2A0000),
    Color(0xFF460303),
    Color(0xFF730000),
    Color(0xFFA80000),
    ],
    ),
    ),
          child: Column(
            children: [
              SizedBox(height: 80),
              _buildHeader(),
              SizedBox(height: 20),
              _buildForm(),
              SizedBox(height: 20),
              _buildFooter(),
            ],
          ),
        ),
        ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.fitness_center,
          color: Colors.white,
          size: 80,
        ),
        SizedBox(height: 10),
        Text(
          'Registro en Gimnasio',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInputField(
              controller: _emailController,
              labelText: 'Correo electrónico',
              icon: Icons.email,
            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _passwordController,
              labelText: 'Contraseña',
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _confirmPasswordController,
              labelText: 'Confirmar Contraseña',
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _nombreController,
              labelText: 'Nombre',
              icon: Icons.person,
            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _pesoController,

              labelText: 'Peso (kg)',
              icon: Icons.fitness_center,
              keyboardType: TextInputType.numberWithOptions(decimal: true),

            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _alturaController,
              labelText: 'Altura (cm)',
              icon: Icons.height,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            _buildInputField(
              controller: _telefonoController,
              labelText: 'Teléfono',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            SizedBox(height: 32),
            _validador
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFA80000)),
            )
                : Center(
              child: ElevatedButton(
                onPressed: _register,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFA80000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            'Seleccionar imagen de perfil:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 3, // Número de imágenes por fila
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Evita el desplazamiento dentro del GridView
          children: _profileImageUrls.map((imageUrl) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImageUrl = imageUrl;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }


  Widget _buildProfileImagePreview(String imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }






  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '¡Comienza tu viaje hacia un cuerpo más fuerte!',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey[700]),
        prefixIcon: Icon(icon, color: Color(0xFFA80000)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      obscureText: isPassword,
      keyboardType: keyboardType,
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seleccionar imagen:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final pickedImage =
            await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              setState(() {
                _image = pickedImage;
              });
            }
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: _image == null
                ? Icon(Icons.add_a_photo,
                size: 40, color: Colors.grey[700])
                : Image.file(File(_image!.path), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
