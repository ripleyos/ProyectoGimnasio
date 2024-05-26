import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Modelos/Cliente.dart';

class GestorClientes {
  static Future<List<Cliente>> cargarClientes() async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json';
    final response = await http.get(Uri.parse(url));

    List<Cliente> clientes = [];

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print("Clientes data: $data"); // Registro de depuración

      if (data is Map<String, dynamic>) {
        // Si la respuesta es un objeto JSON que contiene los clientes
        data.forEach((key, value) {
          if (value is Map<String, dynamic>) {
            try {
              clientes.add(Cliente.fromJson(key, value));
            } catch (e) {
              print("Error parsing client: $e");
            }
          } else {
            print("Valor del mapa no es un objeto JSON");
          }
        });
      } else {
        print("Respuesta del servidor en un formato no reconocido");
      }

      print("Clientes cargados: ${clientes.length}"); // Registro de depuración
      return clientes;
    } else {
      throw Exception('Error al cargar los clientes: ${response.statusCode}');
    }
  }




  static Future<Cliente?> buscarClientePorEmail(String email) async {
    try {
      List<Cliente> clientes = await cargarClientes();
      print("Buscando cliente con email: $email"); // Registro de depuración

      Cliente? clienteEncontrado = clientes.firstWhere((cliente) => cliente.correo == email);
      if (clienteEncontrado != null) {
        print("Cliente encontrado: ${clienteEncontrado.nombre}"); // Registro de depuración
      } else {
        print("Cliente no encontrado"); // Registro de depuración
      }
      return clienteEncontrado;
    } catch (error) {
      print("Error buscando cliente: $error");
      return null;
    }
  }

  static Future<bool> actualizarNombreCliente(String id, String nuevoNombre) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'nombre': nuevoNombre}),
    );

    if (response.statusCode == 200) {
      print("Nombre del cliente actualizado con éxito: $id");
      return true;
    } else {
      print("Error al actualizar el nombre del cliente: ${response.statusCode}");
      return false;
    }
  }
  static Future<bool> actualizarAmigos(String id, List<String> amigos, List<String> amigosPendientes) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'amigos': amigos, 'amigos_pendientes': amigosPendientes}),
    );

    if (response.statusCode == 200) {
      print("Amigos y amigos pendientes actualizados con éxito para el cliente: $id");
      return true;
    } else {
      print("Error al actualizar amigos y amigos pendientes para el cliente: ${response.statusCode}");
      return false;
    }
  }


  static Future<bool> actualizarCliente(String id, Cliente cliente) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      print("Cliente actualizado con éxito: $id");
      return true;
    } else {
      print("Error al actualizar el cliente: ${response.statusCode}");
      return false;
    }
  }
  static Future<bool> eliminarCliente(String id) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    print(url);
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Cliente eliminado con éxito: $id");
      return true;
    } else {
      print("Error al eliminar el cliente: ${response.statusCode}");
      return false;
    }
  }

  static Future<bool> actualizarImagenCliente(String id, String nuevaImagenUrl) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    print(url);
    print(nuevaImagenUrl);
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'imagenUrl': nuevaImagenUrl}),
    );

    if (response.statusCode == 200) {
      print("Imagen del cliente actualizada con éxito: $id");
      return true;
    } else {
      print("Error al actualizar la imagen del cliente: ${response.statusCode}");
      print("Respuesta del servidor: ${response.body}");
      return false;
    }
  }

<<<<<<< HEAD
    static Future<void> actualizarPuntosCliente(String id, String puntos) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'kcal': puntos}),
    );

    if (response.statusCode == 200) {
      print("Imagen del cliente actualizada con éxito: $id");
    } else {
      print("Error al actualizar la imagen del cliente: ${response.statusCode}");
    }
  }
=======
>>>>>>> 8434ea30a6b1c6b6c9824830735c6b05c9c0ada6

}

