import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trabajologinflutter/providers/reservas.dart';

class GestionReservas extends StatefulWidget {
  @override
  _GestionReservasState createState() => _GestionReservasState();
  List<Reserva> reservasExterna = [];

    Future<void> insertarReservaExterna(int reserva, int maquina,int gimnasio, String intervalo, int semana, String dia) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';

    Map<String, dynamic> data = {
      "id_reserva": reserva ?? 0,
      "id_maquina": maquina ?? 0,
      "id_gimnasio": gimnasio ?? 0,
      "intervalo": intervalo ?? 0,
      "semana": semana ?? 0,
      "dia": dia ?? 0,
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
          print(reservas);
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

class _GestionReservasState extends State<GestionReservas> {
  final TextEditingController idReservaController = TextEditingController();
  final TextEditingController idMaquinaController = TextEditingController();
  final TextEditingController idGimnasioController = TextEditingController();
  final TextEditingController intervaloController = TextEditingController();
  final TextEditingController semanaController = TextEditingController();

  List<Reserva> reservas = [];

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
          title: const Text("Gestión de Reservas"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: idReservaController,
                  decoration: InputDecoration(labelText: 'ID Reserva'),
                ),
                TextFormField(
                  controller: idMaquinaController,
                  decoration: InputDecoration(labelText: 'ID Máquina'),
                ),
                TextFormField(
                  controller: idGimnasioController,
                  decoration: InputDecoration(labelText: 'ID Gimnasio'),
                ),
                TextFormField(
                  controller: intervaloController,
                  decoration: InputDecoration(labelText: 'Hora de inicio'),
                ),
                TextFormField(
                  controller: semanaController,
                  decoration: InputDecoration(labelText: 'Hora de fin'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        //await insertarReserva();
                      },
                      child: const Text("INSERTAR"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await cargarReservas();
                      },
                      child: const Text("CARGAR"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // await eliminarReserva();
                      },
                      child: const Text("ELIMINAR"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: reservas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('ID Reserva: ${reservas[index].idReserva}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID Máquina: ${reservas[index].idMaquina}'), 
                            Text('ID Gimnasio: ${reservas[index].idGimnasio}'), 
                            Text('intervalo: ${reservas[index].intervalo}'), 
                            Text('semana: ${reservas[index].semana}'), 
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> insertarReservaExterna(int reserva, int maquina, int gimnasio, String hora_inicio, String hora_fin) async {
    await insertarReserva(reserva, maquina, gimnasio, hora_inicio, hora_fin);
  }
  Future<void> insertarReserva(int reserva, int maquina,int gimnasio, String hora_inicio, String hora_fin) async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';

    Map<String, dynamic> data = {
      "id_reserva": reserva ?? 0,
      "id_maquina": maquina ?? 0,
      "id_gimnasio": gimnasio ?? 0,
      "hora_inicio": hora_inicio ?? 0,
      "hora_fin": hora_fin ?? 0,
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

  Future<void> cargarReservas() async {
    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Reserva> tempReservas = [];
      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          tempReservas.add(Reserva.fromJson(value));
        }
      });

      setState(() {
        reservas = tempReservas;
      });
    } else {
      print('Error al cargar las reservas: ${response.statusCode}');
    }
  }
  
}

