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
  late String _errorMessage;

  Map<String, int> amigosCalorias = {};
  String bookerNombre = '';
  int bookerKcal = 0;

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
    _cargarCaloriasAmigos();
    _determinarBookerDelMes();
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

  Future<void> _determinarBookerDelMes() async {
    List<Cliente> todosLosClientes = await GestorClientes.cargarClientes();

    for (Cliente cliente in todosLosClientes) {
      int kcal = int.parse(cliente.kcalMensual);
      if (kcal > bookerKcal) {
        bookerNombre = cliente.nombre;
        bookerKcal = kcal;
      }
    }

    setState(() {});
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
                Text(
                  'Estadísticas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: _buildPieChartAmigos()),
                    SizedBox(width: 20),
                    Flexible(child: _buildPieChartObjetivo()),
                  ],
                ),
                SizedBox(height: 20),
                EstadisticaItem(
                  titulo: 'Tus Puntos',
                  valor: int.parse(_cliente.kcalMensual),
                  icono: Icons.person,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Text('Puntos de tus Amigos'),
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
                EstadisticaItem(
                  titulo: 'Objetivo Mensual',
                  valor: int.parse(_cliente.objetivomensual),
                  icono: Icons.calendar_today,
                  onTap: _ajustarObjetivoMensual,
                ),
                SizedBox(height: 20),
                _buildBookerDelMes(),
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
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];

    amigosCalorias.forEach((nombre, kcal) {
      sections.add(PieChartSectionData(
        color: _getColorForAmigo(nombre),
        value: kcal.toDouble(),
        title: nombre,
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ));
    });

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: sections,
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildPieChartObjetivo() {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: double.parse(_cliente.kcalMensual),
              title: 'Tú',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.red,
              value: double.parse(_cliente.objetivomensual),
              title: 'Objetivo',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Color _getColorForAmigo(String amigoNombre) {
    int hashCode = amigoNombre.hashCode.abs();
    return Color((hashCode & 0xFFFFFF).toInt()).withOpacity(1.0);
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
              if (value.isNotEmpty && value.length <= 10) {
                if (value.startsWith('0')) {
                  _errorMessage = 'El primer dígito no puede ser 0';
                } else if (double.tryParse(value) != null) {
                  _cliente.objetivomensual = value;
                  _errorMessage = '';
                } else {
                  _errorMessage = 'Carácter no válido';
                }
              } else if (value.isEmpty) {
                _errorMessage = 'El campo no puede estar vacío';
              } else {
                _errorMessage = 'El número no puede tener más de 10 dígitos';
              }
            });
          },
          maxLength: 10,
          decoration: InputDecoration(
            hintText: 'Nuevo Objetivo Mensual',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (_errorMessage.isEmpty) {
                await _guardarObjetivoMensual();
                Navigator.pop(context);
              } else {
                // Mostrar el SnackBar con el mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_errorMessage),
                  ),
                );
              }
            },
            child: Text('Guardar'),
          ),
        ],
      );
    },
  );
}



  Widget _buildBookerDelMes() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Booker del Mes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            bookerNombre,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$bookerKcal kcal',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
