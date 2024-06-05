import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorGimnasio.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Gestores/GestorReserva.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/Gimnasio.dart';
import 'package:trabajologinflutter/Modelos/maquinas.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';

class ReservaResistenciaPreechaPage extends StatefulWidget {
  final Cliente cliente;

  ReservaResistenciaPreechaPage({required this.cliente});

  @override
  _ReservaResistenciaPreechaPage createState() => _ReservaResistenciaPreechaPage();
}

class _ReservaResistenciaPreechaPage extends State<ReservaResistenciaPreechaPage> {
  late Cliente cliente;
  List<Maquina> maquinasFuerza = [];
  List<Reserva> reservasFuerza = [];
  List<Reserva> reservas = [];
  List<String> filteredOptions = [];
  List<Reserva> reservasUsuario = [];
  bool isLoading = true;

  GestionMaquinas gestionMaquinas = GestionMaquinas();
  GestionReservas gestionReservas = GestionReservas();
  GestorGimnasio gestorGimnasio = GestorGimnasio();

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
  List<String> options2 = [
    '8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
    '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
    '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
    '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
    '12:00 - 12:15', '12:15 - 12:30', '12:30 - 12:45', '12:45 - 13:00',
    '13:00 - 13:15', '13:15 - 13:30', '13:30 - 13:45', '13:45 - 14:00',
    '14:00 - 14:15', '14:15 - 14:30', '14:30 - 14:45', '14:45 - 15:00',
    '15:00 - 15:15', '15:15 - 15:30', '15:30 - 15:45', '15:45 - 16:00',
    '16:00 - 16:15', '16:15 - 16:30',
  ];

  List<String> options3 = [
    '7:00 - 7:15', '7:15 - 7:30', '7:30 - 7:45', '7:45 - 8:00',
    '8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
    '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
    '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
    '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
    '12:00 - 12:15', '12:15 - 12:30', '12:30 - 12:45', '12:45 - 13:00',
    '13:00 - 13:15', '13:15 - 13:30', '13:30 - 13:45', '13:45 - 14:00',
    '14:00 - 14:15', '14:15 - 14:30', '14:30 - 14:45', '14:45 - 15:00',
  ];

  List<String> options4 = [
    '6:00 - 6:15', '6:15 - 6:30', '6:30 - 6:45', '6:45 - 7:00',
    '7:00 - 7:15', '7:15 - 7:30', '7:30 - 7:45', '7:45 - 8:00',
    '8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
    '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
    '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
    '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
    '12:00 - 12:15', '12:15 - 12:30', '12:30 - 12:45', '12:45 - 13:00',
    '13:00 - 13:15', '13:15 - 13:30', '13:30 - 13:45', '13:45 - 14:00',
    '14:00 - 14:15', '14:15 - 14:30', '14:30 - 14:45', '14:45 - 15:00',
  ];

