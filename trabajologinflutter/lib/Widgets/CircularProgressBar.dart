import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double objective; // Objetivo total
  final double progress; // Progreso actual

  CircularProgressBar({required this.objective, required this.progress});

  @override
  Widget build(BuildContext context) {
    double percentage = (progress / objective).clamp(0.0, 1.0); // Calcula el porcentaje de progreso

    return Center(
      child: SizedBox(
        width: 200, // Ancho del círculo
        height: 200, // Alto del círculo
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator( // Círculo que representa el objetivo total
              value: 1.0, // Valor máximo (100%)
              strokeWidth: 10, // Grosor del círculo
              backgroundColor: Colors.grey, // Color de fondo del círculo
            ),
            CircularProgressIndicator( // Círculo que representa el progreso actual
              value: percentage, // Porcentaje de progreso
              strokeWidth: 10, // Grosor del círculo
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Color del progreso
            ),
            Center(
              child: Text(
                '${(percentage * 100).toStringAsFixed(1)}%', // Muestra el porcentaje de progreso
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
