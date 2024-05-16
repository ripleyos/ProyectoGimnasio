import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajologinflutter/Pages/CRUD_reservas_page.dart';
import 'package:trabajologinflutter/providers/reservas.dart';

class ReservaPage extends StatefulWidget {
  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  List<Reserva> reservas = [];
  String? intervaloSeleccion;
  int? maquinaSeleccion;
  int? semanaSeleccion;
  String? diaSeleccion;

  List<String> options1 = [
    '9:00 - 9:15',
    '9:15 - 9:30',
    '9:30 - 9:45',
    '9:45 - 10:00',
    '10:00 - 10:15',
    '10:15 - 10:30',
    '10:30 - 10:45',
    '10:45 - 11:00',
    '11:00 - 11:15',
    '11:15 - 11:30',
    '11:30 - 11:45',
    '11:45 - 12:00',
    '12:00 - 12:15',
    '12:15 - 12:30',
    '12:30 - 12:45',
    '12:45 - 13:00',
    '13:00 - 13:15',
    '13:15 - 13:30',
    '15:30 - 15:45',
    '15:45 - 16:00',
    '16:00 - 16:15',
    '16:15 - 16:30',
    '16:30 - 16:45',
    '16:45 - 17:00',
    '17:00 - 17:15',
    '17:15 - 17:30',
    '17:30 - 17:45',
    '17:45 - 18:00',
    '18:00 - 18:15',
    '18:15 - 18:30',
    '18:30 - 18:45',
    '18:45 - 19:00',
    '19:00 - 19:15',
    '19:15 - 19:30',
    '19:30 - 19:45',
    '19:45 - 20:00',
    '20:00 - 20:15',
    '20:15 - 20:30',
  ];
  List<int> options2 = [1, 2, 3];
  List<int> options3 = [1, 2, 3, 4];
  List<String> options4 = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

  List<String> filteredOptions = [];

  GestionReservas gestionReservas = GestionReservas();
  
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
  if (maquinaSeleccion != null && semanaSeleccion != null && diaSeleccion != null) {
    Set<String> intervalosAEliminar = {};

    for (Reserva reserva in reservas) {
      if (reserva.idMaquina == maquinaSeleccion.toString() &&
          reserva.semana == semanaSeleccion.toString() &&
          reserva.dia == diaSeleccion) {
        intervalosAEliminar.addAll(reserva.intervalo.split(','));
      }
    }

    
    List<String> filteredOptionsSet = filteredOptions.toSet().toList();

   
    filteredOptionsSet.removeWhere((intervalo) => intervalosAEliminar.contains(intervalo));

    // Asignar la lista filtrada de intervalos nuevamente a filteredOptions
    filteredOptions = filteredOptionsSet;
  }
}

  

  @override
  void initState() {
    super.initState();
    filtrarOpciones(); 
    cargarReservas();
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
                  child: DropdownButton<int>(
                    items: options2.map((int item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        maquinaSeleccion = newValue!;
                        semanaSeleccion = null;
                        diaSeleccion = null;
                        filtrarReservas();
                      });
                    },
                    value: maquinaSeleccion,
                    hint: Text('Selecciona opción 2'),
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
                  child: DropdownButton<int>(
                    items: options3.map((int item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.toString()),
                      );
                    }).toList(),
                    onChanged: maquinaSeleccion != null ? (int? newValue) {
                      setState(() {
                        semanaSeleccion = newValue!;
                        diaSeleccion = null;
                        filtrarReservas();
                      });
                    } : null,
                    value: semanaSeleccion,
                    hint: Text('Selecciona opción 3'),
                    disabledHint: Text('Selecciona opción 2 primero'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 230,
                height: 80,
                decoration: BoxDecoration(
                  color: semanaSeleccion != null ? Colors.white : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    items: options4.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: semanaSeleccion != null ? (String? newValue) {
                      setState(() {
                        diaSeleccion = newValue!;
                        filtrarReservas();
                      });
                    } : null,
                    value: diaSeleccion,
                    hint: Text('Selecciona opción 4'),
                    disabledHint: Text('Selecciona opción 3 primero'),
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
                    items: filteredOptions.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: diaSeleccion != null ? (String? newValue) {
                      setState(() {
                        intervaloSeleccion = newValue!;
                      });
                    } : null,
                    value: intervaloSeleccion,
                    hint: Text('Selecciona opción 1'),
                    disabledHint: Text('Selecciona opción 4 primero'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (maquinaSeleccion != null && semanaSeleccion != null && diaSeleccion != null)
                    ? () {
                        String maquina= maquinaSeleccion.toString();
                        String semana= semanaSeleccion.toString();
                        String? dia= diaSeleccion;
                        String? intervalo= intervaloSeleccion;

                        gestionReservas.insertarReservaExterna("1", maquina, "2", intervalo!, semana, dia!);
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
