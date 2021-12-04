import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  final DatabaseReference _mensajesRef =
      FirebaseDatabase.instance.reference().child('mensajes');

  void guardarMensaje(ChatMessage mensaje) {
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes() => _mensajesRef;
}
