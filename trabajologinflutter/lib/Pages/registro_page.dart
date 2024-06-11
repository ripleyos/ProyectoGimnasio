import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:trabajologinflutter/Pages/login_page.dart';

import '../Gestores/GestorClientes.dart';
import '../Modelos/Cliente.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  List<String> _profileImageUrls = [
    "https://store.playstation.com/store/api/chihiro/00_09_000/container/AR/es/19/UT0016-NPUO00020_00-AVAPLUSXTOPDAWG0/image?w=320&h=320&bg_color=000000&opacity=100&_version=00_09_000",
    "url_de_la_imagen_2",
    "url_de_la_imagen_3",
  ];

  bool _validador = false;
  String? _selectedImageUrl;
  XFile? _image;
  List<String> _amigos = ["amigo1@example.com", "amigo2@example.com"];
  List<String> _amigosPendientes = ["nuevo21@example.com", "nuevo22@example.com"];

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
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA80000)),
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

    // Validar formato de peso
    if (!RegExp(r'^\d{1,3}(\.\d{1,2})?$').hasMatch(_pesoController.text)) {
      _mostrarErrorDialog("Formato de peso inválido. Debe ser '00.00'.");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Validar formato de altura
    int altura = int.tryParse(_alturaController.text) ?? 0;
    if (altura < 140 || altura > 210) {
      _mostrarErrorDialog("La altura debe ser un número entero entre 140 y 210.");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Validar formato de número de teléfono
    if (!RegExp(r'^\d{9}$').hasMatch(_telefonoController.text)) {
      _mostrarErrorDialog("Formato de número de teléfono inválido. Debe tener 9 dígitos.");
      setState(() {
        _validador = false;
      });
      return;
    }

    // Convertir el correo electrónico a minúsculas
    String email = _emailController.text.toLowerCase();

    setState(() {
      _validador = false;
    });

    final user = await _authService.createUserWithEmailAndPassword(email, _passwordController.text);

    if (user != null) {
      await _registrarCliente();
      _mostrarSuccessDialog();// Pasar el correo electrónico a la función de inserción
    } else {
      _mostrarErrorDialog("error");
    }
  }

  Future<void> _registrarCliente() async {
      try {
        final String nombre = _nombreController.text;
        final String correo = _emailController.text.toLowerCase();
        final String peso = _pesoController.text;
        final String altura = _alturaController.text;
        final String telefono = _telefonoController.text;
        final String kcalMensual = "1";
        final String estrellas = "0";
        final String imageUrl = "https://static.vecteezy.com/system/resources/previews/009/314/126/non_2x/default-avatar-profile-in-flat-design-free-png.png";
        final String idgimnasio = "0";
        final String objetivomensual = "5000";

        final nuevoCliente = Cliente(
          id: '', // Asigna un id adecuado si es necesario
          nombre: nombre,
          correo: correo,
          imagenUrl: imageUrl,
          peso: peso,
          kcalMensual: kcalMensual,
          estrellas: estrellas,
          amigos: [], // Lista inicial de amigos
          amigosPendientes: [], // Lista inicial de amigos pendientes
          objetivomensual: objetivomensual,
          idgimnasio: idgimnasio,
          altura: altura,
        );

        await GestorClientes.insertarNuevoCliente(nuevoCliente);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print('Error al registrar cliente: $e');
      }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
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
}

