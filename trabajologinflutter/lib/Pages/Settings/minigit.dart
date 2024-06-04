import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordsPage extends StatefulWidget {
  @override
  _ChangePasswordsPageState createState() => _ChangePasswordsPageState();
}

class _ChangePasswordsPageState extends State<ChangePasswordsPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  bool _isSending = false; // Estado para mostrar indicador de carga

  Future<void> _sendPasswordResetEmail() async {
    try {
      setState(() {
        _isSending = true; // Mostrar indicador de carga
      });

      final email = _emailController.text; // Obtener el correo electrónico ingresado

      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email); // Enviar correo de restablecimiento
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correo de restablecimiento enviado a $email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingrese un correo electrónico válido')), // Notificacion de error
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar correo: ${e.message}')), // Manejo de errores wn el FireBaseAuth
      );
    } finally {
      setState(() {
        _isSending = false; // Ocultar indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaciado interno
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingrese su correo electrónico para recibir un enlace de restablecimiento de contraseña.',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            SizedBox(height: 20), // Espacio entre elementos
            ElevatedButton(
              onPressed: _isSending ? null : _sendPasswordResetEmail, // Desactivar mientras se envia
              child: _isSending
                  ? CircularProgressIndicator(
                color: Colors.white, //color del Indicador de carga
              )
                  : Text('Enviar Enlace de Restablecimiento'), // Texto del boton
            ),
          ],
        ),
      ),
    );
  }
}
