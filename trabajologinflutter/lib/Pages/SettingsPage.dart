import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Pages/Settings/CambiarFotoDePerfilPage.dart';
import 'package:trabajologinflutter/Pages/SupportPage.dart';
import 'package:trabajologinflutter/Pages/login_page.dart';
import '../Gestores/GestorClientes.dart';
import '../Modelos/Cliente.dart';
import '../services/auth_service.dart';
import 'Settings/CambiarGimnasioPage.dart';
import 'Settings/PreguntasYRespuestasPage.dart';

class SettingsPage extends StatefulWidget {
  final Cliente cliente;

  SettingsPage({required this.cliente});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Cliente _cliente;
  final _authService = AuthService();
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization=initializeFirebase();
    _cliente = widget.cliente;
  }


  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSettingsPage(context);
          } else {
            return _buildSettingsPage(context);
          }
        },
      ),
    );
  }

  Widget _buildSettingsPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A0000),
              Color(0xFF460303),
              Color(0xFF730000),
              Color(0xFFA80000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildAccountExpansionTile(context),
              SizedBox(height: 16.0),
              _buildProfileExpansionTile(context),
              SizedBox(height: 16.0),
              _buildSettingsCard(
                context,
                icon: Icons.help,
                title: 'Dudas sobre el funcionamiento de la app',
                description: 'Encuentra respuestas a tus dudas',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreguntasYRespuestasPage()),
                  );
                },
              ),
              SizedBox(height: 16.0),
              _buildSettingsCard(
                context,
                icon: Icons.help_outline,
                title: 'Ayuda y Soporte',
                description: 'Obtén ayuda y soporte',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Personalizar Perfil',
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
          icon: Icons.line_weight,
          title: 'Cambiar Peso',
          onTap: () async {
            final TextEditingController _pesoController = TextEditingController();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Cambiar Peso'),
                  content: TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Nuevo Peso'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Guardar'),
                      onPressed: () async {
                        bool success = await GestorClientes.actualizarPesoCliente(_cliente.id, _pesoController.text);
                        if (success) {
                          setState(() {
                            _cliente.peso = _pesoController.text;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Valor de peso no válido')),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.height,
          title: 'Cambiar Altura',
          onTap: () async {
            final TextEditingController _alturaController = TextEditingController();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Cambiar Altura'),
                  content: TextField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Nueva Altura'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Guardar'),
                      onPressed: () async {
                        bool success = await GestorClientes.actualizarAlturaCliente(_cliente.id, _alturaController.text);
                        if (success) {
                          setState(() {
                            _cliente.altura = _alturaController.text;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Valor de altura no válido')),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.abc,
          title: 'Cambiar Nombre',
          onTap: () async {
            final TextEditingController _nombreController = TextEditingController();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Cambiar Nombre'),
                  content: TextField(
                    controller: _nombreController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Nuevo nombre'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Guardar'),
                      onPressed: () async {
                        bool success = await GestorClientes.actualizarNombreCliente(_cliente.id, _nombreController.text);
                        if (success) {
                          setState(() {
                            _cliente.nombre = _nombreController.text;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Valor de altura no válido')),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
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
      ],
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
        /*    // Acción para eliminar la cuenta
            try {
              GestorClientes.eliminarCliente(_cliente.id).then((success) {
                if (success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al eliminar la cuenta")),
                  );
                }
              });
            } catch (e) {
              print(e);
            } */
          },
        ),
        _buildAccountOption(
          context,
          icon: Icons.store,
          title: 'Cambiar Gimnasio',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CambiarGimnasioPage(cliente: this._cliente)), // Agrega la navegación a la página CambiarGimnasioPage
            );
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
        leading: Icon(icon, size: 40, color: Colors.redAccent),
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
}
