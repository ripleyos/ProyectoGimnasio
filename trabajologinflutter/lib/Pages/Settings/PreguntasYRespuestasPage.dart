import 'package:flutter/material.dart';

class PreguntasYRespuestasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas y Respuestas'),
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
                title: 'Sobre las Reservas',
                questionsAnswers: [
                  {
                    'question': '¿Cómo hago una reserva?',
                    'answer': 'Para hacer una reserva, ve a la sección de reservas y selecciona la opcion haz tu reserva, dentro de la nueva pagina deberas elegir la cantidad de reservas que quieres realizar y especificar la maquina, dia y la hora .',
                  },
                  {
                    'question': '¿Cuantas reservas puedo tener activas?',
                    'answer': 'puedes tener hasta un maximo de 12 reservas activas a la vez',
                  },
                  {
                    'question': '¿Cual es el tiempo de antelación que tengo para realizar una reserva?',
                    'answer': 'las reservas de las maquinas pueden realizarse con una hora de antelación',
                  },
                  {
                    'question': '¿Donde Cambio mi gimnasio?',
                    'answer': 'Podras cambiar tu gimnasio en la seccion Configuracion de cuenta en ajustes',
                  },
                  {
                    'question': '¿Que es una reserva pre-hecha?',
                    'answer': 'las reservas pre-hechas te permitiran hacer una reserva automatica con el objetivo fisico que tengas el dia en el que te encuentras',
                  },{
                    'question': '¿Puedo cancelar mi reserva?',
                    'answer': 'Si, desde el apartado modificar mi reserva podras cambiar tus reservas ademas de poder eliminarlas',
                  },
                  {
                    'question': '¿Cual es el dia mas lejano en el que puedo reservar?',
                    'answer': 'Nuestras reservas están configuradas para que te permitan reservar desde el dia en que te encuentras hasta 28 dias despues',
                  },
                ],
              ),
              SizedBox(height: 20),
              _buildExpandableSection(
                context,
                title: 'Sobre el Perfil y Amigos',
                questionsAnswers: [
                  {
                    'question': '¿Cómo cambio mi contraseña?',
                    'answer': 'Para cambiar tu contraseña, ve a Configuración de Cuenta y selecciona "Cambiar Contraseña". Se enviará un correo de restablecimiento de contraseña a tu dirección de correo registrada.',
                  },
                  {
                    'question': '¿Cómo puedo actualizar mi peso?',
                    'answer': 'Ve a Personalizar Perfil y selecciona "Cambiar Peso". Ingresa tu nuevo peso y guarda los cambios. Ten en cuenta que el formato',
                  },
                  {
                    'question': '¿Cómo puedo actualizar mi altura?',
                    'answer': 'Ve a Personalizar Perfil y selecciona "Cambiar Altura". Ingresa tu nueva altura y guarda los cambios. ten en cuenta que el formato de altura es "170"',
                  },
                  {
                    'question': '¿Cómo elimino mi cuenta?',
                    'answer': 'Para eliminar tu cuenta, ve a Configuración de Cuenta y selecciona "Eliminar Cuenta". Ten en cuenta que esta acción es irreversible.',
                  },
                  {
                    'question': '¿Cómo agrego amigos?',
                    'answer': 'Para agregar amigos, ve a la sección de amigos y utiliza la función de búsqueda para encontrar y agregar a tus amigos.',
                  },
                ],
              ),
              SizedBox(height: 20),
              _buildExpandableSection(
                context,
                title: 'Sobre las Estadísticas',
                questionsAnswers: [
                  {
                    'question': '¿Cómo veo mis estadísticas?',
                    'answer': 'Puedes ver tus estadísticas en la sección de estadísticas. Aquí podrás ver tu progreso, tus logros y más.',
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
                title: 'Sobre los Ajustes',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(BuildContext context, {required String title, required List<Map<String, String>> questionsAnswers}) {
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
          children: questionsAnswers.map((qa) => _buildQuestionAnswer(qa['question']!, qa['answer']!)).toList(),
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
          Text(
            answer,
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
