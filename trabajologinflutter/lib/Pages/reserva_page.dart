import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorReserva.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import '../Modelos/maquinas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabajologinflutter/Pages/mapa_page.dart';
import 'package:uuid/uuid.dart';

class ReservaPage extends StatefulWidget {
    late final Cliente cliente;

    ReservaPage({required this.cliente});
  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  late Cliente _cliente;
  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
    tienesGym();
    cargarMaquinas();
    cargarReservas();
  }

  List<Reserva> reservas = [];
  List<Maquina> maquinas = [];
  String? numRepeticionSeleccion;
  String? gymId;

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
  List<String> numRepeticion = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  Map<String, String> nombreToIdMaquina = {};
  List<String> filteredOptions = [];
  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();
  List<RepeticionData> numRepeticionesSeleccionadas = [];

  Future<void> tienesGym() async {
    gymId = _cliente.idgimnasio;
    if (gymId ==null) {
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPage(cliente:widget.cliente),
        ),
      );
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

void filtrarOpciones() {
  var today = DateTime.now();
  var oneHourLater = today.add(Duration(hours: 1));
  var formatter = DateFormat('HH:mm');
  filteredOptions.clear();

  for (var repeticionData in numRepeticionesSeleccionadas) {
    if (repeticionData.fechaSeleccionada != null) {
      String selectedDate = repeticionData.fechaSeleccionada!.split(' ')[0];
      String ahora = DateFormat('dd/MM/yyyy').format(today);
      // Solo filtrar si la fecha seleccionada es igual al día actual
      if (selectedDate==ahora) {
        for (String interval in options1) {
          String intervalStart = interval.split(' - ')[0];
          var intervalStartDateTime = formatter.parse(intervalStart);
          
          if (intervalStartDateTime.hour > oneHourLater.hour ||
              (intervalStartDateTime.hour == oneHourLater.hour &&
                  intervalStartDateTime.minute > oneHourLater.minute)) {
            filteredOptions.add(interval);
          }
        }
      }else{

        for (String interval in options1) {
          String intervalStart = interval.split(' - ')[0];
          var intervalStartDateTime = formatter.parse(intervalStart);
          filteredOptions.add(interval);
        }

      }
    }
  }
}


  void filtrarReservas() {
    for (int i = 0; i < numRepeticionesSeleccionadas.length; i++) {
      var idMaquinaSeleccionada = numRepeticionesSeleccionadas[i].idMaquinaSeleccionada;
      var fechaSeleccionada = numRepeticionesSeleccionadas[i].fechaSeleccionada;
      if (idMaquinaSeleccionada != null && fechaSeleccionada != null) {
        Set<String> intervalosAEliminar = {};

        for (Reserva reserva in reservas) {
          if (reserva.idMaquina == idMaquinaSeleccionada && reserva.fecha == fechaSeleccionada) {
            intervalosAEliminar.addAll(reserva.intervalo.split(','));
          }
        }

        List<String> opcionesFiltradas = filteredOptions.where((intervalo) => !intervalosAEliminar.contains(intervalo)).toList();
        setState(() {
          numRepeticionesSeleccionadas[i].filteredOptions = opcionesFiltradas;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: numRepeticionSeleccion,
                  items: numRepeticion.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      numRepeticionSeleccion = newValue;
                      numRepeticionesSeleccionadas = List.generate(
                        int.parse(newValue!),
                        (index) => RepeticionData(
                          maquinasMostrar: maquinasMostrar,
                          nombreToIdMaquina: nombreToIdMaquina,
                          filteredOptions: [],
                        ),
                      );
                    });
                  },
                  hint: Text('Selecciona número de repetición'),
                ),
                ...numRepeticionesSeleccionadas.map((repeticionData) {
                  return Column(
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
                            value: repeticionData.maquinaSeleccion != null ? repeticionData.maquinasMostrar.firstWhere((nombre) => repeticionData.nombreToIdMaquina[nombre] == repeticionData.idMaquinaSeleccionada) : null,
                            items: repeticionData.maquinasMostrar.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                repeticionData.maquinaSeleccion = newValue;
                                repeticionData.idMaquinaSeleccionada = repeticionData.nombreToIdMaquina[newValue];
                                
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
                          color: repeticionData.maquinaSeleccion != null ? Colors.white : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: repeticionData.maquinaSeleccion != null ? () async {
                                  final DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 28)),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      repeticionData.fechaSeleccionada = DateFormat('dd/MM/yyyy').format(pickedDate);
                                      filtrarOpciones();
                                      filtrarReservas();
                                    });
                                  }
                                } : null,
                                child: Text('Selecciona fecha'),
                              ),
                              SizedBox(width: 10),
                              if (repeticionData.fechaSeleccionada != null)
                                Text(repeticionData.fechaSeleccionada!),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 230,
                        height: 80,
                        decoration: BoxDecoration(
                          color: repeticionData.diaSeleccion != null ? Colors.white : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            value: repeticionData.intervaloSeleccion,
                            items: repeticionData.filteredOptions.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: repeticionData.fechaSeleccionada != null ? (String? newValue) {
                              setState(() {
                                repeticionData.intervaloSeleccion = newValue;
                              });
                            } : null,
                            hint: Text('Selecciona intervalo'),
                            disabledHint: Text('Selecciona fecha primero'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: () {
                    for (var repeticionData in numRepeticionesSeleccionadas) {
                      String? intervalo = repeticionData.intervaloSeleccion;
                      String fecha = repeticionData.fechaSeleccionada!;
                      String reservaId = Uuid().v4();
                      gestionReservas.insertarReservaExterna(reservaId, repeticionData.idMaquinaSeleccionada!, gymId!, intervalo!, fecha);
                    }
                    cargarReservas();
                  },
                  child: Text('Confirmar selección'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RepeticionData {
  String? maquinaSeleccion;
  String? idMaquinaSeleccionada;
  String? fechaSeleccionada;
  String? intervaloSeleccion;
  String? diaSeleccion;
  List<String> maquinasMostrar;
  Map<String, String> nombreToIdMaquina;
  List<String> filteredOptions;

  RepeticionData({
    required this.maquinasMostrar,
    required this.nombreToIdMaquina,
    required this.filteredOptions,
  });
}
