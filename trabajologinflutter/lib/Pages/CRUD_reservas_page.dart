import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trabajologinflutter/providers/reservas.dart';

class GestionReservas extends StatefulWidget {
  @override
  _GestionReservasState createState() => _GestionReservasState();
}

class _GestionReservasState extends State<GestionReservas> {
  final TextEditingController idReservaController = TextEditingController();
  final TextEditingController idMaquinaController = TextEditingController();
  final TextEditingController idGimnasioController = TextEditingController();
  final TextEditingController horaInicioController = TextEditingController();
  final TextEditingController horaFinController = TextEditingController();

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
                  controller: horaInicioController,
                  decoration: InputDecoration(labelText: 'Hora de inicio'),
                ),
                TextFormField(
                  controller: horaFinController,
                  decoration: InputDecoration(labelText: 'Hora de fin'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await insertarReserva();
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
                            Text('Hora de inicio: ${reservas[index].horaInicio}'), 
                            Text('Hora de fin: ${reservas[index].horaFin}'), 
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

  Future<void> insertarReserva() async {
    final String url = 'https://tu-url-de-reservas.com/reservas.json';

    Map<String, dynamic> data = {
      "id_reserva": int.tryParse(idReservaController.text) ?? 0,
      "id_maquina": int.tryParse(idMaquinaController.text) ?? 0,
      "id_gimnasio": int.tryParse(idGimnasioController.text) ?? 0,
      "hora_inicio": horaInicioController.text,
      "hora_fin": horaFinController.text,
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
    final String url = 'https://tu-url-de-reservas.com/reservas.json';
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
