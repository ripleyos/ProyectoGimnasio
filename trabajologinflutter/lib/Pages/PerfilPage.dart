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
              SizedBox(height: 20),
              _buildListaAmigosPendientes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerfilHeader(Cliente cliente) {
    int starCount = int.parse(cliente.estrellas);
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
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
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
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Entusiasta del Fitness',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                _buildStarRating(starCount),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgregarAmigos() {
    String email = '';

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
            color: Colors.black.withOpacity(0.2),
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
              onChanged: (value) {
                email = value.trim();
              },
              decoration: InputDecoration(
                hintText: 'Buscar amigos...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              if (email.isNotEmpty) {
                Cliente? cliente = await GestorClientes.buscarClientePorEmail(email);
                if (cliente != null) {
                  String miCorreo = _cliente.correo; // Reemplaza esto con tu propio correo
                  if (!_cliente.amigos.contains(cliente.correo) && !_cliente.amigosPendientes.contains(cliente.correo)) {
                    setState(() {
                      cliente.amigosPendientes.add(miCorreo);
                    });
                    bool exito = await GestorClientes.actualizarAmigos(cliente.id, cliente.amigos, cliente.amigosPendientes);
                    if (exito) {
                      print("Solicitud enviada al cliente");
                    } else {
                      print("Error al enviar la solicitud al cliente");
                    }
                  } else {
                    print("Ya has enviado una solicitud a este cliente o ya eres amigo de él.");
                  }
                } else {
                  print("Cliente no encontrado");
                }
              }
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
          List<Cliente> amigos = snapshot.data!
              .where((cliente) => _cliente.amigos.contains(cliente.correo))
              .toList();
          return amigos.isNotEmpty
              ? Column(
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
          )
              : SizedBox(); // Si no hay amigos, devolver un contenedor vacío
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildListaAmigosPendientes() {
    return FutureBuilder<List<Cliente>>(
      future: GestorClientes.cargarClientes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Cliente> amigosPendientes = snapshot.data!
              .where((cliente) => _cliente.amigosPendientes.contains(cliente.correo))
              .toList();
          return amigosPendientes.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Amigos Pendientes:',
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
                itemCount: amigosPendientes.length,
                itemBuilder: (context, index) {
                  return _buildAmigoPendienteCard(amigosPendientes[index]);
                },
              ),
            ],
          )
              : SizedBox(); // Si no hay amigos pendientes, devolver un contenedor vacío
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
          'Peso: ${amigo.peso} - Altura: ${amigo.altura}',
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(Icons.more_vert, color: Colors.deepOrange),
        onTap: () {
          // Acción al hacer clic en un amigo de la lista
        },
      ),
    );
  }

  Widget _buildAmigoPendienteCard(Cliente amigoPendiente) {
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
          backgroundImage: NetworkImage(amigoPendiente.imagenUrl),
        ),
        title: Text(amigoPendiente.nombre, style: TextStyle(fontSize: 20)),
        subtitle: Text(
          'Peso: ${amigoPendiente.peso} - Altura: ${amigoPendiente.altura}',
          style: TextStyle(fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () async {
                setState(() {
                  _cliente.amigos.add(amigoPendiente.correo);
                  _cliente.amigosPendientes.remove(amigoPendiente.correo);
                });
                bool exito = await GestorClientes.actualizarAmigos(
                    _cliente.id, _cliente.amigos, _cliente.amigosPendientes);
                if (exito) {
                  print("Solicitud de amistad aceptada");
                  // Ahora agregamos el correo del cliente al que se aceptó como amigo
                  amigoPendiente.amigos.add(_cliente.correo);
                  // Eliminamos al cliente actual de la lista de amigos pendientes del cliente que envió la solicitud
                  amigoPendiente.amigosPendientes.remove(_cliente.correo);
                  bool exitoCliente = await GestorClientes.actualizarAmigos(
                      amigoPendiente.id, amigoPendiente.amigos, amigoPendiente.amigosPendientes);
                  if (exitoCliente) {
                    print("Cliente agregado como amigo en la lista del cliente que envió la solicitud");
                  } else {
                    print("Error al agregar cliente como amigo en la lista del cliente que envió la solicitud");
                  }
                } else {
                  print("Error al aceptar la solicitud de amistad");
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () async {
                setState(() {
                  _cliente.amigosPendientes.remove(amigoPendiente.correo);
                });
                bool exito = await GestorClientes.actualizarAmigos(
                    _cliente.id, _cliente.amigos, _cliente.amigosPendientes);
                if (exito) {
                  print("Solicitud de amistad rechazada");
                } else {
                  print("Error al rechazar la solicitud de amistad");
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStarRating(int starCount) {
    List<Widget> stars = List.generate(
      starCount,
          (index) => Icon(Icons.star, color: Colors.yellow, size: 30),
    );

    return Row(
      children: stars,
    );
  }
}
