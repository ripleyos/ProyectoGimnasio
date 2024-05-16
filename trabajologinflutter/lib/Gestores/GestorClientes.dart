
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Modelos/Cliente.dart';

class GestionClientes extends StatefulWidget {
  @override
  _GestionClientesState createState() => _GestionClientesState();

  static Cliente? buscarClientePorEmail(String email, List<Cliente> clientes) {
    return clientes.firstWhere((cliente) => cliente.correo == email);
  }
  static List<Cliente> getClientes() {
    return _GestionClientesState().clientes;
  }
}

class _GestionClientesState extends State<GestionClientes> {
  List<Cliente> clientes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Gestión de Clientes"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await cargarClientes();
                  },
                  child: const Text("CARGAR CLIENTES"),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: clientes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('ID: ${clientes[index].id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nombre: ${clientes[index].nombre}'),
                            Text('Correo: ${clientes[index].correo}'),
                            Text('Peso: ${clientes[index].peso}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await insertarClienteExterno(
                      1, // ID del cliente
                      'correo@example.com', // Correo del cliente
                      'Nombre del Cliente', // Nombre del cliente
                      75.0, // Peso del cliente
                    );
                  },
                  child: const Text("INSERTAR CLIENTE"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static List<Cliente> getClientes() {
    return _GestionClientesState().clientes;
  }

  Future<void> cargarClientes() async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json'; // Reemplaza 'URL_DE_TU_BASE_DE_DATOS' con la URL real de tu base de datos
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Cliente> tempClientes = [];
      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          tempClientes.add(Cliente.fromJson(value));
        }
      });

      setState(() {
        clientes = tempClientes;
      });
    } else {
      print('Error al cargar los clientes: ${response.statusCode}');
    }
  }



  Future<void> insertarClienteExterno(int id, String correo, String nombre, double peso) async {
    await insertarCliente(id, correo, nombre, peso);
  }

  Cliente? buscarClientePorEmail(String email) {
    print('Buscando cliente con email: $email');
    print('Clientes disponibles: ${clientes.length}');
    try {
      Cliente? cliente = clientes.firstWhere((cliente) =>
      cliente.correo == email);
      print('Cliente encontrado: ${cliente?.nombre}');
      return cliente;
    } catch (e) {
      print('Error al buscar cliente: $e');
      return null;
    }
  }

  Future<void> mostrarPerfil(String email) async {
    // Buscar cliente por email
    Cliente? cliente = buscarClientePorEmail(email);

    if (cliente != null) {
      // Mostrar el nombre del cliente en la página de perfil
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Perfil de ${cliente.nombre}'),
            content: Text('Email: ${cliente.correo}\nID: ${cliente.id}\nPeso: ${cliente.peso}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } else {
      // Si no se encuentra el cliente, mostrar un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('El cliente con el email $email no se encontró en la base de datos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }


  Future<void> insertarCliente(int id, String correo, String nombre, double peso) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes'; // Reemplaza 'URL_DE_TU_BASE_DE_DATOS' con la URL real de tu base de datos

    Map<String, dynamic> data = {
      "id": id,
      "correo": correo,
      "nombre": nombre,
      "peso": peso,
    };

    try {
      final response =
      await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        print("Cliente insertado correctamente");
      } else {
        print('Error al agregar cliente: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
