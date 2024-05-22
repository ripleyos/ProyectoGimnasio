import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Modelos/Cliente.dart';

class GestorClientes {
  static Future<List<Cliente>> cargarClientes() async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json';
    final response = await http.get(Uri.parse(url));

    List<Cliente> clientes = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print("Clientes data: $data"); // Registro de depuración

      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          value['id'] = key;
          try {
            clientes.add(Cliente.fromJson(value));
          } catch (e) {
            print("Error parsing client with id $key: $e");
          }
        }
      });

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
}
