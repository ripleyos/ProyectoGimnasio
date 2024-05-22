import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Pages/pagina_principal.dart';
import 'package:trabajologinflutter/Pages/PerfilPage.dart';
import 'package:trabajologinflutter/Pages/SettingsPage.dart';
import 'package:trabajologinflutter/Pages/estadisticas_page.dart';
import 'package:trabajologinflutter/Pages/reserva_page.dart';

class MainPage extends StatefulWidget {
  final Cliente cliente;

  MainPage({required this.cliente});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

 /* static List<Widget> _widgetOptions = <Widget>[
    ReservaPage(),
    PaginaPrincipal(),
    EstadisticasPage(),
    SettingsPage(),
  ]; */

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      ReservaPage(cliente:widget.cliente,),
      PerfilPage(cliente: widget.cliente,),
      EstadisticasPage(cliente: widget.cliente,),
      SettingsPage(cliente: widget.cliente,),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A0000),
              Color(0xFF460303),
              Color(0xFF730000),
              Color(0xFFA80000),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.orange, // Color del ripple cuando se presiona
              hoverColor: Colors.grey[700] ?? Colors.black, // Color cuando se pasa el mouse
              haptic: true, // Feedback táctil
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Colors.orange, width: 1),
              tabBorder: Border.all(color: Colors.grey[300]!, width: 1),
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ],
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 900),
              gap: 8, // Espacio entre el icono y el texto
              color: Colors.white, // Color del icono no seleccionado
              activeColor: Colors.orange, // Color del icono y texto seleccionado
              iconSize: 24, // Tamaño del icono
              tabBackgroundColor: Colors.orange.withOpacity(0.1), // Color de fondo de la pestaña seleccionada
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Padding del nav bar
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Inicio',
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Perfil',
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.insert_chart,
                  text: 'Estadísticas',
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Ajustes',
                  iconColor: Colors.white,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}