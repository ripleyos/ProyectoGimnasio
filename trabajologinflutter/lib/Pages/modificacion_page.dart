// Importa las clases y funciones necesarias
import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';
import 'package:trabajologinflutter/Pages/modificarReserva_page.dart';
import 'reserva_card.dart'; // Asegúrate de tener la clase Cliente importada
import 'package:trabajologinflutter/Gestores/GestorReserva.dart'; // Archivo donde están las funciones cargarReservasExterna y eliminarReserva

class ModificacionReservaPage extends StatefulWidget {
  final Cliente cliente;

  ModificacionReservaPage({required this.cliente});

  @override
  _ModificacionReservaPageState createState() => _ModificacionReservaPageState();
}

class _ModificacionReservaPageState extends State<ModificacionReservaPage> {
  List<Reserva> reservas = [];
  GestionReservas gestionReservas = new GestionReservas();

  @override
  void initState() {
    super.initState();
    cargarReservas();
  }

  Future<void> cargarReservas() async {
    List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();
    setState(() {
      reservas = reservasCargadas.where((reserva) => reserva.idCliente == widget.cliente.correo).toList();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Reservas de ${widget.cliente.nombre}'),
    ),
    body: ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        final reserva = reservas[index];
        return ReservaCard(
          reserva: reserva,
          onModify: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModificarReservaPage(cliente: widget.cliente, reserva: reserva),
                ),
              );
            print('Modificar reserva ${reserva.id}');
          },
          onDelete: () async {
            // Mostrar el diálogo de confirmación
            bool confirmacion = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Eliminar Reserva'),
                  content: Text('¿Estás seguro de que quieres eliminar esta reserva?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Cancelar la eliminación
                      },
                      child: Text('Cancelar', style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Eliminar la reserva si se confirma
                        bool exito = await gestionReservas.eliminarReservaExterna(reserva.id); // Asegúrate de implementar esta función
                        if (exito) {
                          setState(() {
                            reservas.removeWhere((r) => r.id == reserva.id);
                          });
                        }
                        Navigator.of(context).pop(true); // Confirmar la eliminación
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
  );
}

}
