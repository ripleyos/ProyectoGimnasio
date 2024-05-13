import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabajologinflutter/Pages/main_page.dart';
import 'package:trabajologinflutter/Pages/mapa_page.dart';
import 'package:trabajologinflutter/services/auth_service.dart';
import 'registro_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _saveUserData(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    String? errorMessage = await _authService.signin(email, password);

    if (errorMessage == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80),
              Text(
                "Gimnasio Fit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Bienvenido de vuelta",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Correo electrónico",
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text("Recordar usuario y contraseña"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _rememberMe,
                onChanged: (bool? value) async {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                  if (_rememberMe) {
                    await _saveUserData(_emailController.text, _passwordController.text);
                  } else {
                    await _clearUserData();
                  }
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Lógica para restablecer la contraseña
                },
                child: Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA80000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.white,
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: 20),
              Text(
                "Iniciar sesión con redes sociales",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Iniciar sesión con Google
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Image.network(
                        'https://img.icons8.com/color/48/000000/google-logo.png',
                        height: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Iniciar sesión con Facebook
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Image.network(
                        'https://img.icons8.com/color/48/000000/facebook.png',
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroPage()),
                      );
                    },
                    child: Text(
                      "Créala ahora",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

