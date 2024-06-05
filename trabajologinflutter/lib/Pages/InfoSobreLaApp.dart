import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modelos/Cliente.dart';
import 'main_page.dart';

class InfoSobreLaApp extends StatefulWidget {
  final Cliente cliente;
  InfoSobreLaApp({required this.cliente});
  @override
  _InfoSobreLaAppState createState() => _InfoSobreLaAppState();
}

class _InfoSobreLaAppState extends State<InfoSobreLaApp> {
  late Cliente _cliente;

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información Sobre la App'),
        backgroundColor: Color(0xFF730000),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2A0000),
                Color(0xFF460303),
                Color(0xFF730000),
                Color(0xFFA80000),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpandableSection(
                context,
                title: 'Página de Reservas',
                info: 'En la página de reservas puedes hacer nuevas reservas, cancelar las existentes y ver el estado de tus reservas actuales. Además, puedes gestionar tus reservas pre-hechas.',
                questionsAnswers: [
                  {
                    'question': '¿Cómo hago una reserva?',
                    'answer': 'Para hacer una reserva, ve a la sección de reservas y selecciona la opción haz tu reserva. Dentro de la nueva página, deberás elegir la cantidad de reservas que quieres realizar y especificar la máquina, día y la hora.',
                  },
                  {
                    'question': '¿Cuántas reservas puedo tener activas?',
                    'answer': 'Puedes tener hasta un máximo de 12 reservas activas a la vez.',
                  },
                  {
                    'question': '¿Cuál es el tiempo de antelación que tengo para realizar una reserva?',
                    'answer': 'Las reservas de las máquinas pueden realizarse con una hora de antelación.',
                  },
                  {
                    'question': '¿Dónde cambio mi gimnasio?',
                    'answer': 'Podrás cambiar tu gimnasio en la sección Configuración de cuenta en ajustes.',
                  },
                  {
                    'question': '¿Qué es una reserva pre-hecha?',
                    'answer': 'Las reservas pre-hechas te permitirán hacer una reserva automática con el objetivo físico que tengas el día en el que te encuentras.',
                  },
                  {
                    'question': '¿Puedo cancelar mi reserva?',
                    'answer': 'Sí, desde el apartado modificar mi reserva podrás cambiar tus reservas además de poder eliminarlas.',
                  },
                  {
                    'question': '¿Cuál es el día más lejano en el que puedo reservar?',
                    'answer': 'Nuestras reservas están configuradas para que te permitan reservar desde el día en que te encuentras hasta 28 días después.',
                  },
                ],
              ),
              SizedBox(height: 20),
              _buildExpandableSection(
                context,
                title: 'Perfil y Amigos',
                info: 'En la sección de perfil, puedes ver tu perfil y tus estrellas: un sistema de recompensa el cual cada mes, al tener minimo 4 amigos y ser el usuario con mas puntos entre ellos seras recompensado con ella, También puedes agregar y gestionar tus amigos.',
                questionsAnswers: [
                  {
                    'question': '¿Para que sirven los amigos?',
                    'answer': 'en nuestra app los amigos son utilizados para realizar competiciones con ellos en el apartado de estadisticas ademas de poder ver sus progresos fisicos',
                  },
                  {
                    'question': '¿Cómo cambio mi contraseña?',
                    'answer': 'Para cambiar tu contraseña, ve a Configuración de Cuenta y selecciona "Cambiar Contraseña". Se enviará un correo de restablecimiento de contraseña a tu dirección de correo registrada.',
                  },
                  {
                    'question': '¿Cuando y como se hace el reparto de estrellas?',
                    'answer': 'Se realiza el dia 1 de cada mes, al tener minimo 4 amigos se te otorgará una estrella si eres el que mas puntuaje tiene',
                  },
                  {
                    'question': '¿Cómo puedo actualizar mi peso?',
                    'answer': 'Ve a Ajustes, Personalizar Perfil y selecciona "Cambiar Peso". Ingresa tu nuevo peso y guarda los cambios. Ten en cuenta que el formato.',
                  },
                  {
                    'question': '¿Cómo puedo actualizar mi altura?',
                    'answer': 'Ve a Ajustes, Personalizar Perfil y selecciona "Cambiar Altura". Ingresa tu nueva altura y guarda los cambios. Ten en cuenta que el formato de altura es "170".',
                  },
                  {
                    'question': '¿Cómo elimino mi cuenta?',
                    'answer': 'Para eliminar tu cuenta, ve a Ajustes, Configuración de Cuenta y selecciona "Eliminar Cuenta". Ten en cuenta que esta acción es irreversible.',
                  },
                  {
                    'question': '¿Cómo agrego amigos?',
                    'answer': 'Para agregar amigos, ve a la sección de amigos y utiliza la función de búsqueda para encontrar y agregar a tus amigos introducciendo su correo electronica.',
                  },
                ],
              ),
              SizedBox(height: 20),
              _buildExpandableSection(
                context,
                title: 'Estadísticas',
                info: 'La sección de estadísticas te muestra tus logros, incluyendo estrellas y puntos acumulados. Puedes compartir tus estadísticas con tus amigos.',
                questionsAnswers: [
                  {
                    'question': '¿Qué son las estrellas y cómo las obtengo?',
                    'answer': 'Las estrellas se otorgan al final del mes al usuario que más puntuación tenga.',
                  },
                  {
                    'question': '¿Qué es el objetivo mensual?',
                    'answer': 'es un objetivo personal personalizable que podras modificar a tu gusto en caso de que quieras llevar un registro personal y un objetivo minimo',
                  },
                  {
                    'question': '¿Qué es el booker del mes?',
                    'answer': 'El booker del mes es el usuario de Booking Gym que más puntos ha hecho en lo que llevamos de mes.',
                  },
                  {
                    'question': '¿Puedo compartir mis estadísticas?',
                    'answer': 'Sí, puedes compartir tus estadísticas con tus amigos a través de la función de compartir en la sección de estadísticas.',
                  },
                ],
              ),
              SizedBox(height: 20),
              _buildExpandableSection(
                context,
                title: 'Ajustes',
                info: 'En la sección de ajustes, puedes configurar tus preferencias de notificaciones y ajustes de privacidad para asegurar que tu experiencia sea personalizada.',
                questionsAnswers: [
                  {
                    'question': '¿Cómo configuro mis notificaciones?',
                    'answer': 'Ve a Configuración de Notificaciones para ajustar tus preferencias de notificación.',
                  },
                  {
                    'question': '¿Cómo cambio la configuración de privacidad?',
                    'answer': 'Ve a Privacidad y Seguridad para ajustar tus configuraciones de privacidad.',
                  },
                ],
              ),
              SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('infoVisto', true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(cliente: _cliente,),
                  ),
                );
              },
              child: Text('Aceptar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF730000),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

  Widget _buildExpandableSection(BuildContext context, {required String title, required String info, required List<Map<String, String>> questionsAnswers}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            Column(
              children: questionsAnswers.map((qa) => _buildQuestionAnswer(qa['question']!, qa['answer']!)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionAnswer(String question, String answer) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(            answer,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

