[1mdiff --git a/trabajologinflutter/lib/Gestores/GestorClientes.dart b/trabajologinflutter/lib/Gestores/GestorClientes.dart[m
[1mindex 611110a..c829dc0 100644[m
[1m--- a/trabajologinflutter/lib/Gestores/GestorClientes.dart[m
[1m+++ b/trabajologinflutter/lib/Gestores/GestorClientes.dart[m
[36m@@ -71,7 +71,7 @@[m [mclass _GestionClientesState extends State<GestionClientes> {[m
                       1, // ID del cliente[m
                       'correo@example.com', // Correo del cliente[m
                       'Nombre del Cliente', // Nombre del cliente[m
[31m-                      75.0, // Peso del cliente[m
[32m+[m[32m                      75.0,[m[41m [m
                     );[m
                   },[m
                   child: const Text("INSERTAR CLIENTE"),[m
[1mdiff --git a/trabajologinflutter/lib/Modelos/Cliente.dart b/trabajologinflutter/lib/Modelos/Cliente.dart[m
[1mindex 7bb6ed2..b039384 100644[m
[1m--- a/trabajologinflutter/lib/Modelos/Cliente.dart[m
[1m+++ b/trabajologinflutter/lib/Modelos/Cliente.dart[m
[36m@@ -1,8 +1,8 @@[m
 class Cliente {[m
   final String correo;[m
[31m-  final int id;[m
[32m+[m[32m  final String id;[m
   final String nombre;[m
[31m-  final double peso;[m
[32m+[m[32m  final String peso;[m
   final String? telefono;[m
 [m
   Cliente({[m
[36m@@ -18,7 +18,7 @@[m [mclass Cliente {[m
       correo: json['correo'],[m
       id: json['id'],[m
       nombre: json['nombre'],[m
[31m-      peso: json['peso'].toDouble(),[m
[32m+[m[32m      peso: json['peso'],[m
       telefono: json['telefono'],[m
     );[m
   }[m
[1mdiff --git a/trabajologinflutter/lib/Pages/CRUD_maquinas_page.dart b/trabajologinflutter/lib/Pages/CRUD_maquinas_page.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..dec1737[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/Pages/CRUD_maquinas_page.dart[m
[36m@@ -0,0 +1,186 @@[m
[32m+[m[32mimport 'package:flutter/material.dart';[m
[32m+[m[32mimport 'package:http/http.dart' as http;[m
[32m+[m[32mimport 'dart:convert';[m
[32m+[m[32mimport '../providers/maquinas.dart';[m
[32m+[m[32mimport 'login_page.dart';[m
[32m+[m
[32m+[m[32mclass MaquinasPage extends StatefulWidget {[m
[32m+[m[32m  @override[m
[32m+[m[32m  _MaquinasPageState createState() => _MaquinasPageState();[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mclass _MaquinasPageState extends State<MaquinasPage>{[m
[32m+[m[32m  final TextEditingController idMaquinaController = TextEditingController();[m
[32m+[m[32m  final TextEditingController metIntensoController = TextEditingController();[m
[32m+[m[32m  final TextEditingController metIntermedioController = TextEditingController();[m
[32m+[m[32m  final TextEditingController metLigeroController = TextEditingController();[m
[32m+[m[32m  final TextEditingController marcaController = TextEditingController();[m
[32m+[m[32m  final TextEditingController nombreController = TextEditingController();[m
[32m+[m[32m  final TextEditingController tipoController = TextEditingController();[m
[32m+[m
[32m+[m[32m  List<Machine> machines = [];[m
[32m+[m
[32m+[m[32m  @override[m
[32m+[m[32m  Widget build(BuildContext context) {[m
[32m+[m[32m    return MaterialApp([m
[32m+[m[32m      title: 'Flutter Demo',[m
[32m+[m[32m      theme: ThemeData([m
[32m+[m[32m        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),[m
[32m+[m[32m        useMaterial3: true,[m
[32m+[m[32m      ),[m
[32m+[m[32m      home: Scaffold([m
[32m+[m[32m        appBar: AppBar([m
[32m+[m[32m          title: const Text("CRUD"),[m
[32m+[m[32m        ),[m
[32m+[m[32m        body: Center([m
[32m+[m[32m          child: Padding([m
[32m+[m[32m            padding: const EdgeInsets.all(16.0),[m
[32m+[m[32m            child: Column([m
[32m+[m[32m              mainAxisAlignment: MainAxisAlignment.center,[m
[32m+[m[32m              children: [[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: idMaquinaController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'ID Máquina'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: metIntensoController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'MET Intenso'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: metIntermedioController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'MET Intermedio'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: metLigeroController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'MET Ligero'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: marcaController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'Marca'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: nombreController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'Nombre'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                TextFormField([m
[32m+[m[32m                  controller: tipoController,[m
[32m+[m[32m                  decoration: InputDecoration(labelText: 'Tipo'),[m
[32m+[m[32m                ),[m
[32m+[m[32m                const SizedBox(height: 20),[m
[32m+[m[32m                Row([m
[32m+[m[32m                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,[m
[32m+[m[32m                  children: [[m
[32m+[m[32m                    ElevatedButton([m
[32m+[m[32m                      onPressed: () async {[m
[32m+[m[32m                        await insertarMaquina();[m
[32m+[m[32m                      },[m
[32m+[m[32m                      child: const Text("INSERTAR"),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                    ElevatedButton([m
[32m+[m[32m                      onPressed: () async {[m
[32m+[m[32m                        await cargarMaquinas();[m
[32m+[m[32m                      },[m
[32m+[m[32m                      child: const Text("CARGAR"),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                    ElevatedButton([m
[32m+[m[32m                      onPressed: () async {[m
[32m+[m[32m                        //await eliminarMaquina();[m
[32m+[m[32m                      },[m
[32m+[m[32m                      child: const Text("ELIMINAR"),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                  ],[m
[32m+[m[32m                ),[m
[32m+[m[32m                const SizedBox(height: 20),[m
[32m+[m[32m                Expanded([m
[32m+[m[32m                  child: ListView.builder([m
[32m+[m[32m                    itemCount: machines.length,[m
[32m+[m[32m                    itemBuilder: (context, index) {[m
[32m+[m[32m                      return ListTile([m
[32m+[m[32m                        title: Text('Nombre: ${machines[index].nombre}'),[m
[32m+[m[32m                        subtitle: Column([m
[32m+[m[32m                          crossAxisAlignment: CrossAxisAlignment.start,[m
[32m+[m[32m                          children: [[m
[32m+[m[32m                            Text('Marca: ${machines[index].marca}'),[m[41m [m
[32m+[m[32m                            Text('MET Intenso: ${machines[index].metIntenso}'),[m[41m [m
[32m+[m[32m                            Text('Tipo: ${machines[index].tipo}'),[m[41m [m
[32m+[m[32m                          ],[m
[32m+[m[32m                        ),[m
[32m+[m[32m                      );[m
[32m+[m[32m                    },[m
[32m+[m[32m                  ),[m
[32m+[m[32m                ),[m
[32m+[m[32m              ],[m
[32m+[m[32m            ),[m
[32m+[m[32m          ),[m
[32m+[m[32m        ),[m
[32m+[m[32m      ),[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m
[32m+[m[32m  Future<void> insertarMaquina() async {[m
[32m+[m[32m  final String url =[m
[32m+[m[32m      'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';[m
[32m+[m
[32m+[m[32m  Map<String, dynamic> data = {[m
[32m+[m[32m    "idMaquina": int.tryParse(idMaquinaController.text) ?? 0,[m
[32m+[m[32m    "metIntenso": int.tryParse(metIntensoController.text) ?? 0,[m
[32m+[m[32m    "metIntermedio": int.tryParse(metIntermedioController.text) ?? 0,[m
[32m+[m[32m    "metLigero": int.tryParse(metLigeroController.text) ?? 0,[m
[32m+[m[32m    "nombre": nombreController.text,[m
[32m+[m[32m    "marca": marcaController.text,[m
[32m+[m[32m    "tipo": tipoController.text,[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  try {[m
[32m+[m[32m    final response =[m
[32m+[m[32m        await http.post(Uri.parse(url), body: json.encode(data));[m
[32m+[m
[32m+[m[32m    if (response.statusCode == 200) {[m
[32m+[m[32m      print("Máquina insertada: ");[m
[32m+[m[32m      print(response.body);[m
[32m+[m[32m    } else {[m
[32m+[m[32m      print('Error al agregar máquina: ${response.statusCode}');[m
[32m+[m[32m    }[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    print("Error: $error");[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mFuture<void> cargarMaquinas() async {[m
[32m+[m[32m  final response = await http.get(Uri.parse([m
[32m+[m[32m      'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json'));[m
[32m+[m[32m  if (response.statusCode == 200) {[m
[32m+[m[32m    final Map<String, dynamic> data = json.decode(response.body);[m
[32m+[m
[32m+[m[32m    List<Machine> tempMachines = [];[m
[32m+[m[32m    data.forEach((key, value) {[m
[32m+[m[32m      if (value is Map<String, dynamic>) {[m
[32m+[m[32m        tempMachines.add(Machine.fromJson(value));[m
[32m+[m[32m      }[m
[32m+[m[32m    });[m
[32m+[m
[32m+[m[32m    setState(() {[m
[32m+[m[32m      machines = tempMachines;[m
[32m+[m[32m    });[m
[32m+[m[32m  } else {[m
[32m+[m[32m    print('Error al cargar las máquinas: ${response.statusCode}');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m  /*Future<void> eliminarMaquina() async {[m
[32m+[m[32m    final String url =[m
[32m+[m[32m        'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/maquinas.json';[m
[32m+[m[32m    try {[m
[32m+[m[32m      final response = await http.delete(Uri.parse(url));[m
[32m+[m[32m      if (response.statusCode == 200) {[m
[32m+[m[32m        print("Máquina eliminada");[m
[32m+[m[32m      } else {[m
[32m+[m[32m        print('Error al eliminar máquina: ${response.statusCode}');[m
[32m+[m[32m      }[m
[32m+[m[32m    } catch (error) {[m
[32m+[m[32m      print("Error: $error");[m
[32m+[m[32m    }[m
[32m+[m[32m  }*/[m
[32m+[m[32m}[m
[32m+[m
[1mdiff --git a/trabajologinflutter/lib/Pages/CRUD_reservas_page.dart b/trabajologinflutter/lib/Pages/CRUD_reservas_page.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..bbcd304[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/Pages/CRUD_reservas_page.dart[m
[36m@@ -0,0 +1,64 @@[m
[32m+[m[32mimport 'package:flutter/material.dart';[m
[32m+[m[32mimport 'package:http/http.dart' as http;[m
[32m+[m[32mimport 'dart:convert';[m
[32m+[m[32mimport 'package:trabajologinflutter/providers/reservas.dart';[m
[32m+[m
[32m+[m[32mclass GestionReservas {[m
[32m+[m[32m  List<Reserva> reservasExterna = [];[m
[32m+[m
[32m+[m[32m    Future<void> insertarReservaExterna(String reserva, String maquina,String gimnasio, String intervalo, String semana, String dia) async {[m
[32m+[m[32m    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';[m
[32m+[m
[32m+[m[32m    Map<String, dynamic> data = {[m
[32m+[m[32m      "id_reserva": reserva ?? 0,[m
[32m+[m[32m      "id_maquina": maquina ?? 0,[m
[32m+[m[32m      "id_gimnasio": gimnasio ?? 0,[m
[32m+[m[32m      "intervalo": intervalo ?? 0,[m
[32m+[m[32m      "semana": semana ?? 0,[m
[32m+[m[32m      "dia": dia ?? 0,[m
[32m+[m[32m    };[m
[32m+[m
[32m+[m[32m    try {[m
[32m+[m[32m      final response =[m
[32m+[m[32m          await http.post(Uri.parse(url), body: json.encode(data));[m
[32m+[m
[32m+[m[32m      if (response.statusCode == 200) {[m
[32m+[m[32m        print("Reserva insertada: ");[m
[32m+[m[32m        print(response.body);[m
[32m+[m[32m      } else {[m
[32m+[m[32m        print('Error al agregar reserva: ${response.statusCode}');[m
[32m+[m[32m      }[m
[32m+[m[32m    } catch (error) {[m
[32m+[m[32m      print("Error: $error");[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  Future<List<Reserva>> cargarReservasExterna() async {[m
[32m+[m[32m    final String url = 'https://gimnasio-bd045-default-rtdb.europe-west1.firebasedatabase.app/reservas.json';[m
[32m+[m[32m    final response = await http.get(Uri.parse(url));[m
[32m+[m
[32m+[m[32m    if (response.statusCode == 200) {[m
[32m+[m[32m      final Map<String, dynamic> data = json.decode(response.body);[m
[32m+[m[32m      List<Reserva> reservas = [];[m
[32m+[m
[32m+[m[32m      data.forEach((key, value) {[m
[32m+[m[32m        if (value is Map<String, dynamic>) {[m
[32m+[m[32m          reservas.add(Reserva.fromJson(value));[m
[32m+[m[32m          print(reservas);[m
[32m+[m[32m        }[m
[32m+[m[32m      });[m
[32m+[m
[32m+[m[32m      return reservas;[m
[32m+[m[32m    } else {[m
[32m+[m[32m      print('Error al cargar las reservas: ${response.statusCode}');[m
[32m+[m[32m    }[m
[32m+[m[32m    return [];[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m    Future<List<Reserva>> get reservas async {[m
[32m+[m[32m    return cargarReservasExterna();[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m}[m
[32m+[m
[32m+[m
[1mdiff --git a/trabajologinflutter/lib/Pages/estadistica_page.dart b/trabajologinflutter/lib/Pages/estadistica_page.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..2acd3ca[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/Pages/estadistica_page.dart[m
[36m@@ -0,0 +1,44 @@[m
[32m+[m[32mimport 'package:flutter/material.dart';[m
[32m+[m
[32m+[m[32mclass CircularProgressBar extends StatelessWidget {[m
[32m+[m[32m  final double objective; // Objetivo total[m
[32m+[m[32m  final double progress; // Progreso actual[m
[32m+[m
[32m+[m[32m  CircularProgressBar({required this.objective, required this.progress});[m
[32m+[m
[32m+[m[32m  @override[m
[32m+[m[32m  Widget build(BuildContext context) {[m
[32m+[m[32m    double percentage = (progress / objective).clamp(0.0, 1.0); // Calcula el porcentaje de progreso[m
[32m+[m
[32m+[m[32m    return Center([m
[32m+[m[32m      child: SizedBox([m
[32m+[m[32m        width: 200, // Ancho del círculo[m
[32m+[m[32m        height: 200, // Alto del círculo[m
[32m+[m[32m        child: Stack([m
[32m+[m[32m          fit: StackFit.expand,[m
[32m+[m[32m          children: [[m
[32m+[m[32m            CircularProgressIndicator( // Círculo que representa el objetivo total[m
[32m+[m[32m              value: 1.0, // Valor máximo (100%)[m
[32m+[m[32m              strokeWidth: 10, // Grosor del círculo[m
[32m+[m[32m              backgroundColor: Colors.grey, // Color de fondo del círculo[m
[32m+[m[32m            ),[m
[32m+[m[32m            CircularProgressIndicator( // Círculo que representa el progreso actual[m
[32m+[m[32m              value: percentage, // Porcentaje de progreso[m
[32m+[m[32m              strokeWidth: 10, // Grosor del círculo[m
[32m+[m[32m              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Color del progreso[m
[32m+[m[32m            ),[m
[32m+[m[32m            Center([m
[32m+[m[32m              child: Text([m
[32m+[m[32m                '${(percentage * 100).toStringAsFixed(1)}%', // Muestra el porcentaje de progreso[m
[32m+[m[32m                style: TextStyle([m
[32m+[m[32m                  fontSize: 24,[m
[32m+[m[32m                  fontWeight: FontWeight.bold,[m
[32m+[m[32m                ),[m
[32m+[m[32m              ),[m
[32m+[m[32m            ),[m
[32m+[m[32m          ],[m
[32m+[m[32m        ),[m
[32m+[m[32m      ),[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/trabajologinflutter/lib/Pages/pagina_principal.dart b/trabajologinflutter/lib/Pages/pagina_principal.dart[m
[1mindex b0db14b..2463b64 100644[m
[1m--- a/trabajologinflutter/lib/Pages/pagina_principal.dart[m
[1m+++ b/trabajologinflutter/lib/Pages/pagina_principal.dart[m
[36m@@ -1,4 +1,5 @@[m
 import 'package:flutter/material.dart';[m
[32m+[m[32mimport 'CRUD_maquinas_page.dart';[m
 [m
 class PaginaPrincipal extends StatefulWidget {[m
   @override[m
[36m@@ -112,8 +113,10 @@[m [mclass _PaginaPrincipalState extends State<PaginaPrincipal> {[m
                 child: RoundedBox([m
                   color: Color(0xFF42A5F5), // Azul claro[m
                   onTap: () {[m
[31m-                    // Aquí puedes navegar a la página correspondiente[m
[31m-                    print('Ventana 7');[m
[32m+[m[32m                    Navigator.push([m
[32m+[m[32m                      context,[m
[32m+[m[32m                      MaterialPageRoute(builder: (context) => MaquinasPage()),[m
[32m+[m[32m                    );[m
                   },[m
                 ),[m
               ),[m
[1mdiff --git a/trabajologinflutter/lib/Pages/reserva_page.dart b/trabajologinflutter/lib/Pages/reserva_page.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..a3d1dae[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/Pages/reserva_page.dart[m
[36m@@ -0,0 +1,270 @@[m
[32m+[m[32mimport 'package:flutter/material.dart';[m
[32m+[m[32mimport 'package:intl/intl.dart';[m
[32m+[m[32mimport 'package:trabajologinflutter/Pages/CRUD_reservas_page.dart';[m
[32m+[m[32mimport 'package:trabajologinflutter/providers/reservas.dart';[m
[32m+[m
[32m+[m[32mclass ReservaPage extends StatefulWidget {[m
[32m+[m[32m  @override[m
[32m+[m[32m  _ReservaPageState createState() => _ReservaPageState();[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mclass _ReservaPageState extends State<ReservaPage> {[m
[32m+[m[32m  List<Reserva> reservas = [];[m
[32m+[m[32m  String? intervaloSeleccion;[m
[32m+[m[32m  int? maquinaSeleccion;[m
[32m+[m[32m  int? semanaSeleccion;[m
[32m+[m[32m  String? diaSeleccion;[m
[32m+[m
[32m+[m[32m  List<String> options1 = [[m
[32m+[m[32m    '9:00 - 9:15',[m
[32m+[m[32m    '9:15 - 9:30',[m
[32m+[m[32m    '9:30 - 9:45',[m
[32m+[m[32m    '9:45 - 10:00',[m
[32m+[m[32m    '10:00 - 10:15',[m
[32m+[m[32m    '10:15 - 10:30',[m
[32m+[m[32m    '10:30 - 10:45',[m
[32m+[m[32m    '10:45 - 11:00',[m
[32m+[m[32m    '11:00 - 11:15',[m
[32m+[m[32m    '11:15 - 11:30',[m
[32m+[m[32m    '11:30 - 11:45',[m
[32m+[m[32m    '11:45 - 12:00',[m
[32m+[m[32m    '12:00 - 12:15',[m
[32m+[m[32m    '12:15 - 12:30',[m
[32m+[m[32m    '12:30 - 12:45',[m
[32m+[m[32m    '12:45 - 13:00',[m
[32m+[m[32m    '13:00 - 13:15',[m
[32m+[m[32m    '13:15 - 13:30',[m
[32m+[m[32m    '15:30 - 15:45',[m
[32m+[m[32m    '15:45 - 16:00',[m
[32m+[m[32m    '16:00 - 16:15',[m
[32m+[m[32m    '16:15 - 16:30',[m
[32m+[m[32m    '16:30 - 16:45',[m
[32m+[m[32m    '16:45 - 17:00',[m
[32m+[m[32m    '17:00 - 17:15',[m
[32m+[m[32m    '17:15 - 17:30',[m
[32m+[m[32m    '17:30 - 17:45',[m
[32m+[m[32m    '17:45 - 18:00',[m
[32m+[m[32m    '18:00 - 18:15',[m
[32m+[m[32m    '18:15 - 18:30',[m
[32m+[m[32m    '18:30 - 18:45',[m
[32m+[m[32m    '18:45 - 19:00',[m
[32m+[m[32m    '19:00 - 19:15',[m
[32m+[m[32m    '19:15 - 19:30',[m
[32m+[m[32m    '19:30 - 19:45',[m
[32m+[m[32m    '19:45 - 20:00',[m
[32m+[m[32m    '20:00 - 20:15',[m
[32m+[m[32m    '20:15 - 20:30',[m
[32m+[m[32m  ];[m
[32m+[m[32m  List<int> options2 = [1, 2, 3];[m
[32m+[m[32m  List<int> options3 = [1, 2, 3, 4];[m
[32m+[m[32m  List<String> options4 = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];[m
[32m+[m
[32m+[m[32m  List<String> filteredOptions = [];[m
[32m+[m
[32m+[m[32m  GestionReservas gestionReservas = GestionReservas();[m
[32m+[m[41m  [m
[32m+[m[32m  void filtrarOpciones() {[m
[32m+[m[32m    var oneHourLater = DateTime.now().add(Duration(hours: 1));[m
[32m+[m[32m    var formatter = DateFormat('HH:mm');[m
[32m+[m[32m    filteredOptions.clear();[m
[32m+[m
[32m+[m[32m    for (String interval in options1) {[m
[32m+[m[32m      String intervalStart = interval.split(' - ')[0];[m
[32m+[m[32m      var intervalStartDateTime = formatter.parse(intervalStart);[m
[32m+[m
[32m+[m[32m      if (intervalStartDateTime.hour > oneHourLater.hour ||[m
[32m+[m[32m          (intervalStartDateTime.hour == oneHourLater.hour &&[m
[32m+[m[32m              intervalStartDateTime.minute > oneHourLater.minute)) {[m
[32m+[m[32m        filteredOptions.add(interval);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (filteredOptions.isNotEmpty && (intervaloSeleccion == null || !filteredOptions.contains(intervaloSeleccion))) {[m
[32m+[m[32m      intervaloSeleccion = filteredOptions.first;[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m void filtrarReservas() {[m
[32m+[m[32m  if (maquinaSeleccion != null && semanaSeleccion != null && diaSeleccion != null) {[m
[32m+[m[32m    Set<String> intervalosAEliminar = {};[m
[32m+[m
[32m+[m[32m    for (Reserva reserva in reservas) {[m
[32m+[m[32m      if (reserva.idMaquina == maquinaSeleccion.toString() &&[m
[32m+[m[32m          reserva.semana == semanaSeleccion.toString() &&[m
[32m+[m[32m          reserva.dia == diaSeleccion) {[m
[32m+[m[32m        intervalosAEliminar.addAll(reserva.intervalo.split(','));[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[41m    [m
[32m+[m[32m    List<String> filteredOptionsSet = filteredOptions.toSet().toList();[m
[32m+[m
[32m+[m[41m   [m
[32m+[m[32m    filteredOptionsSet.removeWhere((intervalo) => intervalosAEliminar.contains(intervalo));[m
[32m+[m
[32m+[m[32m    // Asignar la lista filtrada de intervalos nuevamente a filteredOptions[m
[32m+[m[32m    filteredOptions = filteredOptionsSet;[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[41m  [m
[32m+[m
[32m+[m[32m  @override[m
[32m+[m[32m  void initState() {[m
[32m+[m[32m    super.initState();[m
[32m+[m[32m    filtrarOpciones();[m[41m [m
[32m+[m[32m    cargarReservas();[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m    Future<void> cargarReservas() async {[m
[32m+[m[32m    try {[m
[32m+[m[32m      List<Reserva> reservasCargadas = await gestionReservas.cargarReservasExterna();[m
[32m+[m[32m      setState(() {[m
[32m+[m[32m        reservas = reservasCargadas;[m
[32m+[m[32m      });[m
[32m+[m[32m    } catch (error) {[m
[32m+[m[32m      print('Error al cargar las reservas: $error');[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  @override[m
[32m+[m[32m  Widget build(BuildContext context) {[m
[32m+[m[32m    return MaterialApp([m
[32m+[m[32m      home: Scaffold([m
[32m+[m[32m        body: Center([m
[32m+[m[32m          child: Column([m
[32m+[m[32m            mainAxisAlignment: MainAxisAlignment.center,[m
[32m+[m[32m            children: [[m
[32m+[m[32m              Container([m
[32m+[m[32m                width: 230,[m
[32m+[m[32m                height: 80,[m
[32m+[m[32m                decoration: BoxDecoration([m
[32m+[m[32m                  color: Colors.white,[m
[32m+[m[32m                  borderRadius: BorderRadius.circular(10),[m
[32m+[m[32m                ),[m
[32m+[m[32m                child: Center([m
[32m+[m[32m                  child: DropdownButton<int>([m
[32m+[m[32m                    items: options2.map((int item) {[m
[32m+[m[32m                      return DropdownMenuItem([m
[32m+[m[32m                        value: item,[m
[32m+[m[32m                        child: Text(item.toString()),[m
[32m+[m[32m                      );[m
[32m+[m[32m                    }).toList(),[m
[32m+[m[32m                    onChanged: (int? newValue) {[m
[32m+[m[32m                      setState(() {[m
[32m+[m[32m                        maquinaSeleccion = newValue!;[m
[32m+[m[32m                        semanaSeleccion = null;[m
[32m+[m[32m                        diaSeleccion = null;[m
[32m+[m[32m                        filtrarReservas();[m
[32m+[m[32m                      });[m
[32m+[m[32m                    },[m
[32m+[m[32m                    value: maquinaSeleccion,[m
[32m+[m[32m                    hint: Text('Selecciona opción 2'),[m
[32m+[m[32m                  ),[m
[32m+[m[32m                ),[m
[32m+[m[32m              ),[m
[32m+[m[32m              SizedBox(height: 10),[m
[32m+[m[32m              Container([m
[32m+[m[32m                width: 230,[m
[32m+[m[32m                height: 80,[m
[32m+[m[32m                decoration: BoxDecoration([m
[32m+[m[32m                  color: maquinaSeleccion != null ? Colors.white : Colors.grey[300],[m
[32m+[m[32m                  borderRadius: BorderRadius.circular(10),[m
[32m+[m[32m                ),[m
[32m+[m[32m                child: Center([m
[32m+[m[32m                  child: DropdownButton<int>([m
[32m+[m[32m                    items: options3.map((int item) {[m
[32m+[m[32m                      return DropdownMenuItem([m
[32m+[m[32m                        value: item,[m
[32m+[m[32m                        child: Text(item.toString()),[m
[32m+[m[32m                      );[m
[32m+[m[32m                    }).toList(),[m
[32m+[m[32m                    onChanged: maquinaSeleccion != null ? (int? newValue) {[m
[32m+[m[32m                      setState(() {[m
[32m+[m[32m                        semanaSeleccion = newValue!;[m
[32m+[m[32m                        diaSeleccion = null;[m
[32m+[m[32m                        filtrarReservas();[m
[32m+[m[32m                      });[m
[32m+[m[32m                    } : null,[m
[32m+[m[32m                    value: semanaSeleccion,[m
[32m+[m[32m                    hint: Text('Selecciona opción 3'),[m
[32m+[m[32m                    disabledHint: Text('Selecciona opción 2 primero'),[m
[32m+[m[32m                  ),[m
[32m+[m[32m                ),[m
[32m+[m[32m              ),[m
[32m+[m[32m              SizedBox(height: 10),[m
[32m+[m[32m              Container([m
[32m+[m[32m                width: 230,[m
[32m+[m[32m                height: 80,[m
[32m+[m[32m                decoration: BoxDecoration([m
[32m+[m[32m                  color: semanaSeleccion != null ? Colors.white : Colors.grey[300],[m
[32m+[m[32m                  borderRadius: BorderRadius.circular(10),[m
[32m+[m[32m                ),[m
[32m+[m[32m                child: Center([m
[32m+[m[32m                  child: DropdownButton<String>([m
[32m+[m[32m                    items: options4.map((String item) {[m
[32m+[m[32m                      return DropdownMenuItem([m
[32m+[m[32m                        value: item,[m
[32m+[m[32m                        child: Text(item),[m
[32m+[m[32m                      );[m
[32m+[m[32m                    }).toList(),[m
[32m+[m[32m                    onChanged: semanaSeleccion != null ? (String? newValue) {[m
[32m+[m[32m                      setState(() {[m
[32m+[m[32m                        diaSeleccion = newValue!;[m
[32m+[m[32m                        filtrarReservas();[m
[32m+[m[32m                      });[m
[32m+[m[32m                    } : null,[m
[32m+[m[32m                    value: diaSeleccion,[m
[32m+[m[32m                    hint: Text('Selecciona opción 4'),[m
[32m+[m[32m                    disabledHint: Text('Selecciona opción 3 primero'),[m
[32m+[m[32m                  ),[m
[32m+[m[32m                ),[m
[32m+[m[32m              ),[m
[32m+[m[32m              SizedBox(height: 10),[m
[32m+[m[32m              Container([m
[32m+[m[32m                width: 230,[m
[32m+[m[32m                height: 80,[m
[32m+[m[32m                decoration: BoxDecoration([m
[32m+[m[32m                  color: diaSeleccion != null ? Colors.white : Colors.grey[300],[m
[32m+[m[32m                  borderRadius: BorderRadius.circular(10),[m
[32m+[m[32m                ),[m
[32m+[m[32m                child: Center([m
[32m+[m[32m                  child: DropdownButton<String>([m
[32m+[m[32m                    items: filteredOptions.map((String item) {[m
[32m+[m[32m                      return DropdownMenuItem([m
[32m+[m[32m                        value: item,[m
[32m+[m[32m                        child: Text(item),[m
[32m+[m[32m                      );[m
[32m+[m[32m                    }).toList(),[m
[32m+[m[32m                    onChanged: diaSeleccion != null ? (String? newValue) {[m
[32m+[m[32m                      setState(() {[m
[32m+[m[32m                        intervaloSeleccion = newValue!;[m
[32m+[m[32m                      });[m
[32m+[m[32m                    } : null,[m
[32m+[m[32m                    value: intervaloSeleccion,[m
[32m+[m[32m                    hint: Text('Selecciona opción 1'),[m
[32m+[m[32m                    disabledHint: Text('Selecciona opción 4 primero'),[m
[32m+[m[32m                  ),[m
[32m+[m[32m                ),[m
[32m+[m[32m              ),[m
[32m+[m[32m              SizedBox(height: 20),[m
[32m+[m[32m              ElevatedButton([m
[32m+[m[32m                onPressed: (maquinaSeleccion != null && semanaSeleccion != null && diaSeleccion != null)[m
[32m+[m[32m                    ? () {[m
[32m+[m[32m                        String maquina= maquinaSeleccion.toString();[m
[32m+[m[32m                        String semana= semanaSeleccion.toString();[m
[32m+[m[32m                        String? dia= diaSeleccion;[m
[32m+[m[32m                        String? intervalo= intervaloSeleccion;[m
[32m+[m
[32m+[m[32m                        gestionReservas.insertarReservaExterna("1", maquina, "2", intervalo!, semana, dia!);[m
[32m+[m[32m                      }[m
[32m+[m[32m                    : null,[m
[32m+[m[32m                child: Text('Confirmar selección'),[m
[32m+[m[32m              ),[m
[32m+[m[32m            ],[m
[32m+[m[32m          ),[m
[32m+[m[32m        ),[m
[32m+[m[32m      ),[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/trabajologinflutter/lib/providers/maquinas.dart b/trabajologinflutter/lib/providers/maquinas.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..5e110d0[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/providers/maquinas.dart[m
[36m@@ -0,0 +1,31 @@[m
[32m+[m[32mclass Machine {[m
[32m+[m[32m  final int idMaquina;[m
[32m+[m[32m  final int metIntenso;[m
[32m+[m[32m  final int metIntermedio;[m
[32m+[m[32m  final int metLigero;[m
[32m+[m[32m  final String marca;[m
[32m+[m[32m  final String nombre;[m
[32m+[m[32m  final String tipo;[m
[32m+[m
[32m+[m[32m  Machine({[m
[32m+[m[32m    required this.idMaquina,[m
[32m+[m[32m    required this.metIntenso,[m
[32m+[m[32m    required this.metIntermedio,[m
[32m+[m[32m    required this.metLigero,[m
[32m+[m[32m    required this.marca,[m
[32m+[m[32m    required this.nombre,[m
[32m+[m[32m    required this.tipo,[m
[32m+[m[32m  });[m
[32m+[m
[32m+[m[32m  factory Machine.fromJson(Map<String, dynamic> json) {[m
[32m+[m[32m    return Machine([m
[32m+[m[32m      idMaquina: json['id_maquina'] ?? 0,[m
[32m+[m[32m      metIntenso: json['MET_intenso'] ?? 0,[m
[32m+[m[32m      metIntermedio: json['MET_intermedio'] ?? 0,[m
[32m+[m[32m      metLigero: json['MET_ligero'] ?? 0,[m
[32m+[m[32m      marca: json['marca'] ?? '',[m
[32m+[m[32m      nombre: json['nombre'] ?? '',[m
[32m+[m[32m      tipo: json['tipo'] ?? '',[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/trabajologinflutter/lib/providers/reservas.dart b/trabajologinflutter/lib/providers/reservas.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..5767367[m
[1m--- /dev/null[m
[1m+++ b/trabajologinflutter/lib/providers/reservas.dart[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32mclass Reserva {[m
[32m+[m[32m  final String idReserva;[m
[32m+[m[32m  final String idMaquina;[m
[32m+[m[32m  final String idGimnasio;[m
[32m+[m[32m  final String intervalo;[m
[32m+[m[32m  final String semana;[m
[32m+[m[32m  final String dia;[m
[32m+[m
[32m+[m[32m  Reserva({[m
[32m+[m[32m    required this.idReserva,[m
[32m+[m[32m    required this.idMaquina,[m
[32m+[m[32m    required this.idGimnasio,[m
[32m+[m[32m    required this.intervalo,[m
[32m+[m[32m    required this.semana,[m
[32m+[m[32m    required this.dia,[m
[32m+[m[32m  });[m
[32m+[m
[32m+[m[32m  factory Reserva.fromJson(Map<String, dynamic> json) {[m
[32m+[m[32m    return Reserva([m
[32m+[m[32m      idReserva: json['id_reserva'] ?? '',[m
[32m+[m[32m      idMaquina: json['id_maquina'] ?? '',[m
[32m+[m[32m      idGimnasio: json['id_gimnasio'] ?? '',[m
[32m+[m[32m      intervalo: json['intervalo'] ?? '',[m
[32m+[m[32m      semana: json['semana'] ?? '',[m
[32m+[m[32m      dia: json['dia'] ?? '',[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/trabajologinflutter/macos/Flutter/GeneratedPluginRegistrant.swift b/trabajologinflutter/macos/Flutter/GeneratedPluginRegistrant.swift[m
[1mindex 8e4d0bb..8c63c34 100644[m
[1m--- a/trabajologinflutter/macos/Flutter/GeneratedPluginRegistrant.swift[m
[1m+++ b/trabajologinflutter/macos/Flutter/GeneratedPluginRegistrant.swift[m
[36m@@ -7,6 +7,7 @@[m [mimport Foundation[m
 [m
 import firebase_auth[m
 import firebase_core[m
[32m+[m[32mimport firebase_database[m
 import flutter_secure_storage_macos[m
 import google_sign_in_ios[m
 import path_provider_foundation[m
[36m@@ -16,6 +17,7 @@[m [mimport url_launcher_macos[m
 func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {[m
   FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))[m
   FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))[m
[32m+[m[32m  FLTFirebaseDatabasePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseDatabasePlugin"))[m
   FlutterSecureStoragePlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStoragePlugin"))[m
   FLTGoogleSignInPlugin.register(with: registry.registrar(forPlugin: "FLTGoogleSignInPlugin"))[m
   PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))[m
[1mdiff --git a/trabajologinflutter/pubspec.lock b/trabajologinflutter/pubspec.lock[m
[1mindex e19c63a..c2fedb9 100644[m
[1m--- a/trabajologinflutter/pubspec.lock[m
[1m+++ b/trabajologinflutter/pubspec.lock[m
[36m@@ -137,6 +137,30 @@[m [mpackages:[m
       url: "https://pub.dev"[m
     source: hosted[m
     version: "2.11.5"[m
[32m+[m[32m  firebase_database:[m
[32m+[m[32m    dependency: "direct main"[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_database[m
[32m+[m[32m      sha256: "7f6eb8b0a91e8596b53c2ca727acb8cea7cc32b776b8f9252389cce8adfbcbe0"[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "10.4.9"[m
[32m+[m[32m  firebase_database_platform_interface:[m
[32m+[m[32m    dependency: transitive[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_database_platform_interface[m
[32m+[m[32m      sha256: bf28ef7212b90cdbd2a1319f14a16459ec49a29bdbc98a28d9902d18a58d5156[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "0.2.5+25"[m
[32m+[m[32m  firebase_database_web:[m
[32m+[m[32m    dependency: transitive[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_database_web[m
[32m+[m[32m      sha256: "6fdd5c77826bf73f00f672d48c1ec352a2359fff301bcf52bc661149812fc37a"[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "0.2.3+25"[m
   fl_chart:[m
     dependency: "direct main"[m
     description:[m
[36m@@ -289,7 +313,7 @@[m [mpackages:[m
     source: hosted[m
     version: "4.0.2"[m
   intl:[m
[31m-    dependency: transitive[m
[32m+[m[32m    dependency: "direct main"[m
     description:[m
       name: intl[m
       sha256: d6f56758b7d3014a48af9701c085700aac781a92a87a62b1333b46d8879661cf[m
[1mdiff --git a/trabajologinflutter/pubspec.yaml b/trabajologinflutter/pubspec.yaml[m
[1mindex 7bb6376..fa72957 100644[m
[1m--- a/trabajologinflutter/pubspec.yaml[m
[1m+++ b/trabajologinflutter/pubspec.yaml[m
[36m@@ -48,6 +48,8 @@[m [mdependencies:[m
   flutter_map: ^6.1.0[m
   latlong2: ^0.9.1[m
   url_launcher: ^6.2.6[m
[32m+[m[32m  firebase_database: ^10.4.9[m
[32m+[m[32m  intl: ^0.19.0[m
 [m
 dev_dependencies:[m
   flutter_test:[m
