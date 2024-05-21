import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trabajologinflutter/Modelos/reservas.dart';

class GestionReservas {
  List<Reserva> reservasExterna = [];

    Future<void> insertarReservaExterna(String reserva, String maquina,String gimnasio, String intervalo, String fecha) async {
    const String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';

    Map<String, dynamic> data = {
      "id_reserva": reserva ?? "0",
      "id_maquina": maquina ?? "0",
      "id_gimnasio": gimnasio ?? "0",
      "intervalo": intervalo ?? "0",
      "fecha": fecha ?? "0",
    };

    try {
      final response =
          await http.post(Uri.parse(url), body: json.encode(data));

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
          reservas.add(Reserva.fromJson(value));
          print("lol $reservas");
        }
      });

      return reservas;
    } else {
      print('Error al cargar las reservas: ${response.statusCode}');
    }
    return [];
  }

    Future<List<Reserva>> get reservas async {
    return cargarReservasExterna();
  }
  
}


