import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/maquinas.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import 'package:trabajologinflutter/Gestores/GestorReserva.dart';

class ModificarReservaPage extends StatefulWidget {
  final Cliente cliente;
  final Reserva reserva;

  ModificarReservaPage({required this.cliente, required this.reserva});

  @override
  _ModificarReservaPageState createState() => _ModificarReservaPageState();
}

class _ModificarReservaPageState extends State<ModificarReservaPage> {
  late Cliente cliente;
  late Reserva reserva;
  String? maquinaSeleccionada;
  String? intervaloSeleccionado;
  String? fechaSeleccionada;
  String? idMaquinaSeleccionada;
  List<String> maquinas = [];
  List<Reserva> reservas = [];

  List<String> intervalosDisponibles = [
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
  List<String> filteredOptions = [];
  Map<String, String> nombreToIdMaquina = {};

  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
    cargarMaquinas();
    cargarReservas();
  }

void filtrarOpciones(DateTime? selectedDate) {
  var now = DateTime.now();
  var oneHourLater = now.add(Duration(hours: 1));
  var formatter = DateFormat('HH:mm');
  filteredOptions.clear();

  for (String interval in intervalosDisponibles) {
    String intervalStart = interval.split(' - ')[0];
    var intervalStartDateTime = formatter.parse(intervalStart);

    // Si la fecha seleccionada es hoy
    if (selectedDate != null && selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day) {
      if (intervalStartDateTime.hour > oneHourLater.hour ||
          (intervalStartDateTime.hour == oneHourLater.hour &&
              intervalStartDateTime.minute > oneHourLater.minute)) {
        filteredOptions.add(interval);
      }
    } else { // Si la fecha seleccionada es diferente a hoy, no aplicar filtro
      filteredOptions.add(interval);
    }
  }
}


  Future<void> cargarReservas() async {
    try {
      List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
      setState(() {
        reservas = reservasCargadas;
      });
    } catch (error) {
      print('Error al cargar las reservas: $error');
    }
  }

  void filtrarReservas() {
  if (maquinaSeleccionada != null && fechaSeleccionada != null) {
    // Convertir fecha seleccionada a objeto DateTime
    DateTime selectedDateTime = DateFormat('dd/MM/yyyy').parse(fechaSeleccionada!);

    Set<String> intervalosAEliminar = {};

    for (Reserva reserva in reservas) {
      // Convertir fecha de la reserva a objeto DateTime
      DateTime reservaDateTime = DateFormat('dd/MM/yyyy').parse(reserva.fecha);

      if (reserva.idMaquina == idMaquinaSeleccionada &&
          reserva.fecha == fechaSeleccionada &&
          reserva.idGimnasio == cliente.idgimnasio ) {
        intervalosAEliminar.addAll(reserva.intervalo.split(','));
      }
    }

    setState(() {
      filteredOptions = filteredOptions.where((intervalo) => !intervalosAEliminar.contains(intervalo)).toSet().toList();
    });
  }
}


    Future<void> cargarMaquinas() async {
      try {
        List<Maquina> maquinasCargadas = await gestionMaquinas.cargarMaquinasExterna();
        setState(() {
          maquinas = maquinasCargadas
              .where((maquina) => maquina.idGimnasio == cliente.idgimnasio)
              .map((maquina) => maquina.nombre)
              .toList();
          nombreToIdMaquina = {for (var maquina in maquinasCargadas) maquina.nombre: maquina.idMaquina};
        });
      } catch (error) {
        print('Error al cargar las máquinas: $error');
      }
    }

  Future<void> modificarReserva() async {
    await gestionReservas.modificarReservaExterna(
      widget.reserva.id,
      maquina: nombreToIdMaquina[maquinaSeleccionada],
      intervalo: intervaloSeleccionado,
      fecha: fechaSeleccionada,
    );
    Navigator.pop(context); // Regresar a la pantalla anterior después de modificar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Reserva'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                              DropdownButton<String>(
                  value: maquinaSeleccionada,
                  items: maquinas.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      maquinaSeleccionada = newValue;
                      idMaquinaSeleccionada = nombreToIdMaquina[newValue];
                    });
                  },
                  hint: Text('Selecciona máquina'),
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 28)),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      fechaSeleccionada = DateFormat('dd/MM/yyyy').format(pickedDate);
                      intervaloSeleccionado = null; 

                      filtrarOpciones(pickedDate);
                      filtrarReservas();
                    });
                  }
                },
                child: Text('Selecciona fecha'),
              ),
              SizedBox(height: 10),
              if (fechaSeleccionada != null) Text(fechaSeleccionada!),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: intervaloSeleccionado,
                items: filteredOptions.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: fechaSeleccionada != null ? (String? newValue) {
                  setState(() {
                    intervaloSeleccionado = newValue;
                  });
                } : null,
                hint: Text('Selecciona intervalo'),
                disabledHint: Text('Selecciona fecha primero'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  modificarReserva();
                },
                child: Text('Confirmar modificación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}