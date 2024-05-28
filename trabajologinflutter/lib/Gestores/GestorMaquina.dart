import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Modelos/maquinas.dart';

class GestionMaquinas {

Future<List<Maquina>> cargarMaquinasExterna() async {
  final response = await http.get(Uri.parse(
      'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<Maquina> maquinas = [];
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        maquinas.add(Maquina.fromJson(value));
        print("lol $maquinas");
      }
    });
    
    return maquinas;
  } else {
    print('Error al cargar las máquinas: ${response.statusCode}');
  }
    return [];
}
Future<List<Maquina>> cargarMaquinas(String gimnasioId) async {
  final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<Maquina> maquinas = [];

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        Maquina maquina = Maquina.fromJson(value);
        if (maquina.idGimnasio == gimnasioId) {
          maquinas.add(maquina);
        }
      }
    });

    return maquinas;
  } else {
    print('Error al cargar las máquinas: ${response.statusCode}');
  }
  return [];
}
  /*Future<void> eliminarMaquina() async {
    final String url =
        'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        print("Máquina eliminada");
      } else {
        print('Error al eliminar máquina: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }
  }*/
}

