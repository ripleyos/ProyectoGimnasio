import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trabajologinflutter/Gestores/GestorClientes.dart';
import 'package:trabajologinflutter/Gestores/GestorGimnasio.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'dart:math';
import 'package:trabajologinflutter/Gestores/GestorMaquina.dart';
import 'package:trabajologinflutter/Modelos/Gimnasio.dart';
import 'package:trabajologinflutter/Modelos/maquinas.dart';
import 'package:trabajologinflutter/Pages/InfoSobreLaApp.dart';
import 'package:trabajologinflutter/Pages/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class GymPage extends StatefulWidget {
  final Cliente cliente;

  GymPage({required this.cliente});

  @override
  _GymPageState createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  late Cliente cliente;
  Position? _userPosition;
  List<Gimnasio> _gimnasios = [];
  GestorGimnasio gestorGimnasio = new GestorGimnasio();
  GestionMaquinas gestionMaquinas = new GestionMaquinas();
  Map<String, List<Maquina>> _maquinasPorGimnasio = {};

  @override
  void initState() {
    super.initState();
    cliente =widget.cliente;
    _getUserLocation();

  }

  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radio de la tierra en kilómetros
    final dLat = (lat2 - lat1) * (pi / 180);
    final dLon = (lon2 - lon1) * (pi / 180);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) *
        sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = R * c; // Distancia en kilómetros
    return distance;
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Comprobar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('El servicio de ubicación está deshabilitado.');
    }

    // Comprobar los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación están denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Los permisos de ubicación están denegados permanentemente.');
    }

    // Obtener la ubicación del usuario
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userPosition = position;
      _loadGimnasios();
    });
  }

  Future<void> _loadGimnasios() async {
    List<Gimnasio> gimnasios = await gestorGimnasio.cargarGimnasios();
    gimnasios.sort((a, b) => haversine(
      _userPosition!.latitude,
      _userPosition!.longitude,
      double.parse(a.latitud),
      double.parse(a.longitud),
    ).compareTo(haversine(
      _userPosition!.latitude,
      _userPosition!.longitude,
      double.parse(b.latitud),
      double.parse(b.longitud),
    )));
    setState(() {
      _gimnasios = gimnasios;
    });
  }

  Future<void> _loadMaquinas(Gimnasio gimnasio) async {
    if (_maquinasPorGimnasio.containsKey(gimnasio.id)) {
      return;
    }
    List<Maquina> maquinas = await gestionMaquinas.cargarMaquinas(gimnasio.id);
    setState(() {
      _maquinasPorGimnasio[gimnasio.id] = maquinas;
    });
  }

  Future<void> _confirmarEleccion(Gimnasio gimnasio,Cliente cliente) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar elección'),
          content: Text('¿Está seguro de que quiere que ${gimnasio.nombre} sea su gimnasio?'),
          actions: [
            TextButton(
              child: Text('Sí'),
              onPressed: () {
                GestorClientes.actualizarGymCliente(cliente.id, gimnasio.id);
                cliente.idgimnasio =gimnasio.id;
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoSobreLaApp(cliente: cliente),
                ),
              );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _abrirGoogleMaps(Gimnasio gimnasio) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=${gimnasio.latitud},${gimnasio.longitud}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gimnasios Cercanos'),
      ),
      body: _userPosition == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _gimnasios.length,
              itemBuilder: (context, index) {
                Gimnasio gimnasio = _gimnasios[index];
                double distancia = haversine(
                  _userPosition!.latitude,
                  _userPosition!.longitude,
                  double.parse(gimnasio.latitud),
                  double.parse(gimnasio.longitud),
                );
                return Card(
                  child: ExpansionTile(
                    title: Text(gimnasio.nombre),
                    subtitle: Text('${gimnasio.descripcion}\nDistancia: ${distancia.toStringAsFixed(2)} km'),
                    children: [
                      FutureBuilder(
                        future: _loadMaquinas(gimnasio),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<Maquina>? maquinas = _maquinasPorGimnasio[gimnasio.id];
                            if (maquinas == null || maquinas.isEmpty) {
                              return ListTile(
                                title: Text('No se encontraron máquinas para este gimnasio.'),
                              );
                            } else {
                              return Column(
                                children: [
                                  ...maquinas.map((maquina) {
                                    return ListTile(
                                      title: Text(maquina.nombre),
                                      subtitle: Text('Marca: ${maquina.marca}\nLocalización: ${maquina.localizacion}'),
                                    );
                                  }).toList(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _confirmarEleccion(gimnasio,cliente),
                                        child: Text('Aceptar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => _abrirGoogleMaps(gimnasio),
                                        child: Text('Cómo llegar'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
