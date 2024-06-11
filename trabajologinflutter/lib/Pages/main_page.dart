import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trabajologinflutter/Gestores/GestorClientes.dart';
import 'package:trabajologinflutter/Modelos/Cliente.dart';
import 'package:trabajologinflutter/Pages/pagina_principal.dart';
import 'package:trabajologinflutter/Pages/PerfilPage.dart';
import 'package:trabajologinflutter/Pages/SettingsPage.dart';
import 'package:trabajologinflutter/Pages/estadisticas_page.dart';
import 'package:trabajologinflutter/Pages/reserva_page.dart';
import 'package:trabajologinflutter/Pages/modificacion_page.dart';

class MainPage extends StatefulWidget {
  final Cliente cliente;

  MainPage({required this.cliente});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late Cliente cliente;
  @override
void initState() {
  super.initState();
  reiniciarKcalMensual();
  cliente = widget.cliente;
}
  Future<void> reiniciarKcalMensual() async {
    final DateTime now = DateTime.now();
    final int dia = now.day;


    if (dia == 1) {
      try {

        List<Cliente> clientes = await GestorClientes.cargarClientes();

        for (Cliente cliente in clientes) {
          if (cliente.amigos.length >= 3) {

            int kcalCliente = int.parse(cliente.kcalMensual);
            bool tieneMasKcalQueTodosLosAmigos = true;

            for (String amigoId in cliente.amigos) {
              Cliente? amigo = await GestorClientes.buscarClientePorEmail(amigoId);
              if (amigo != null) {
                int kcalAmigo = int.parse(amigo.kcalMensual);
                if (kcalCliente <= kcalAmigo) {
                  tieneMasKcalQueTodosLosAmigos = false;
                  break;
                }
              }
            }

            if (tieneMasKcalQueTodosLosAmigos) {

              int estrellasParse = int.parse(cliente.estrellas);
              estrellasParse += 1;
              await GestorClientes.actualizarCliente(cliente.id, estrellas: estrellasParse.toString());
              cliente.estrellas = estrellasParse.toString();
            }
          }


          await GestorClientes.actualizarCliente(cliente.id, kcalMensual: '1');
          cliente.kcalMensual = '1';
        }
      } catch (error) {
        print('Error al reiniciar las kcalMensual: $error');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      PaginaPrincipal(cliente:widget.cliente,),
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
              rippleColor: Colors.orange, 
              hoverColor: Colors.grey[700] ?? Colors.black,
              haptic: true, 
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Colors.black38, width: 1),
              tabBorder: Border.all(color: Colors.grey[300]!, width: 1),
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ],
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 900),
              gap: 8, // Espacio entre el icono y el texto
              color: Colors.white, // Color del icono no seleccionado
              activeColor: Colors.red, // Color del icono y texto seleccionado
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
                  leading: Stack(
                    children: [
                      Icon(Icons.person, color: Colors.white), // Icono base
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 12, // Radio del avatar
                          backgroundImage: NetworkImage(widget.cliente.imagenUrl), // O usa AssetImage('ruta/a/tu/imagen.png') si la imagen está en los activos
                        ),
                      ),
                    ],
                  ),
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
