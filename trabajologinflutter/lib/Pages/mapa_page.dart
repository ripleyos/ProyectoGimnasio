import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trabajologinflutter/Pages/gimnasio_seleccion_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  @override
  
@override
Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(51.509364, -0.128928),
      initialZoom: 9.2,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      
      ),
      GestureDetector(
        onTap: (){
          Gym gym = Gym(name: 'Nombre del gimnasio 1', description: 'Descripción del gimnasio 1');
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GymDetailsPage(gym: gym)),
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
