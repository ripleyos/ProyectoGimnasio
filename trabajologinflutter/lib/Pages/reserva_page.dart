import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorClientes.dart';
import 'package:trabajologinflutter/Gestores/GestorReserva.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/RepeticionData.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import '../Modelos/maquinas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ReservaPage extends StatefulWidget {
  late final Cliente cliente;

  ReservaPage({required this.cliente});
  
  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  late Cliente cliente;
@override
void initState() {
  super.initState();
  cliente = widget.cliente;
  inicializarDatos();
}

Future<void> inicializarDatos() async {
  await cargarMaquinas();
  await cargarReservas();
  await eliminarReservasAntiguas();
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

  List<String> maquinasMostrar = ["q"];
  List<String> numRepeticion = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  Map<String, String> nombreToIdMaquina = {};
  List<String> filteredOptions = [];
  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();
  GestorClientes gestionClientes = GestorClientes();
  List<RepeticionData> numRepeticionesSeleccionadas = [];

  Future<void> tienesGym() async {
    gymId = cliente.idgimnasio;
    if (gymId == "null") {
      return;
    } else {
      print('mal eh');
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPage(cliente: widget.cliente),
        ),
      ); */
    }
  }

Future<void> cargarReservas() async {
  try {
    List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
    setState(() {
      reservas = reservasCargadas;
      ajustarNumRepeticion(); 

      
      for (var reserva in reservas) {
        print('Reserva cargada: ${reserva.id}, Fecha: ${reserva.fecha}, Cliente: ${reserva.idCliente}');
      }
    });
  } catch (error) {
    print('Error al cargar las reservas paco: $error');
  }
}


