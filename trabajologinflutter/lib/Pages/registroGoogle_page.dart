import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../services/auth_service.dart';

class RegistroGooglePage extends StatefulWidget {
  final String email;

  RegistroGooglePage({required this.email});

  @override
  _RegistroGooglePageState createState() => _RegistroGooglePageState();
}

class _RegistroGooglePageState extends State<RegistroGooglePage> {
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

  Future<void> _register() async {
    setState(() {
      _validador = true;
    });

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
    await _insertarNuevoCliente();
  }

  Future<void> _insertarNuevoCliente() async {
    final String correo = widget.email;
    final String nombre = _nombreController.text;
    final String peso = _pesoController.text;
    final String altura = _alturaController.text;
    final String telefono = _telefonoController.text;
    final String kcalMensual = "0";
    final String estrellas = "0";
    final String imageUrl = "";

    final String idgimnasio = "1";
    final String objetivomensual = "0";



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
      "amigos": [],
      "objetivomensual": objetivomensual,
      "idgimnasio": idgimnasio,
    };

    try {
      final response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        print("Nuevo cliente insertado correctamente");
        _mostrarSuccessDialog();
      } else {
        print('Error al agregar nuevo cliente: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }

    setState(() {
      _validador = false;
    });
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )
                : ElevatedButton(
              onPressed: _register,
              child: Text(
                'Registrarse',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          '¿Ya tienes una cuenta?',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Inicia sesión aquí',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
