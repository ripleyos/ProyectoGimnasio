import 'package:flutter/material.dart';
import 'CRUD_reservas_page.dart';


class ReservaPage extends StatefulWidget{
  @override
  _ReservaPage createState() => _ReservaPage();
}

class _ReservaPage extends State<ReservaPage> {
  final TextEditingController intController = TextEditingController();
  final TextEditingController stringController1 = TextEditingController();
  final TextEditingController stringController2 = TextEditingController();
  late GestionReservas _gestionReservas = GestionReservas();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página con Cajas de Texto y Botones'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: intController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Int',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: stringController1,
              decoration: InputDecoration(
                labelText: 'String 1',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: stringController2,
              decoration: InputDecoration(
                labelText: 'String 2',
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    int? idMaquina = int.tryParse(stringController1.text);
                    String horaInicio = stringController1.text;
                    String horaFin = stringController2.text;  
                    await _gestionReservas.insertarReservaExterna(2,idMaquina!,2,horaInicio,horaFin); 
                  },
                  child: Text('Botón 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text('Botón 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}