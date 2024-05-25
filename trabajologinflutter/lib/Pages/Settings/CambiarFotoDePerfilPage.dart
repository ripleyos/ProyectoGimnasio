import 'package:flutter/material.dart';
import '../../Gestores/GestorClientes.dart';
import '../../Modelos/Cliente.dart';

class CambiarFotoDePerfilPage extends StatefulWidget {
  final Cliente cliente;

  CambiarFotoDePerfilPage({required this.cliente});

  @override
  _CambiarFotoDePerfilPageState createState() => _CambiarFotoDePerfilPageState();
}

class _CambiarFotoDePerfilPageState extends State<CambiarFotoDePerfilPage> {
  late Cliente _cliente;
  final List<String> imageUrls = [
    'https://i.psnprofiles.com/avatars/m/G08aacb7cb.png',
    'https://i.psnprofiles.com/avatars/m/G9a5c1e2a3.png',
    'https://i.psnprofiles.com/avatars/m/Gfba90ec21.png',
    'https://i.psnprofiles.com/avatars/m/G4613a5e4c.png',
    'https://i.psnprofiles.com/avatars/m/Gcc508906f.png',
    'https://i.psnprofiles.com/avatars/m/G9181b4325.png',
    'https://i.psnprofiles.com/avatars/m/Gd6b182a3d.png',
    'https://i.psnprofiles.com/avatars/m/Gdd8c162c6.png',
  ];

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Imagen de Perfil para ${_cliente.id}'),
        backgroundColor: Colors.black,
      ),
      body: Container(
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
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _updateProfilePicture(context, imageUrls[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateProfilePicture(BuildContext context, String imageUrl) async {
    print("Intentando actualizar imagen a: $imageUrl");
    print(_cliente.id);
    bool result = await GestorClientes.actualizarImagenCliente(_cliente.id, imageUrl);
    if (result) {
      _showSuccessDialog(context);
    } else {
      print("Error al actualizar la imagen del cliente");
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambio exitoso'),
          content: Text('Tus cambios se mostrarán la próxima vez que inicies la app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                Navigator.of(context).pop(); // Regresa a la página anterior
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
