import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Widgets/EstadisticaItem.dart';

class EstadisticasPage extends StatefulWidget {
  @override
  _EstadisticasPageState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  int objetivoMensual = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[200]!, Colors.blue[800]!],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Calorías Perdidas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _buildPieChart(),
                SizedBox(height: 20),
                EstadisticaItem(
                  titulo: 'Tus Calorías',
                  valor: 1500,
                  icono: Icons.person,
                ),
                SizedBox(height: 10),
                EstadisticaItem(
                  titulo: 'Calorías de tus Amigos',
                  valor: 2500,
                  icono: Icons.group,
                ),
                SizedBox(height: 10),
                EstadisticaItem(
                  titulo: 'Objetivo Mensual',
                  valor: objetivoMensual,
                  icono: Icons.calendar_today,
                  onTap: _ajustarObjetivoMensual,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 1500,
              title: 'Tú',
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 2500,
              title: 'Amigos',
            ),
          ],
        ),
      ),
    );
  }

  void _ajustarObjetivoMensual() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajustar Objetivo Mensual'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                objetivoMensual = int.tryParse(value) ?? objetivoMensual;
              });
            },
            decoration: InputDecoration(
              hintText: 'Nuevo Objetivo Mensual',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

