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
      print("Clientes data: $data");

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

      print("Clientes cargados: ${clientes.length}");
      return clientes;
    } else {
      throw Exception('Error al cargar los clientes: ${response.statusCode}');
    }
  }
  static Future<void> insertarNuevoCliente(Cliente nuevoCliente) async {
    const String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes.json';
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'nombre': nuevoCliente.nombre,
          'correo': nuevoCliente.correo,
          'imagenUrl': nuevoCliente.imagenUrl,
          'peso': nuevoCliente.peso,
          'kcalMensual': nuevoCliente.kcalMensual,
          'estrellas': nuevoCliente.estrellas,
          'amigos': nuevoCliente.amigos,
          'amigos_pendientes': nuevoCliente.amigosPendientes,
          'objetivomensual': nuevoCliente.objetivomensual,
          'idgimnasio': nuevoCliente.idgimnasio,
          'altura': nuevoCliente.altura,
        }),
      );

      if (response.statusCode == 200) {
        print("Cliente insertado con éxito");
      } else {
        print("Error al insertar cliente: ${response.statusCode}");
      }
  }




  static Future<Cliente?> buscarClientePorEmail(String email) async {
    try {
      List<Cliente> clientes = await cargarClientes();
      print("Buscando cliente con email: $email"); // Registro de depuración

      Cliente? clienteEncontrado = clientes.firstWhere((cliente) => cliente.correo == email);
      if (clienteEncontrado != null) {
        print("Cliente encontrado: ${clienteEncontrado.nombre}");
      } else {
        print("Cliente no encontrado");
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


  static Future<bool> actualizarCliente(String id, {String? nombre, String? correo, String? imagenUrl, String? peso, String? kcalMensual, String? estrellas, List<String>? amigos, List<String>? amigosPendientes, String? objetivomensual, String? idgimnasio, String? altura}) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';

    Map<String, dynamic> data = {};
    if (nombre != null) data['nombre'] = nombre;
    if (correo != null) data['correo'] = correo;
    if (imagenUrl != null) data['imagenUrl'] = imagenUrl;
    if (peso != null) data['peso'] = peso;
    if (kcalMensual != null) data['kcalMensual'] = kcalMensual;
    if (estrellas != null) data['estrellas'] = estrellas;
    if (amigos != null) data['amigos'] = amigos;
    if (amigosPendientes != null) data['amigos_pendientes'] = amigosPendientes;
    if (objetivomensual != null) data['objetivomensual'] = objetivomensual;
    if (idgimnasio != null) data['idgimnasio'] = idgimnasio;
    if (altura != null) data['altura'] = altura;

    try {
      final response = await http.patch(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        print("Cliente actualizado con éxito: $id");
        print("Respuesta del servidor: ${response.body}");
        return true;
      } else {
        print('Error al actualizar cliente: ${response.statusCode}');
        print("Respuesta del servidor: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Error: $error");
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

  static Future<bool> actualizarPesoCliente(String id, String nuevoPeso) async {
    if (nuevoPeso.isEmpty) {
      print("El peso no puede estar vacío.");
      return false;
    }

    final double peso = double.tryParse(nuevoPeso) ?? 0;
    if (peso > 150) {
      return false;
    }
    if (peso < 40) {
      return false;
    }

    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'peso': nuevoPeso}),
    );

    if (response.statusCode == 200) {
      print("Peso del cliente actualizado con éxito: $id");
      return true;
    } else {
      print("Error al actualizar el peso del cliente: ${response.statusCode}");
      return false;
    }
  }

  static Future<bool> actualizarAlturaCliente(String id, String nuevaAltura) async {
    if (nuevaAltura.isEmpty) {
      print("La altura no puede estar vacía.");
      return false;
    }

    final double altura = double.tryParse(nuevaAltura) ?? 0;
    if (altura < 140) {
      print("La altura debe ser un número mayor que cero.");
      return false;
    }if (altura > 230) {
      print("La altura debe ser un número mayor que cero.");
      return false;
    }

    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'altura': nuevaAltura}),
    );

    if (response.statusCode == 200) {
      print("Altura del cliente actualizada con éxito: $id");
      return true;
    } else {
      print("Error al actualizar la altura del cliente: ${response.statusCode}");
      return false;
    }
  }


  static Future<bool> actualizarImagenCliente(String id, String nuevaImagenUrl) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    print('URL de la solicitud: $url');
    print('Nueva URL de imagen: $nuevaImagenUrl');

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({'imagenUrl': nuevaImagenUrl}),
      );

      print('Código de estado de la respuesta: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        print("Imagen del cliente actualizada con éxito: $id");
        return true;
      } else {
        print("Error al actualizar la imagen del cliente: ${response.statusCode}");
        print("Respuesta del servidor: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Excepción durante la solicitud HTTP: $error");
      return false;
    }
  }
  static Future<Cliente?> obtenerBookerDelMes() async {
    try {
      List<Cliente> clientes = await cargarClientes();
      if (clientes.isNotEmpty) {
        clientes.sort((a, b) => int.parse(b.kcalMensual).compareTo(int.parse(a.kcalMensual)));
        return clientes.first;
      }
      return null;
    } catch (error) {
      print("Error obteniendo el Booker del Mes: $error");
      return null;
    }
  }



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
      static Future<void> actualizarGymCliente(String id, String id_gimnasio) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Clientes/$id.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({'idgimnasio': id_gimnasio}),
    );

    if (response.statusCode == 200) {
      print("Imagen del cliente actualizada con éxito: $id");
    } else {
      print("Error al actualizar la imagen del cliente: ${response.statusCode}");
    }
  }
}

