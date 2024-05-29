import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Modelos/reservas.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  final int reservaNumero; // Nuevo atributo para el número de reserva
  final String maquinaNombre;
  final String maquinaLocalizacion;
  final String maquinaMarca;
  final String nombreGimnasio;
  final VoidCallback onModify;
  final VoidCallback onDelete;

  ReservaCard({
    required this.reserva,
    required this.reservaNumero,
    required this.maquinaNombre,
    required this.maquinaLocalizacion,
    required this.maquinaMarca,
    required this.nombreGimnasio,
    required this.onModify,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reserva $reservaNumero',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Fecha: ${reserva.fecha}', style: TextStyle(fontSize: 16)),
            Text('Intervalo: ${reserva.intervalo}', style: TextStyle(fontSize: 16)),
            Text('Máquina: $maquinaNombre', style: TextStyle(fontSize: 16)),
            Text('Localización: $maquinaLocalizacion', style: TextStyle(fontSize: 16)),
            Text('Marca: $maquinaMarca', style: TextStyle(fontSize: 16)),
            Text('Gimnasio: $nombreGimnasio', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: onModify,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: Text('Modificar'),
                ),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
