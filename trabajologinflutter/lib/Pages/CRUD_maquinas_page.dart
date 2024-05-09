import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/maquinas.dart';
import 'login_page.dart';

class MaquinasPage extends StatefulWidget {
  @override
  _MaquinasPageState createState() => _MaquinasPageState();
}

class _MaquinasPageState extends State<MaquinasPage>{
  final TextEditingController idMaquinaController = TextEditingController();
  final TextEditingController metIntensoController = TextEditingController();
  final TextEditingController metIntermedioController = TextEditingController();
  final TextEditingController metLigeroController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();

  List<Machine> machines = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CRUD"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: idMaquinaController,
                  decoration: InputDecoration(labelText: 'ID Máquina'),
                ),
                TextFormField(
                  controller: metIntensoController,
                  decoration: InputDecoration(labelText: 'MET Intenso'),
                ),
                TextFormField(
                  controller: metIntermedioController,
                  decoration: InputDecoration(labelText: 'MET Intermedio'),
                ),
                TextFormField(
                  controller: metLigeroController,
                  decoration: InputDecoration(labelText: 'MET Ligero'),
                ),
                TextFormField(
                  controller: marcaController,
                  decoration: InputDecoration(labelText: 'Marca'),
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: tipoController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await insertarMaquina();
                      },
                      child: const Text("INSERTAR"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await cargarMaquinas();
                      },
                      child: const Text("CARGAR"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //await eliminarMaquina();
                      },
                      child: const Text("ELIMINAR"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: machines.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Nombre: ${machines[index].nombre}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marca: ${machines[index].marca}'), 
                            Text('MET Intenso: ${machines[index].metIntenso}'), 
                            Text('Tipo: ${machines[index].tipo}'), 
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> insertarMaquina() async {
  final String url =
      'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';

  Map<String, dynamic> data = {
    "idMaquina": int.tryParse(idMaquinaController.text) ?? 0,
    "metIntenso": int.tryParse(metIntensoController.text) ?? 0,
    "metIntermedio": int.tryParse(metIntermedioController.text) ?? 0,
    "metLigero": int.tryParse(metLigeroController.text) ?? 0,
    "nombre": nombreController.text,
    "marca": marcaController.text,
    "tipo": tipoController.text,
  };

  try {
    final response =
        await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      print("Máquina insertada: ");
      print(response.body);
    } else {
      print('Error al agregar máquina: ${response.statusCode}');
    }
  } catch (error) {
    print("Error: $error");
  }
}

Future<void> cargarMaquinas() async {
  final response = await http.get(Uri.parse(
      'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<Machine> tempMachines = [];
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        tempMachines.add(Machine.fromJson(value));
      }
    });

    setState(() {
      machines = tempMachines;
    });
  } else {
    print('Error al cargar las máquinas: ${response.statusCode}');
  }
}

  /*Future<void> eliminarMaquina() async {
    final String url =
        'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        print("Máquina eliminada");
      } else {
        print('Error al eliminar máquina: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
    }
  }*/
}

