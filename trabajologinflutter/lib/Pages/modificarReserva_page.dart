import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Gestores/GestorGimnasio.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/Gimnasio.dart';
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
  String? marcaMaquinaSeleccionada;
  String? localizacionMaquinaSeleccionada;
  String? nombreGimnasio;
  List<String> maquinas = [];
  List<Reserva> reservas = [];
  List<Gimnasio> gimnasios = [];
  Maquina? maquinaActual;

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
  List<String> filteredOptions = [];
  Map<String, String> nombreToIdMaquina = {};
  Map<String, Maquina> nombreToMaquina = {};

  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();
  GestorGimnasio gestorGimnasio = GestorGimnasio();

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await cargarMaquinas();
    await cargarReservas();
    await cargarGimnasios();
    setState(() {
      nombreGimnasio = obtenerNombreGimnasio(widget.reserva.idGimnasio);
      maquinaActual = obtenerMaquina(widget.reserva.idMaquina);
    });
  }

  Future<void> cargarGimnasios() async {
    try {
      List<Gimnasio> gimnasiosCargados = await gestorGimnasio.cargarGimnasios();
      setState(() {
        gimnasios = gimnasiosCargados;
      });
    } catch (error) {
      print('Error al cargar los gimnasios: $error');
    }
  }

  String obtenerNombreGimnasio(String idGimnasio) {
    final gimnasio = gimnasios.firstWhere((gimnasio) => gimnasio.id == idGimnasio);
    return gimnasio.nombre;
  }

  Maquina obtenerMaquina(String idMaquina) {
    return nombreToMaquina.values.firstWhere((maquina) => maquina.idMaquina == idMaquina);
  }

  void filtrarOpciones(DateTime? selectedDate) {
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

      if (selectedDate != null && selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day) {
        if (intervalStartDateTime.hour > oneHourLater.hour ||
            (intervalStartDateTime.hour == oneHourLater.hour &&
                intervalStartDateTime.minute > oneHourLater.minute)) {
          filteredOptions.add(interval);
        }
      } else {
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
      DateTime selectedDateTime = DateFormat('dd/MM/yyyy').parse(fechaSeleccionada!);
      Set<String> intervalosAEliminar = {};

      for (Reserva reserva in reservas) {
        DateTime reservaDateTime = DateFormat('dd/MM/yyyy').parse(reserva.fecha);

        if (reserva.idMaquina == idMaquinaSeleccionada &&
            reserva.fecha == fechaSeleccionada &&
            reserva.idGimnasio == cliente.idgimnasio) {
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
        nombreToMaquina = {for (var maquina in maquinasCargadas) maquina.nombre: maquina};
        maquinaActual = maquinasCargadas.firstWhere((maquina) => maquina.idMaquina == widget.reserva.idMaquina);
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
    Navigator.pop(context,true); // Regresar a la pantalla anterior después de modificar
  }
  Future<bool> _onWillPop() async {
    Navigator.pop(context, true); // Regresar a la pantalla anterior y devolver true
    return false; // Evitar la acción predeterminada de retroceso
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                          SizedBox(height: 20),
                          Text(
            'Modificacion de reserva',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
                if (maquinaActual != null && nombreGimnasio != null) // Mostrar el recuadro solo si la máquina actual está cargada
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reserva Actual:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Máquina: ${maquinaActual!.nombre}', style: TextStyle(fontSize: 16)),
                        Text('Marca: ${maquinaActual!.marca}', style: TextStyle(fontSize: 16)),
                        Text('Localización: ${maquinaActual!.localizacion}', style: TextStyle(fontSize: 16)),
                        Text('Fecha: ${widget.reserva.fecha}', style: TextStyle(fontSize: 16)),
                        Text('Intervalo: ${widget.reserva.intervalo}', style: TextStyle(fontSize: 16)),
                        Text('Gimnasio: $nombreGimnasio', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
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
                            marcaMaquinaSeleccionada = nombreToMaquina[newValue]!.marca;
                            localizacionMaquinaSeleccionada = nombreToMaquina[newValue]!.localizacion;
                          });
                        },
                        hint: Text('Selecciona máquina'),
                      ),
                      if (maquinaSeleccionada != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marca: $marcaMaquinaSeleccionada', style: TextStyle(fontSize: 16)),
                            Text('Localización: $localizacionMaquinaSeleccionada', style: TextStyle(fontSize: 16)),
                          ],
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
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Éxito'),
                              content: Text('La reserva se ha modificado con éxito.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                        },
                        child: Text('Confirmar modificación'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}
