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

    String? errorMessage = await _authService.signup(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (errorMessage == null) {
      // Navegar a la página de éxito o realizar otra acción
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
      extendBodyBehindAppBar: true, // Para evitar el hueco amarillo
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB71C1C), // Rojo oscuro
                Color(0xFFC62828), // Rojo medio
                Color(0xFFEF5350), // Rojo claro
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                _buildForm(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Icon(
            Icons.fitness_center, // Icono de gimnasio
            color: Colors.white,
            size: 80,
          ),
          SizedBox(height: 10),
          Text(
            'Registro al Gimnasio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
              SizedBox(height: 32),
              _isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC62828)), // Rojo medio
              )
                  : ElevatedButton(
                onPressed: _register,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal ,
                      color: Color(0xFFB71C1C), // Rojo oscuro
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEF5350), // Rojo claro
                  onPrimary: Color(0xFFB71C1C), // Rojo oscuro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
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
          fontWeight: FontWeight.normal,
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
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFFB71C1C)), // Rojo oscuro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      obscureText: isPassword,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
