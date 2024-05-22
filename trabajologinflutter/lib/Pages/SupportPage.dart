import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool _isEmailExpanded = false;
  bool _isPhoneExpanded = false;
  bool _isChatExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soporte'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSupportOption(
              context,
              icon: Icons.mail,
              title: 'Enviar correo electrónico',
              description: 'Haz clic aquí para enviar un correo electrónico a nuestro equipo de soporte.',
              onTap: () {
                setState(() {
                  _isEmailExpanded = !_isEmailExpanded;
                  _isPhoneExpanded = false;
                  _isChatExpanded = false;
                });
              },
              isExpanded: _isEmailExpanded,
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'javierzamora@elcampico.org',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'sergiovera@elcampico.org',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildSupportOption(
              context,
              icon: Icons.phone,
              title: 'Llamar al servicio de atención al cliente',
              description: 'Haz clic aquí para ver nuestros números de contacto.',
              onTap: () {
                setState(() {
                  _isPhoneExpanded = !_isPhoneExpanded;
                  _isEmailExpanded = false;
                  _isChatExpanded = false;
                });
              },
              isExpanded: _isPhoneExpanded,
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    '644 468 368',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '653 572 312',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildSupportOption(
              context,
              icon: Icons.chat,
              title: 'Chatea con nosotros en Discord',
              description: 'Haz clic aquí para chatear con nosotros en tiempo real a través de Discord.',
              onTap: () {
                setState(() {
                  _isChatExpanded = !_isChatExpanded;
                  _isEmailExpanded = false;
                  _isPhoneExpanded = false;
                });
              },
              isExpanded: _isChatExpanded,
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  _buildDiscordProfile('Javigum1', '@javigum1'),
                  SizedBox(height: 8.0),
                  _buildDiscordProfile('Montesino', '@montesino'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption(BuildContext context, {required IconData icon, required String title, required String description, required VoidCallback onTap, required bool isExpanded, required Widget expandedContent}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(icon, size: 40, color: Colors.orange),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) expandedContent,
        ],
      ),
    );
  }

  Widget _buildDiscordProfile(String name, String username) {
    return Row(
      children: [
        CircleAvatar(
          // Aquí puedes colocar las imágenes de perfil si las tienes
          backgroundColor: Colors.grey, // Colocamos un color gris por defecto
          radius: 20,
        ),
        SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
