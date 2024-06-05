
import 'package:flutter/material.dart';

class EstadisticaItem extends StatelessWidget {
  final String titulo;
  final int valor;
  final int objetivo;
  final IconData icono;
  final Function()? onTap;

  const EstadisticaItem({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.objetivo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icono,
                size: 36,
                color: Colors.blue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    valor.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Expanded(
                child: LinearProgressIndicator(
                  value: valor / objetivo, // Cambiar el valor máximo segun el caso d cada cliente
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
