import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../Modelos/Cliente.dart';

class AuthService extends ChangeNotifier{

  final String _firebaseToken = 'AIzaSyAjAAC8v3PbVB6T2MF2d2yoGG8qXJ0--qk';

  final storage = new FlutterSecureStorage();
  static final FirebaseAuth _auth = FirebaseAuth.instance;




//LOGIN
  Future<String?> login( String email, String password ) async {


    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken');

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode( resp.body );

    if ( decodedResp.containsKey('idToken') ) {
      print(decodedResp['idToken']);
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }

  }
Future<String?> signup(String email, String password) async {
  final Map<String, dynamic> authData = {
    'email': email,
    'password': password,
    'returnSecureToken': true
  };

  final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken');

  final resp = await http.post(url, body: json.encode(authData));

  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken')) {
    print(decodedResp['idToken']);
    await storage.write(key: 'token', value: decodedResp['idToken']);
    return null;
  } else {
    return decodedResp['error']['message'];
  }
}

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print('error');
    }
    return null;
  }
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print("error");
    }
    return null;
  }

  Future<void> sendEmailVerification(String email) async {
  final user = FirebaseAuth.instance.currentUser;
  await user?.sendEmailVerification();
}
  Future<String?> signin(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken');

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      print(decodedResp['idToken']);
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser; // Return the currently authenticated user
  }



  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';

  }

  Future<void> sendEmailVerificationLink() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }catch(e){
      print(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Enviar correo electrónico para restablecer la contraseña
      await _auth.sendPasswordResetEmail(email: email);

      print("Correo electrónico de restablecimiento de contraseña enviado correctamente a $email");
    } catch (e) {
      throw Exception("Error al enviar el correo electrónico de restablecimiento de contraseña: $e");
    }
  }
  Future<void> reauthenticateAndDelete(String email, String password) async {
    try {
      // Obtener usuario actual
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("No hay usuario autenticado.");
      }

      // Reautenticar al usuario
      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: password);
      await user.reauthenticateWithCredential(credential);

      // Eliminar la cuenta del usuario
      await user.delete();

      print("Usuario reautenticado y eliminado correctamente");
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw Exception("Error de Firebase: ${e.message}");
      } else {
        throw Exception("Error en reautenticación y eliminación: $e");
      }
    }
  }
}
  Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        // Realiza cualquier otra acción necesaria después de la eliminación exitosa
        print("Usuario eliminado correctamente");
      } else {
        print("No hay usuario autenticado.");
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          print("El usuario necesita volver a autenticarse.");
          // Aquí puedes redirigir al usuario a la pantalla de inicio de sesión
          // y pedirle que vuelva a autenticarse antes de intentar eliminar la cuenta de nuevo.
        } else {
          print("Error de Firebase: ${e.message}");
        }
      } else {
        print("Error inesperado: $e");
      }
      // Maneja otros tipos de errores según sea necesario
    }




  }

