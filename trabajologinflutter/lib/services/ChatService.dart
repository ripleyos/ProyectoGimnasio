
import 'package:firebase_database/firebase_database.dart';

import '../Modelos/Mensaje.dart';

class ChatService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  void enviarMensaje(Mensaje mensaje) {
    String chatId = _getChatId(mensaje.remitente, mensaje.destinatario);
    _database.child('mensajes').child(chatId).push().set(mensaje.toJson());
  }

  Stream<DatabaseEvent> recibirMensajes(String remitente, String destinatario) {
    String chatId = _getChatId(remitente, destinatario);
    return _database.child('mensajes').child(chatId).onValue;
  }

  String _getChatId(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort();
    return users.join('_');
  }
}
