import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Pages/main_page.dart';
import 'package:trabajologinflutter/Pages/mapa_page.dart';
import 'package:trabajologinflutter/Pages/reserva_page.dart';

class Gym {
  final String name;
  final String description;
  final String id;

  Gym({
    required this.name,
    required this.description,
    required this.id,
  });
}

class GymDetailsPage extends StatelessWidget {
  final Cliente cliente;

  final Gym gym;

  GymDetailsPage({required this.gym,
  required this.cliente});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gym.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gym.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              gym.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                          Navigator.push(
                              context,
                                MaterialPageRoute(
                                  //Aqui javi, aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                                builder: (context) => ReservaPage(cliente: cliente,),
                    ),
                    );
                  },
                  child: Text('Si'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                         Navigator.push(
                          context,
                            MaterialPageRoute(
                            builder: (context) => MapPage(cliente:cliente),
                       ),
                    );
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