  List<String> options5 = [
    '5:00 - 5:15', '5:15 - 5:30', '5:30 - 5:45', '5:45 - 6:00',
    '6:00 - 6:15', '6:15 - 6:30', '6:30 - 6:45', '6:45 - 7:00',
    '7:00 - 7:15', '7:15 - 7:30', '7:30 - 7:45', '7:45 - 8:00',
    '8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
    '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
    '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
    '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
    '12:00 - 12:15', '12:15 - 12:30', '12:30 - 12:45', '12:45 - 13:00',
    '13:00 - 13:15', '13:15 - 13:30', '13:30 - 13:45', '13:45 - 14:00',
    '14:00 - 14:15', '14:15 - 14:30', '14:30 - 14:45', '14:45 - 15:00',
  ];

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await cargarMaquinas();
    await cargarReservas();
    await cargarReservasUsuario();
    generarReservas();
    setState(() {
      isLoading = false;
    });
  }

  int calcularTotalReservasUsuario() {
    return reservasUsuario.length;
  }

  Future<void> cargarMaquinas() async {
    try {
      List<Maquina> maquinasCargadas = await gestionMaquinas.cargarMaquinasExterna();
      setState(() {
        maquinasFuerza = maquinasCargadas.where((maquina) =>
            maquina.tipo.contains('resistencia') && maquina.idGimnasio == cliente.idgimnasio
        ).toList();
      });
    } catch (error) {
      print('Error al cargar las máquinas: $error');
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

  Future<void> cargarReservasUsuario() async {
    try {
      List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
      setState(() {
        reservasUsuario = reservasCargadas.where((reserva) => reserva.idCliente == cliente.correo).toList();
      });
    } catch (error) {
      print('Error al cargar las reservas: $error');
    }
  }

  void filtrarOpciones() {
    var now = DateTime.now();
    List<String> options;

    switch (cliente.idgimnasio) {
      case '1':
        options = intervalosDisponibles;
        break;
      case '2':
        options = options2;
        break;
      case '3':
        options = options3;
        break;
      case '4':
        options = options4;
        break;
      case '5':
        options = options5;
        break;
      default:
        options = intervalosDisponibles; // O una lista vacía o alguna lista predeterminada.
        break;
    }
    var oneHourLater = now.add(Duration(hours: 1));
    var formatter = DateFormat('HH:mm');
    filteredOptions.clear();

    for (String interval in options) {
      String intervalStart = interval.split(' - ')[0];
      var intervalStartDateTime = formatter.parse(intervalStart);
      var intervalDateTime = DateTime(now.year, now.month, now.day, intervalStartDateTime.hour, intervalStartDateTime.minute);

      if (intervalDateTime.isAfter(oneHourLater)) {
        filteredOptions.add(interval);
      }
    }
  }

  void filtrarReservas(String idMaquina) {
    Set<String> intervalosAEliminar = {};
    var today = DateFormat('dd/MM/yyyy').format(DateTime.now());

    for (Reserva reserva in reservas) {
      if (reserva.idMaquina == idMaquina && reserva.fecha == today) {
        intervalosAEliminar.add(reserva.intervalo);
      }
    }

    setState(() {
      filteredOptions = filteredOptions.where((intervalo) => !intervalosAEliminar.contains(intervalo)).toSet().toList();
      print(filteredOptions);
    });
  }

  void generarReservas() {
    setState(() {
      reservasFuerza = [];
      filtrarOpciones();

      int maquinaIndex = 0;
      for (var maquina in maquinasFuerza) {
        filtrarReservas(maquina.idMaquina);

        // Verifica que hay intervalos disponibles antes de intentar acceder al primer elemento
        if (filteredOptions.isNotEmpty) {
          var intervalo = filteredOptions.first; // Selecciona el primer intervalo
          filteredOptions.removeAt(0); // Elimina el primer intervalo de la lista

          if (reservasFuerza.length >= 6) break; // Límite de 6 reservas

          reservasFuerza.add(Reserva(
            id: '',
            idMaquina: maquina.idMaquina,
            idGimnasio: widget.cliente.idgimnasio,
            fecha: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            intervalo: intervalo,
            idCliente: cliente.correo,
          ));
        }

        maquinaIndex++;
      }
    });
  }

  String siguienteIntervalo(String intervaloActual) {
    final indiceActual = filteredOptions.indexOf(intervaloActual);
    final siguienteIndice = (indiceActual + 1) % filteredOptions.length;
    return filteredOptions[siguienteIndice];
  }

  Future<void> enviarReservas() async {
    try {
      // Calcula el total de reservas del usuario
      final totalReservasUsuario = calcularTotalReservasUsuario();

      // Verifica si la suma de las reservas predefinidas y las reservas del usuario supera el límite de 12
      if (reservasFuerza.length + totalReservasUsuario > 12) {
        // Muestra una advertencia si se supera el límite de reservas
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Advertencia'),
            content: Text('Has superado el límite de reservas activas (12). No se pueden enviar más reservas.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Si no se supera el límite, procede a enviar las reservas
        for (Reserva reserva in reservasFuerza) {
          await gestionReservas.insertarReservaExterna(
            reserva.idMaquina,
            reserva.idGimnasio,
            cliente.correo,
            reserva.intervalo,
            reserva.fecha,
          );
        }
        await cargarReservasUsuario();
        await cargarMaquinas();
        await cargarReservas();
        setState(() {
          generarReservas(); // Regenerar las reservas para actualizar la UI
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Éxito'),
              content: Text('La reserva prehecha se ha realizado con éxito.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error al enviar las reservas: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al enviar las reservas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A0000),
              Color(0xFF460303),
              Color(0xFF730000),
              Color(0xFFA80000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : reservasFuerza.isEmpty
                ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacio lateral
                      child: Center(
                        child: Text(
                          'No quedan reservas disponibles para hoy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0), // Espacio vertical entre los textos
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacio lateral
                      child: Center(
                        child: Text(
                          'Recuerda! Las reservas preechas estan pensadas para que sean del dia actual, asi que si no hay reservas es o porque estan todos los huecos ocupados o el gimnasio ya esta cerrado',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : ListView.builder(
                    itemCount: reservasFuerza.length + 2, // Aumentar el tamaño para incluir el título y botón
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Reserva prehecha de resistencia',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Recuerda! Las reservas preechas estan pensadas para que sean del dia actual, asi que si no hay reservas es o porque estan todos los huecos ocupados o el gimnasio ya esta cerrado',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      } else if (index <= reservasFuerza.length) {
                        Reserva reserva = reservasFuerza[index - 1];
                        Maquina maquina = maquinasFuerza.firstWhere((maquina) => maquina.idMaquina == reserva.idMaquina);
                        return Card(
                          margin: EdgeInsets.all(10.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Máquina: ${maquina.nombre}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text('Marca: ${maquina.marca}', style: TextStyle(fontSize: 16)),
                                Text('Localización: ${maquina.localizacion}', style: TextStyle(fontSize: 16)),
                                Text('Fecha: ${reserva.fecha}', style: TextStyle(fontSize: 16)),
                                Text('Intervalo: ${reserva.intervalo}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: enviarReservas,
                            child: Text('Enviar Reservas'),
                          ),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
