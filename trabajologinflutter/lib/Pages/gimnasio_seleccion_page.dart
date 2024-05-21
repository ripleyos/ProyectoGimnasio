import 'package:flutter/material.dart';

class Gym {
  final String name;
  final String description;

  Gym({required this.name, required this.description});
}

class GymDetailsPage extends StatelessWidget {
  final Gym gym;

  GymDetailsPage({required this.gym});

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
                  onPressed: () {
                    
                  },
                  child: Text('Si'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    
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
