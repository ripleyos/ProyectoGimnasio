import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trabajologinflutter/services/auth_service.dart';
import '../componentes/square_tile.dart';
import 'registro_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> _signIn() async {
    String email = _usernameController.text;
    String password = _passwordController.text;

    String? errorMessage = await _authService.signin(email, password);

    if (errorMessage == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewPage()), // Cambia "NewPage" al nombre de tu nueva página
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFFB71C1C),
              Color(0xFFC62828),
              Color(0xFFEF5350)
            ]
          )
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start, // Corrección aquí
                  children: <Widget>[
                    Text("Login",style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10),
                    Text("Bienvenido de vuelta",style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
               ),
              )
          ]
        )
      ),
    );
      
}


class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Nueva'),
      ),
      body: const Center(
        child: Text('Has iniciado sesión correctamente!'),
      ),
    );
  }
}