Future<void> cargarMaquinas() async {
  try {
    List<Maquina> maquinasCargadas = await gestionMaquinas.cargarMaquinasExterna();
    setState(() {
      maquinas = maquinasCargadas.where((maquina) => maquina.idGimnasio == cliente.idgimnasio).toList();
      maquinasMostrar = maquinas.map((maquina) => maquina.nombre).toList();
      nombreToIdMaquina = {for (var maquina in maquinas) maquina.nombre: maquina.idMaquina};
    });
  } catch (error) {
    print('Error al cargar las máquinas: $error');
  }
}
Future<void> eliminarReservasAntiguas() async {
  GestorClientes.cargarClientes;
  var now = DateTime.now();
  var formatter = DateFormat('dd/MM/yyyy');
  var nowFormatted = DateFormat('HH:mm').format(now);


  var reservasClienteActual = reservas.where((reserva) => reserva.idCliente == cliente.correo).toList();

  for (var reserva in reservasClienteActual) {
    var fechaReserva = formatter.parse(reserva.fecha);
    var intervaloFin = reserva.intervalo.split(' - ')[1];
    var fechaHoraReserva = DateTime(
      fechaReserva.year,
      fechaReserva.month,
      fechaReserva.day,
      int.parse(intervaloFin.split(':')[0]), 
      int.parse(intervaloFin.split(':')[1])
    );

    if (fechaHoraReserva.isBefore(now)) {
      print("Eliminando reserva con ID: ${reserva.id}");


      var maquinaAsociada = maquinas.firstWhere((maquina) => maquina.idMaquina == reserva.idMaquina);
      if (maquinaAsociada != null) {

        int puntosAAgregar = 0;
        if (maquinaAsociada.tipo == "fuerza") {
          puntosAAgregar = 100;
        } else if (maquinaAsociada.tipo == "resistencia") {
          puntosAAgregar = 50;
        }


        Cliente clienteAsociado = cliente;

        
        int kcalActual = int.parse(clienteAsociado.kcalMensual);
        int kcalNueva = kcalActual + puntosAAgregar;
        String nuevaKcal = kcalNueva.toString();

       
        await GestorClientes.actualizarPuntosCliente(clienteAsociado.id, nuevaKcal);
      } else {
        print("Error: No se pudo encontrar la máquina asociada a esta reserva");
      }

      
      await gestionReservas.eliminarReservaExterna(reserva.id);
    }
  }

 
  await cargarReservas();
}



  void ajustarNumRepeticion() {
   
    int reservasActuales = reservas.where((reserva) => reserva.idCliente == cliente.correo).length;

    setState(() {
      numRepeticion = List.generate(12 - reservasActuales, (index) => (index + 1).toString());
    });
  }

  void filtrarOpciones(RepeticionData repeticionData) {
  var today = DateTime.now();
  var oneHourLater = today.add(Duration(hours: 1));
  var formatter = DateFormat('HH:mm');
  repeticionData.filteredOptions.clear();

  List<String> options;

  switch (cliente.idgimnasio) {
    case '1':
      options = options1;
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
      options = options1; // O una lista vacía o alguna lista predeterminada.
      break;
  }

  if (repeticionData.fechaSeleccionada != null) {
    String selectedDate = repeticionData.fechaSeleccionada!.split(' ')[0];
    String ahora = DateFormat('dd/MM/yyyy').format(today);

    if (selectedDate == ahora) {
      for (String interval in options) {
        String intervalStart = interval.split(' - ')[0];
        var intervalStartDateTime = formatter.parse(intervalStart);

        if (intervalStartDateTime.hour > oneHourLater.hour ||
            (intervalStartDateTime.hour == oneHourLater.hour &&
                intervalStartDateTime.minute > oneHourLater.minute)) {
          repeticionData.filteredOptions.add(interval);
        }
      }
    } else {
      for (String interval in options) {
        repeticionData.filteredOptions.add(interval);
      }
    }
  } else {
    for (String interval in options) {
      repeticionData.filteredOptions.add(interval);
    }
  }
}

  void filtrarReservas(RepeticionData repeticionData) {
    if (repeticionData.idMaquinaSeleccionada != null && repeticionData.fechaSeleccionada != null) {
      Set<String> intervalosAEliminar = {};

      for (Reserva reserva in reservas) {
        if (reserva.idMaquina == repeticionData.idMaquinaSeleccionada && reserva.fecha == repeticionData.fechaSeleccionada &&
      reserva.idGimnasio == cliente.idgimnasio) {
          intervalosAEliminar.addAll(reserva.intervalo.split(','));
        }
      } 

      List<String> opcionesFiltradas = repeticionData.filteredOptions.where((intervalo) => !intervalosAEliminar.contains(intervalo)).toSet().toList();
      setState(() {
        repeticionData.filteredOptions = opcionesFiltradas;
      });
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
                                      repeticionData.intervaloSeleccion = null;
                                      filtrarOpciones(repeticionData);
                                      filtrarReservas(repeticionData);
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
                  onPressed: () async {
                    // Verificar si hay duplicados en numRepeticionesSeleccionadas
                    bool hayDuplicados = false;

                    for (int i = 0; i < numRepeticionesSeleccionadas.length; i++) {
                      for (int j = i + 1; j < numRepeticionesSeleccionadas.length; j++) {
                        if (numRepeticionesSeleccionadas[i].idMaquinaSeleccionada == numRepeticionesSeleccionadas[j].idMaquinaSeleccionada &&
                            numRepeticionesSeleccionadas[i].fechaSeleccionada == numRepeticionesSeleccionadas[j].fechaSeleccionada &&
                            numRepeticionesSeleccionadas[i].intervaloSeleccion == numRepeticionesSeleccionadas[j].intervaloSeleccion) {
                          hayDuplicados = true;
                          break;
                        }
                      }
                      if (hayDuplicados) break;
                    }

                    if (hayDuplicados) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Advertencia'),
                            content: Text('Hay duplicados en las reservas seleccionadas. Por favor, revisa los datos.'),
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
                    } else {
                      for (var repeticionData in numRepeticionesSeleccionadas) {
                        String? intervalo = repeticionData.intervaloSeleccion;
                        String fecha = repeticionData.fechaSeleccionada!;
                        String clienteId = cliente.correo;
                        await gestionReservas.insertarReservaExterna(repeticionData.idMaquinaSeleccionada!, "1", clienteId, intervalo!, fecha);
                      }

                      setState(() {
                        numRepeticionSeleccion = null; // Reiniciar el valor de numRepeticionSeleccion
                        numRepeticionesSeleccionadas.clear(); // Limpiar la lista de repeticionData
                      });

                      await cargarReservas(); // Recargar las reservas
                    }
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
