import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPerfilHeader(),
            SizedBox(height: 20),
            _buildAgregarAmigos(),
            SizedBox(height: 20),
            _buildListaAmigos(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfilHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile_image.jpg'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre de Usuario',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  'Peso: 70 kg',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  'Altura: 170 cm',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgregarAmigos() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Buscar amigos...',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // Acción para agregar amigos
            },
            child: Text('Agregar Amigos'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaAmigos() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10, // Reemplazar con la longitud real de la lista de amigos
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/friend_image.jpg'),
            ),
            title: Text('Nombre del Amigo', style: TextStyle(color: Colors.black87)),
            subtitle: Text('Peso: 75 kg - Altura: 175 cm', style: TextStyle(color: Colors.black87)),
            trailing: Icon(Icons.more_vert, color: Colors.blue),
            onTap: () {
              // Acción al hacer clic en un amigo de la lista
            },
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PerfilPage(),
  ));
}
