import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Gestores/GestorClientes.dart';
import '../Modelos/Cliente.dart';

class PerfilPage extends StatefulWidget {
  final Cliente cliente;

  PerfilPage({required this.cliente});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Cliente _cliente;

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPerfilHeader(_cliente),
              SizedBox(height: 20),
              _buildAgregarAmigos(),
              SizedBox(height: 20),
              _buildListaAmigos(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoCambioNombre();
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildPerfilHeader(Cliente cliente) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A0000),
            Color(0xFF460303),
            Color(0xFF730000),
            Color(0xFFA80000),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(cliente.imagenUrl),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nombre,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Entusiasta del Fitness',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ciudad, País',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgregarAmigos() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Expanded(
      child: TextFormField(
      decoration: InputDecoration(
        hintText: 'Buscar amigos...',
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      style: TextStyle(color: Colors.white),
    ),
    ),
    SizedBox(width: 10),
    ElevatedButton(
      onPressed: () {
        // Aquí puedes implementar la lógica para buscar y agregar amigos.
      },
      child: Text('Agregar Amigos'),
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.8),
        textStyle: TextStyle(fontSize: 18, color: Colors.deepOrange),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildListaAmigos() {
    return FutureBuilder<List<Cliente>>(
      future: GestorClientes.cargarClientes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Cliente> amigos = _cliente.amigos
              .map((email) => snapshot.data!.firstWhere((cliente) => cliente.correo == email))
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Amigos:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: amigos.length,
                itemBuilder: (context, index) {
                  return _buildAmigoCard(amigos[index]);
                },
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildAmigoCard(Cliente amigo) {
    return Card(
      color: Colors.white.withOpacity(0.85),
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(amigo.imagenUrl),
        ),
        title: Text(amigo.nombre, style: TextStyle(fontSize: 20)),
        subtitle: Text(
          'Peso: ${amigo.peso} - Altura: ${amigo.peso}',
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(Icons.more_vert, color: Colors.deepOrange),
        onTap: () {
          // Acción al hacer clic en un amigo de la lista
        },
      ),
    );
  }

  void _mostrarDialogoCambioNombre() {
    TextEditingController _nombreController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar Nombre'),
          content: TextField(
            controller: _nombreController,
            decoration: InputDecoration(hintText: "Nuevo nombre"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () async {
                String nuevoNombre = _nombreController.text;
                if (nuevoNombre.isNotEmpty) {
                  bool exito =
                  await GestorClientes.actualizarNombreCliente(_cliente.id, nuevoNombre);
                  if (exito) {
                    setState(() {
                      _cliente.nombre = nuevoNombre;
                    });
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  } else {
                    // Manejar error si la actualización no fue exitosa
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}

