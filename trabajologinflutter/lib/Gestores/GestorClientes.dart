
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Modelos/Cliente.dart';


class GestorClientes {
  static Future<List<Cliente>> cargarClientes() async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json'; // Reemplaza 'URL_DE_TU_BASE_DE_DATOS' con la URL real de tu base de datos
    final response = await http.get(Uri.parse(url));

    List<Cliente> clientes = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          clientes.add(Cliente.fromJson(value));
        }
      });

      return clientes;
    } else {
      throw Exception('Error al cargar los clientes: ${response.statusCode}');
    }
  }

  static Future<void> insertarCliente(int id, String correo, String nombre, double peso) async {
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

  static Cliente? buscarClientePorEmail(String email, List<Cliente> clientes) {
  //  return clientes.firstWhere((cliente) => cliente.correo == email, orElse: () => null);
  }
}
