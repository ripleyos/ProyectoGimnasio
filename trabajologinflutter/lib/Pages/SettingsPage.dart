import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Pages/Settings/RestablecerContrase%C3%B1a.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'), // Título del AppBar en español
        backgroundColor: Color(0xFFB71C1C), // Rojo oscuro
      ),
      body: Container(
        color: Colors.black, // Fondo negro para toda la página
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            _buildAccountExpansionTile(context),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.notifications,
              title: 'Configuración de Notificaciones', // Título en español
              description: 'Controla tus preferencias de notificación', // Descripción en español
              onTap: () {
                // Acción para la configuración de notificaciones
              },
            ),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.security,
              title: 'Privacidad y Seguridad', // Título en español
              description: 'Ajusta configuraciones de privacidad y seguridad', // Descripción en español
              onTap: () {
                // Acción para privacidad y seguridad
              },
            ),
            SizedBox(height: 16.0), // Espacio entre tarjetas
            _buildSettingsCard(
              context,
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte', // Título en español
              description: 'Obtén ayuda y soporte', // Descripción en español
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
        'Configuración de Cuenta', // Título del desplegable en español
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Texto blanco para fondo negro
        ),
      ),
      leading: Icon(Icons.person, color: Colors.white), // Icono blanco
      children: <Widget>[
        ListTile(
          title: Text(
            'Cambiar Contraseña', // Opción para cambiar contraseña
            style: TextStyle(color: Colors.white), // Texto blanco
          ),
          leading: Icon(Icons.lock, color: Colors.white), // Icono blanco
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordPage()),
            );
          },
        ),
        ListTile(
          title: Text(
            'Eliminar Cuenta', // Opción para eliminar cuenta
            style: TextStyle(color: Colors.white), // Texto blanco
          ),
          leading: Icon(Icons.delete, color: Colors.white), // Icono blanco
          onTap: () {
            // Acción para eliminar la cuenta
          },
        ),
        ListTile(
          title: Text(
            'Cerrar Sesión', // Opción para cerrar sesión
            style: TextStyle(color: Colors.white), // Texto blanco
          ),
          leading: Icon(Icons.exit_to_app, color: Colors.white), // Icono blanco
          onTap: () {
            // Acción para cerrar sesión
          },
        ),
      ],
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required IconData icon, required String title, required String description, required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Color(0xFFB71C1C)), // Icono grande y colorido
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Texto oscuro para contraste
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black, // Texto oscuro para contraste
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black), // Flecha para indicar navegación
        onTap: onTap,
      ),
    );
  }
}
