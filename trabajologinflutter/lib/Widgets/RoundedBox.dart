import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const RoundedBox({Key? key, this.onTap, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color, // Color de fondo de las ventanas
          borderRadius: BorderRadius.circular(20.0), // Bordes redondos
        ),
        child: Center(
          child: Text(
            'Ventana',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}