import 'package:http/http.dart' as http;
import 'package:trabajologinflutter/Modelos/Gimnasio.dart';
import 'dart:convert';
import '../Modelos/Cliente.dart';

class GestorGimnasio{

Future<List<Gimnasio>> cargarGimnasios() async {
  final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/Gimnasio.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<Gimnasio> gimnasios = [];

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        gimnasios.add(Gimnasio.fromJson(value));
        print("lol $gimnasios"); // Pasar los datos del gimnasio
      }
    });

    return gimnasios;
  } else {
    print('Error al cargar los gimnasios: ${response.statusCode}');
  }
  return [];
}


}