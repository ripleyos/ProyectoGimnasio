import 'package:firebase_core/firebase_core.dart';
import 'package:trabajologinflutter/Pages/PerfilPage.dart';
import 'package:trabajologinflutter/Pages/main_page.dart';
import 'package:trabajologinflutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:trabajologinflutter/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:trabajologinflutter/services/firebase_options.dart';

void main() async { // Agrega async a main()
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // Inicializa Firebase aquí
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  runApp(gesApp()); 
}

class gesApp extends StatelessWidget {

  const gesApp({super.key})
  ;

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
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
          scaffoldBackgroundColor: Colors.black87
      ),
    );
  }
}
