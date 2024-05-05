import 'package:flutter/material.dart';

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
                  onTap: () {
                    // Aquí puedes navegar a la página correspondiente
                    print('Ventana 7');
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

class RoundedBox extends StatelessWidget {
  final VoidCallback? onTap;

  const RoundedBox({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo de las ventanas
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

