import 'package:trabajologinflutter/Pages/PerfilPage.dart';
import 'package:trabajologinflutter/Pages/TestGestionClientes.dart';
import 'package:trabajologinflutter/Pages/estadisticas_page.dart';
import 'package:trabajologinflutter/Pages/main_page.dart';
import 'package:trabajologinflutter/Pages/mapa_page.dart';
import 'package:trabajologinflutter/Pages/pagina_principal.dart';
import 'package:trabajologinflutter/Pages/registro_page.dart';
import 'package:trabajologinflutter/providers/cart_provider.dart';
import 'package:trabajologinflutter/providers/login_form_provider.dart';
import 'package:trabajologinflutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:trabajologinflutter/pages/login_page.dart';
import 'package:trabajologinflutter/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(gesApp());

class gesApp extends StatelessWidget {
  const gesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ )=>LoginFormProvider()),
          ChangeNotifierProvider(create: ( _ )=>CartProvider()),
          ChangeNotifierProvider(create: ( _ )=>AuthService())
        ],
      child: MyApp(),);
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo Provider',
      initialRoute: 'login',
      routes: {
        'login': ( _ ) => LoginPage(),
     //   'home' : ( _ ) => MainPage(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.blueGrey
      ),
    );
  }
}