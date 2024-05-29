import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Pages/modificacion_page.dart';
import 'package:trabajologinflutter/Pages/reserva_page.dart';
import '../Gestores/GestorMaquina.dart';
import '../Widgets/RoundedBox.dart';

class PaginaPrincipal extends StatefulWidget {
  late final Cliente cliente;
  PaginaPrincipal({required this.cliente});
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2A0000),
                Color(0xFF460303),
                Color(0xFF730000),
                Color(0xFFA80000),
              ],
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 2, 
                  child: RoundedBox(
                  color: Color(0xFF42A5F5), // Azul claro
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModificacionReservaPage(cliente: widget.cliente),
                     ),
                   );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Bordes redondeados para la imagen
                        child: Image.asset(
                          'lib/images/recepcion.jpeg', // Ruta de la imagen
                          width: double.infinity, // Ancho de la imagen igual al ancho del RoundedBox
                          height: double.infinity, // Alto de la imagen igual al alto del RoundedBox
                          fit: BoxFit.cover, // La imagen cubrirá todo el espacio disponible
                        ),
                      ),
                      Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                            padding: EdgeInsets.all(10), // Ajusta el espaciado del texto según sea necesario
                            color: Colors.black.withOpacity(0.5), // Color de fondo del texto con opacidad
                            child: Text(
                             'Modifica tu reserva', // Texto que quieres mostrar
                            style: TextStyle(
                            color: Colors.white, // Color del texto
                            fontSize: 16, // Tamaño de fuente del texto
                            fontWeight: FontWeight.bold, // Negrita del texto
                          ),
                        ),
                       ),
                      ),
                    ],
                  ),
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
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModificacionReservaPage(cliente: widget.cliente),
                     ),
                   );
                    },
                    child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Mismo radio de borde que RoundedBox
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'lib/images/ejercicio_mujer.jpeg', // Ruta de la imagen
                                  fit: BoxFit.cover, // La imagen cubrirá todo el espacio disponible
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(10), // Ajusta el espaciado del texto según sea necesario
                                    color: Colors.black.withOpacity(0.5), // Color de fondo del texto con opacidad
                                    child: Text(
                                      'Reserva prehecha de fuerza', // Texto que quieres mostrar
                                      style: TextStyle(
                                        color: Colors.white, // Color del texto
                                        fontSize: 16, // Tamaño de fuente del texto
                                        fontWeight: FontWeight.bold, // Negrita del texto
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                    SizedBox(width: 5.0), // Espacio entre las ventanas
                    Flexible(
                    flex: 1,
                    child: RoundedBox(
                          color: Color(0xFF66BB6A), // Verde
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ModificacionReservaPage(cliente: widget.cliente),
                            ),
                           );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Mismo radio de borde que RoundedBox
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'lib/images/resistencia.jpeg', // Ruta de la imagen
                                  fit: BoxFit.cover, // La imagen cubrirá todo el espacio disponible
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(10), // Ajusta el espaciado del texto según sea necesario
                                    color: Colors.black.withOpacity(0.5), // Color de fondo del texto con opacidad
                                    child: Text(
                                      'Reserva prehecha de resistencia', // Texto que quieres mostrar
                                      style: TextStyle(
                                        color: Colors.white, // Color del texto
                                        fontSize: 16, // Tamaño de fuente del texto
                                        fontWeight: FontWeight.bold, // Negrita del texto
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                     ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Espacio entre las filas de ventanas
              Expanded(   
                  flex: 2, 
                  child: RoundedBox(
                  color: Color(0xFF42A5F5), // Color de fondo del RoundedBox
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservaPage(cliente: widget.cliente),
                     ),
                   );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Mismo radio de borde que RoundedBox
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'lib/images/ejercicio.jpeg', // Ruta de la imagen
                          fit: BoxFit.cover, // La imagen cubrirá todo el espacio disponible
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(10), // Ajusta el espaciado del texto según sea necesario
                            color: Colors.black.withOpacity(0.5), // Color de fondo del texto con opacidad
                            child: Text(
                              'Haz tu reserva!', // Texto que quieres mostrar
                              style: TextStyle(
                                color: Colors.white, // Color del texto
                                fontSize: 16, // Tamaño de fuente del texto
                                fontWeight: FontWeight.bold, // Negrita del texto
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



