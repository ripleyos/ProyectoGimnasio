import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorReserva.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import '../Modelos/maquinas.dart';

class ReservaPage extends StatefulWidget {
  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  @override
  void initState() {
    super.initState();
    filtrarOpciones();
    cargarMaquinas();
    cargarReservas();
  }

  List<Reserva> reservas = [];
  List<Maquina> maquinas = [];
  String? intervaloSeleccion;
  String? maquinaSeleccion;
  String? idMaquinaSeleccionada;
  int? semanaSeleccion;
  String? diaSeleccion;
  String? fechaSeleccionada;

  List<String> options1 = [
    '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
    '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
    '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
    '12:00 - 12:15', '12:15 - 12:30', '12:30 - 12:45', '12:45 - 13:00',
    '13:00 - 13:15', '13:15 - 13:30', '15:30 - 15:45', '15:45 - 16:00',
    '16:00 - 16:15', '16:15 - 16:30', '16:30 - 16:45', '16:45 - 17:00',
    '17:00 - 17:15', '17:15 - 17:30', '17:30 - 17:45', '17:45 - 18:00',
    '18:00 - 18:15', '18:15 - 18:30', '18:30 - 18:45', '18:45 - 19:00',
    '19:00 - 19:15', '19:15 - 19:30', '19:30 - 19:45', '19:45 - 20:00',
    '20:00 - 20:15', '20:15 - 20:30',
  ];
  List<String> maquinasMostrar = ["q"];
  Map<String, String> nombreToIdMaquina = {}; // Mapa para almacenar las relaciones nombre -> id

  List<String> filteredOptions = [];

  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();
  
  void filtrarOpciones() {
    var oneHourLater = DateTime.now().add(Duration(hours: 1));
    var formatter = DateFormat('HH:mm');
    filteredOptions.clear();

    for (String interval in options1) {
      String intervalStart = interval.split(' - ')[0];
      var intervalStartDateTime = formatter.parse(intervalStart);

      if (intervalStartDateTime.hour > oneHourLater.hour ||
          (intervalStartDateTime.hour == oneHourLater.hour &&
              intervalStartDateTime.minute > oneHourLater.minute)) {
        filteredOptions.add(interval);
      }
    }

    if (filteredOptions.isNotEmpty && (intervaloSeleccion == null || !filteredOptions.contains(intervaloSeleccion))) {
      intervaloSeleccion = filteredOptions.first;
    }
  }

void filtrarReservas() {
  if (idMaquinaSeleccionada != null && fechaSeleccionada != null) {
    Set<String> intervalosAEliminar = {};

    for (Reserva reserva in reservas) {
      if (reserva.idMaquina == idMaquinaSeleccionada &&
          reserva.fecha == fechaSeleccionada) {
        intervalosAEliminar.addAll(reserva.intervalo.split(','));
      }
    }

    filteredOptions = filteredOptions.where((intervalo) => !intervalosAEliminar.contains(intervalo)).toList();
  }
}


  Future<void> cargarReservas() async {
    try {
      List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
      setState(() {
        reservas = reservasCargadas;
      });
    } catch (error) {
      print('Error al cargar las reservas paco: $error');
    }
  }

  Future<void> cargarMaquinas() async {
    try {
      List<Maquina> maquinasCargadas = await gestionMaquinas.cargarMaquinas();
      setState(() {
        maquinas = maquinasCargadas;
        maquinasMostrar = maquinas.map((maquina) => maquina.nombre).toList();
        nombreToIdMaquina = {for (var maquina in maquinas) maquina.nombre: maquina.idMaquina};
      });
    } catch (error) {
      print('Error al cargar las máquinas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 230,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value:maquinaSeleccion != null ? maquinasMostrar.firstWhere((nombre) => nombreToIdMaquina[nombre] == idMaquinaSeleccionada) : null,
                    items: maquinasMostrar.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        maquinaSeleccion = newValue;
                        idMaquinaSeleccionada = nombreToIdMaquina[newValue];
                        filtrarReservas();
                      });
                    },
                    hint: Text('Selecciona máquina'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 230,
                height: 80,
                decoration: BoxDecoration(
                  color: maquinaSeleccion != null ? Colors.white : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: maquinaSeleccion != null ? () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 28)),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              fechaSeleccionada = DateFormat('dd/MM/yyyy').format(pickedDate);
                              filtrarReservas();
                            });
                          }
                        } : null,
                        child: Text('Selecciona fecha'),
                      ),
                      SizedBox(width: 10),
                      if (fechaSeleccionada != null)
                        Text(fechaSeleccionada!),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 230,
                height: 80,
                decoration: BoxDecoration(
                  color: diaSeleccion != null ? Colors.white : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: intervaloSeleccion,
                    items: filteredOptions.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: fechaSeleccionada != null ? (String? newValue) {
                      setState(() {
                        intervaloSeleccion = newValue;
                      });
                    } : null,
                    hint: Text('Selecciona intervalo'),
                    disabledHint: Text('Selecciona fecha primero'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (maquinaSeleccion != null && fechaSeleccionada != null)
                    ? () {
                        String maquina = maquinaSeleccion.toString();
                        String? intervalo = intervaloSeleccion;
                        String fecha = fechaSeleccionada.toString();
                        gestionReservas.insertarReservaExterna("1", idMaquinaSeleccionada!, "2", intervalo!, fecha);
                        cargarReservas();
                      }
                    : null,
                child: Text('Confirmar selección'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

