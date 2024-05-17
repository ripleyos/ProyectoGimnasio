import 'package:flutter/material.dart';
import '../Gestores/GestorMaquina.dart';
import '../Widgets/RoundedBox.dart';

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Página con ventanas emergentes'),
          backgroundColor: Color(0xFFB71C1C), // Rojo oscuro
        ),
        body: Container(
          color: Colors.white, // Fondo blanco
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFFEF5350), // Rojo
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 1');
                        },
                      ),
                    ),
                    SizedBox(width: 20.0), // Espacio entre las ventanas
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFF5C6BC0), // Azul
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 2');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Espacio entre las filas de ventanas
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFF66BB6A), // Verde
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 3');
                        },
                      ),
                    ),
                    SizedBox(width: 20.0), // Espacio entre las ventanas
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFFFFA726), // Naranja
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 4');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Espacio entre las filas de ventanas
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFFEC407A), // Rosa
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 5');
                        },
                      ),
                    ),
                    SizedBox(width: 20.0), // Espacio entre las ventanas
                    Flexible(
                      flex: 1,
                      child: RoundedBox(
                        color: Color(0xFFAB47BC), // Púrpura
                        onTap: () {
                          // Aquí puedes navegar a la página correspondiente
                          print('Ventana 6');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Espacio entre las filas de ventanas
              Expanded(
                flex: 2, // Ocupa el doble de espacio vertical
                child: RoundedBox(
                  color: Color(0xFF42A5F5), // Azul claro
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MaquinasPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


