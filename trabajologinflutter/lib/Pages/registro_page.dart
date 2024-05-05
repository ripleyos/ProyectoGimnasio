import 'package:flutter/material.dart';
import 'package:trabajologinflutter/services/auth_service.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
      // Acciones posteriores al registro exitoso
    } else {
      _mostrarErrorDialog(errorMessage);
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
                Color(0xFF2A0000), // Rojo muy oscuro
                Color(0xFF460303), // Rojo oscuro profundo
                Color(0xFF730000), // Rojo medio oscuro
                Color(0xFFA80000), // Rojo vibrante
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 80), // Espacio para el encabezado
              _buildHeader(), // Encabezado con título
              SizedBox(height: 20),
              _buildForm(), // Formulario de registro
              SizedBox(height: 20),
              _buildFooter(), // Pie de página motivacional
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
            SizedBox(height: 32), // Espacio para separar el botón del formulario
            _isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA80000)), // Rojo vibrante
            )
                : Center( // Centrar el botón de registro
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
                  primary: Color(0xFFA80000), // Rojo vibrante
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
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey[700]), // Cambiar el color del hint para mejor contraste
        prefixIcon: Icon(icon, color: Color(0xFFA80000)), // Rojo vibrante
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      obscureText: isPassword,
      keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
    );
  }
}
