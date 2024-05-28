import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Pages/Settings/CambiarFotoDePerfilPage.dart';
import 'package:trabajologinflutter/Pages/SupportPage.dart';
import 'package:trabajologinflutter/Pages/login_page.dart';
import '../Modelos/Cliente.dart';
import '../services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  final Cliente cliente;

  SettingsPage({required this.cliente});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Cliente _cliente;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      _cliente=widget.cliente;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración para ${_cliente.correo}'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            _buildAccountExpansionTile(context),
            SizedBox(height: 16.0),
            _buildSettingsCard(
              context,
              icon: Icons.notifications,
              title: 'Configuración de Notificaciones',
              description: 'Controla tus preferencias de notificación',
              onTap: () {
                // Acción para la configuración de notificaciones
              },
            ),
            SizedBox(height: 16.0),
            _buildSettingsCard(
              context,
              icon: Icons.security,
              title: 'Privacidad y Seguridad',
              description: 'Ajusta configuraciones de privacidad y seguridad',
              onTap: () {
                // Acción para privacidad y seguridad
              },
            ),
            SizedBox(height: 16.0),
            _buildSettingsCard(
              context,
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte',
              description: 'Obtén ayuda y soporte',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SupportPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Configuración de Cuenta',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: Icon(Icons.person, color: Colors.white),
      children: <Widget>[
        _buildAccountOption(
          context,
          icon: Icons.image,
          title: 'Cambiar Imagen de Perfil',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CambiarFotoDePerfilPage(cliente: _cliente),
              ),
            );
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.lock,
          title: 'Cambiar Contraseña',
          onTap: () {
            _authService.sendPasswordResetEmail(_cliente.correo).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Correo de restablecimiento de contraseña enviado")),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error al enviar el correo de restablecimiento: $error")),
              );
            });
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.delete,
          title: 'Eliminar Cuenta',
          onTap: () {
            try {
              _authService.sendPasswordResetEmail(_cliente.correo);
            } catch (e) {
              print(e);
            }
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.exit_to_app,
          title: 'Cerrar Sesión',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAccountOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: Icon(icon, color: Colors.white),
      onTap: onTap,
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required IconData icon, required String title, required String description, required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.orange),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black),
        onTap: onTap,
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Por favor, ingresa tu contraseña para confirmar:'),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount(_passwordController.text);
                _authService.sendPasswordResetEmail(_cliente.correo);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(String password) async {
    try {
      await _authService.reauthenticateAndDelete(_cliente.correo, password);
      // await GestorClientes.eliminarCliente(_cliente.id);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Manejar el error, mostrar mensaje al usuario, etc.
      print("Error al eliminar la cuenta: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al eliminar la cuenta: $e")),
      );
    }
  }
}
