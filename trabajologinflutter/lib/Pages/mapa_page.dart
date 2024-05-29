import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Pages/gimnasio_seleccion_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget  {

      late final Cliente cliente;

    MapPage({required this.cliente});

    @override
  _MapPageState createState() => _MapPageState();
}
class _MapPageState extends State<MapPage>{
  LatLng _currentLocation = LatLng(51.509364, -0.128928);
  bool _locationLoaded = false;

    @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
    Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, muestra un mensaje al usuario
      return;
    }

    // Verifica el permiso de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados, muestra un mensaje al usuario
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están denegados permanentemente, muestra un mensaje al usuario
      return;
    }

    // Obtén la ubicación actual del usuario
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _locationLoaded = true;
    });
  }





@override
Widget build(BuildContext context) {


  return FlutterMap(
    options: MapOptions(

      initialCenter:_currentLocation,
      initialZoom: 9.2,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      
      ),
      GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'Nombre del gimnasio 1', description: 'Descripción del gimnasio 1',id: "1");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym,cliente:widget.cliente)),
        );
        },
          child: const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(38.028041, -0.746493),
              width: 400,
              height: 400,
              child: FlutterLogo(size: 50),
              ),
            ],
          ),
      ),
            GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'GymFit Extreme', description: 'GymFit Extreme es el lugar perfecto para los entusiastas del fitness que buscan desafiar sus límites. Con equipos de última generación y entrenadores expertos, ofrecemos programas personalizados para ayudarte a alcanzar tus metas de forma rápida y segura.',id: "2");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym,cliente:widget.cliente)),
        );
        },
          child: const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(38.028041, -0.746493),
              width: 400,
              height: 400,
              child: FlutterLogo(size: 50),
              ),
            ],
          ),
      ),
            GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'IronWorks Fitness Center', description: 'En IronWorks Fitness Center, nos dedicamos a construir cuerpos fuertes y mentes aún más fuertes. Nuestro ambiente de entrenamiento motivador y nuestra amplia gama de clases y servicios te ayudarán a alcanzar un estado físico óptimo mientras te diviertes en el proceso.',id: "3");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym,cliente:widget.cliente)),
        );
        },
          child: const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(38.028041, -0.746493),
              width: 400,
              height: 400,
              child: FlutterLogo(size: 50),
              ),
            ],
          ),
      ),
            GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'SweatBox Fitness Studio', description: 'En Peak Performance Gym, no nos conformamos con nada menos que lo mejor. Nuestro equipo de entrenadores altamente calificados te guiará en cada paso del camino, desde la planificación de tu programa de entrenamiento hasta el logro de tus objetivos de rendimiento más ambiciosos.',id: "4");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym,cliente:widget.cliente)),
        );
        },
          child:  MarkerLayer(
          markers: [
            Marker(
              point: LatLng(38.028041, -0.746493),
              width: 400,
              height: 400,
              child: Image.asset("lib/images/1.png"),
              ),
            ],
          ),
      ),
            GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'Peak Performance Gym', description: 'En Peak Performance Gym, no nos conformamos con nada menos que lo mejor. Nuestro equipo de entrenadores altamente calificados te guiará en cada paso del camino, desde la planificación de tu programa de entrenamiento hasta el logro de tus objetivos de rendimiento más ambiciosos.',id: "5");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym,cliente:widget.cliente)),
        );
        },
          child: const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(38.028041, -0.746493),
              width: 400,
              height: 400,
              child: FlutterLogo(size: 50),
              ),
            ],
          ),
      ),
      RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
          ),
        ],
      ),
    ],
  );
}
}
