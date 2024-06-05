import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Gestores/GestorGimnasio.dart';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/Gimnasio.dart';
import 'package:trabajologinflutter/Modelos/maquinas.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import 'package:trabajologinflutter/Pages/modificarReserva_page.dart';
import 'reserva_card.dart'; 
import 'package:trabajologinflutter/Gestores/GestorReserva.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModificacionReservaPage extends StatefulWidget {
  final Cliente cliente;

  ModificacionReservaPage({required this.cliente});

  @override
  _ModificacionReservaPageState createState() => _ModificacionReservaPageState();
}

class _ModificacionReservaPageState extends State<ModificacionReservaPage> {
  List<Reserva> reservas = [];
  List<Maquina> maquinas = [];
  List<Gimnasio> gimnasios = [];
  GestionReservas gestionReservas = GestionReservas();
  GestionMaquinas gestionMaquinas = GestionMaquinas();
  GestorGimnasio gestorGimnasio = GestorGimnasio();
  bool isLoading = true;  // Variable de estado para el indicador de carga

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await cargarReservas();
    await cargarMaquinas();
    await cargarGimnasios();
    setState(() {
      isLoading = false;  // Datos cargados, ocultar indicador de carga
    });
  }

  Future<void> cargarReservas() async {
    List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
    setState(() {
      reservas = reservasCargadas.where((reserva) => reserva.idCliente == widget.cliente.correo).toList();
    });
  }

  Future<List<Maquina>> cargarMaquinas() async {
    List<Maquina> maquinasCargadas = await gestionMaquinas.cargarMaquinasExterna();
    setState(() {
      maquinas = maquinasCargadas;
    });
    return maquinasCargadas;
  }

  Future<List<Gimnasio>> cargarGimnasios() async {
    List<Gimnasio> gimnasiosCargados = await gestorGimnasio.cargarGimnasios();
    setState(() {
      gimnasios = gimnasiosCargados;
    });
    return gimnasiosCargados;
  }

  String obtenerNombreGimnasio(String idGimnasio) {
    final gimnasio = gimnasios.firstWhere((gimnasio) => gimnasio.id == idGimnasio);
    return gimnasio.nombre;
  }

  Maquina obtenerMaquina(String idMaquina) {
    return maquinas.firstWhere((maquina) => maquina.idMaquina == idMaquina);
  }
  Future<void> navigateToModificarReservaPage(Reserva reserva) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModificarReservaPage(cliente: widget.cliente, reserva: reserva),
      ),
    );

    if (result == true) {
      cargarReservas(); // Recargar las reservas si hubo una modificación
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
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Reservas de ${widget.cliente.nombre}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: reservas.length,
                  itemBuilder: (context, index) {
                    final reserva = reservas[index];
                    final maquina = obtenerMaquina(reserva.idMaquina);
                    final nombreGimnasio = obtenerNombreGimnasio(reserva.idGimnasio);
                    return ReservaCard(
                      reserva: reserva,
                      reservaNumero: index + 1, // Número de reserva
                      maquinaNombre: maquina.nombre,
                      maquinaLocalizacion: maquina.localizacion,
                      maquinaMarca: maquina.marca,
                      nombreGimnasio: nombreGimnasio,
                      onModify: () => navigateToModificarReservaPage(reserva),
                      onDelete: () async {
                        bool confirmacion = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Eliminar Reserva'),
                              content: Text('¿Estás seguro de que quieres eliminar esta reserva?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Cancelar', style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    bool exito = await gestionReservas.eliminarReservaExterna(reserva.id);
                                    if (exito) {
                                      setState(() {
                                        reservas.removeWhere((r) => r.id == reserva.id);
                                      });
                                    }
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Eliminar', style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    ),
  );
}

}
