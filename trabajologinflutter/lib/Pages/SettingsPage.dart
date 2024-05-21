import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Pages/login_page.dart'; // Asegúrate de importar la página de inicio de sesión

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.black, // color para el AppBar
      ),
      body: Container(
        color: Colors.black, // Fondo para toda la página
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            _buildAccountExpansionTile(context),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.notifications,
              title: 'Configuración de Notificaciones', // Título
              description: 'Controla tus preferencias de notificación', // Descripcion
              onTap: () {
                // Acción para la configuracion de notificaciones
              },
            ),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.security,
              title: 'Privacidad y Seguridad', // Título en español
              description: 'Ajusta configuraciones de privacidad y seguridad', // Descripcion en español
              onTap: () {
                // Accion para privacidad y seguridad
              },
            ),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte', // Título
              description: 'Obtén ayuda y soporte', // Descripción
              onTap: () {
                // Acción para ayuda y soporte
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
        'Configuración de Cuenta', // Título del desplegable
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Texto blanco para fondo negro
        ),
      ),
      leading: Icon(Icons.person, color: Colors.white), // Icono blanco
      children: <Widget>[
        _buildAccountOption(
          context,
          icon: Icons.lock,
          title: 'Cambiar Contraseña', // Título
          onTap: () {
           // Navigator.push(
          //    context,
          //    MaterialPageRoute(builder: (context) => ChangePasswordPage()),
          //  );
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.delete,
          title: 'Eliminar Cuenta', // Título
          onTap: () {
            // Accion para eliminar la cuenta
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.exit_to_app,
          title: 'Cerrar Sesión', // Título
          onTap: () {
            // Accion para cerrar sesion
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), // Navegar de vuelta a la página de inicio de sesión
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
          color: Colors.white, // Texto blanco
        ),
      ),
      leading: Icon(icon, color: Colors.white), // Icono blanco
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
        leading: Icon(icon, size: 40, color: Colors.orange), // Icono grande
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Texto
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54, // Texto negro suave
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black), // Flecha negra para indicar navegacion
        onTap: onTap,
      ),
    );
  }
}
