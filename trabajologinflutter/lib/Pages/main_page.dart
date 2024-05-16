import 'package:flutter/material.dart';
import 'package:trabajologinflutter/Pages/CRUD_reservas_page.dart';
import 'package:trabajologinflutter/Pages/PerfilPage.dart';
import 'package:trabajologinflutter/Pages/SettingsPage.dart';
import 'package:trabajologinflutter/Pages/estadisticas_page.dart';
import 'package:trabajologinflutter/Pages/pagina_principal.dart';
import 'package:trabajologinflutter/Pages/reserva_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ReservaPage(),
    PaginaPrincipal(),
    EstadisticasPage(), 
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class CurvedNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedNavClipper(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFEF5350),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_in_talk),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              label: 'Estadísticas',
            ), // Icono de estadísticas
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
        ),
      ),
    );
  }
}

class CurvedNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double curveHeight = 20;

    path.lineTo(size.width / 2 - curveHeight, 0);
    path.quadraticBezierTo(
      size.width / 2,
      curveHeight,
      size.width / 2 + curveHeight,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CurvedNavClipper oldClipper) => false;
}
