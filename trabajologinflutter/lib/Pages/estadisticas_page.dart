import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trabajologinflutter/Gestores/GestorClientes.dart';

import '../Modelos/Cliente.dart';
import '../Widgets/EstadisticaItem.dart';

class EstadisticasPage extends StatefulWidget {
  final Cliente cliente;
  EstadisticasPage({required this.cliente});

  @override
  _EstadisticasPageState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  late Cliente _cliente;
  Map<String, int> amigosCalorias = {};

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
    _cargarCaloriasAmigos();
  }

  Future<void> _cargarCaloriasAmigos() async {
    for (String correo in _cliente.amigos) {
      Cliente? amigo = await GestorClientes.buscarClientePorEmail(correo);
      if (amigo != null) {
        setState(() {
          amigosCalorias[amigo.nombre] = int.parse(amigo.kcalMensual);
        });
      }
    }
  }

  Future<void> _guardarObjetivoMensual() async {
    bool actualizado = await GestorClientes.actualizarCliente(
      _cliente.id,
      objetivomensual: _cliente.objetivomensual,
    );

    if (actualizado) {
      print("Objetivo mensual guardado con éxito.");
    } else {
      print("Error al guardar el objetivo mensual.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _buildPieChartAmigos(),
                SizedBox(height: 20),
                EstadisticaItem(
                  titulo: 'Tus Calorías',
                  valor: int.parse(_cliente.kcalMensual),
                  icono: Icons.person,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Text('Calorías de tus Amigos'),
                    children: amigosCalorias.entries.map((entry) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: EstadisticaItem(
                          titulo: entry.key,
                          valor: entry.value,
                          icono: Icons.group,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                _buildPieChartObjetivo(),
                SizedBox(height: 20),
                EstadisticaItem(
                  titulo: 'Objetivo Mensual',
                  valor: int.parse(_cliente.objetivomensual),
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

  Widget _buildPieChartAmigos() {
    List<PieChartSectionData> sections = [
      PieChartSectionData(
        color: Colors.blue,
        value: double.parse(_cliente.kcalMensual),
        title: 'Tú',
      ),
    ];

    amigosCalorias.forEach((nombre, kcal) {
      sections.add(PieChartSectionData(
        color: _getColorForAmigo(),
        value: kcal.toDouble(),
        title: nombre,
      ));
    });

    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          sections: sections,
        ),
      ),
    );
  }

  Widget _buildPieChartObjetivo() {
    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: double.parse(_cliente.kcalMensual),
              title: 'Tú',
            ),
            PieChartSectionData(
              color: Colors.red,
              value: double.parse(_cliente.objetivomensual),
              title: 'Objetivo Mensual',
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForAmigo() {
    List<Color> colors = [Colors.green, Colors.yellow, Colors.orange, Colors.purple, Colors.cyan];
    return colors[amigosCalorias.length % colors.length];
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
                _cliente.objetivomensual = value;
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
              onPressed: () async {
                await _guardarObjetivoMensual();
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
