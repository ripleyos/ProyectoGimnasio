import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trabajologinflutter/Modelos/reservas.dart';

class GestionReservas {
  List<Reserva> reservasExterna = [];

Future<void> insertarReservaExterna(String maquina, String gimnasio, String clienteId, String intervalo, String fecha) async {
  const String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';

  Map<String, dynamic> data = {
    "id_maquina": maquina,
    "id_gimnasio": gimnasio,
    "id_cliente": clienteId,
    "intervalo": intervalo,
    "fecha": fecha,
  };

  try {
    final response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      print("Reserva insertada: ");
      print(response.body);
    } else {
      print('Error al agregar reserva: ${response.statusCode}');
    }
  } catch (error) {
    print("Error: $error");
  }
}

Future<List<Reserva>> cargarReservasExterna() async {
  final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<Reserva> reservas = [];

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        reservas.add(Reserva.fromJson(key, value)); // Pasar la clave Firebase como ID
      }
    });

    return reservas;
  } else {
    print('Error al cargar las reservas: ${response.statusCode}');
  }
  return [];
}


Future<bool> eliminarReservaExterna(String id) async {
  final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas/$id.json';

  try {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Reserva eliminada: $id");
      print("Respuesta del servidor: ${response.body}");
      return true;
    } else {
      print('Error al eliminar reserva: ${response.statusCode}');
      print("Respuesta del servidor: ${response.body}");
      return false;
    }
  } catch (error) {
    return false;
    print("Error: $error");
  }
} 
    Future<bool> modificarReservaExterna(String id, {String? maquina, String? gimnasio, String? clienteId, String? intervalo, String? fecha}) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas/$id.json';

    Map<String, dynamic> data = {};
    if (maquina != null) data['id_maquina'] = maquina;
    if (gimnasio != null) data['id_gimnasio'] = gimnasio;
    if (clienteId != null) data['id_cliente'] = clienteId;
    if (intervalo != null) data['intervalo'] = intervalo;
    if (fecha != null) data['fecha'] = fecha;

    try {
      final response = await http.patch(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        print("Reserva modificada: $id");
        print("Respuesta del servidor: ${response.body}");
        return true;
      } else {
        print('Error al modificar reserva: ${response.statusCode}');
        print("Respuesta del servidor: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }




    Future<List<Reserva>> get reservas async {
    return cargarReservasExterna();
  }
  
}

