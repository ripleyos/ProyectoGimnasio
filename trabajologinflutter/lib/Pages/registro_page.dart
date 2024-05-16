import 'package:flutter/material.dart';
import 'package:trabajologinflutter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      _mostrarErrorDialog("Las contraseñas no coinciden");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String? errorMessage = await _authService.signup(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
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
    final double peso = double.parse(_pesoController.text);
    final double altura = double.parse(_alturaController.text);
    final String telefono = _telefonoController.text;

    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json';

    Map<String, dynamic> data = {
      "correo": correo,
      "nombre": nombre,
      "peso": peso,
      "altura": altura,
      "telefono": telefono,
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
            SizedBox(height: 32),
            _isLoading
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
}
