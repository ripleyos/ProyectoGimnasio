import 'package:flutter/material.dart';
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
          // Acción para editar perfil
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
              // Acción para agregar amigos
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
          itemCount: 10, // Reemplazar con la longitud real de la lista de amigos
          itemBuilder: (context, index) {
            return _buildAmigoCard();
          },
        ),
      ],
    );
  }

  Widget _buildAmigoCard() {
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
          backgroundImage: AssetImage('assets/friend_image.jpg'),
        ),
        title: Text('Nombre del Amigo', style: TextStyle(fontSize: 20)),
        subtitle: Text('Peso: 75 kg - Altura: 175 cm', style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.more_vert, color: Colors.deepOrange),
        onTap: () {
          // Acción al hacer clic en un amigo de la lista
        },
      ),
    );
  }
}
