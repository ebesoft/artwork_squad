import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  TextEditingController mensajeController = TextEditingController();
  late Rx<dynamic> _uid = "".obs;
  late Rx<dynamic> _userUid1 = "".obs;
  late Rx<dynamic> _userUid2 = "".obs;
  late Rx<dynamic> _receptor = "".obs;
  late Rx<dynamic> _dataUser = "".obs;

  // Instancia Mensajes
  final DatabaseReference _mensajesRef =
      FirebaseDatabase.instance.reference().child('ChatMessages');

  // Instancia Salas
  final DatabaseReference _salaChat =
      FirebaseDatabase.instance.reference().child('Chat');

  // Instancia Salas
  final DatabaseReference _userChat =
      FirebaseDatabase.instance.reference().child('UserChat');

  // Instancia Usuarios
  final DatabaseReference _usuarios =
      FirebaseDatabase.instance.reference().child('Users');

  void guardarMensaje(ChatMessage mensaje) {
    _mensajesRef.push().set(mensaje.toJson());
  }

  void guardarSala(ChatSala sala, uid) {
    final _keySala = _salaChat.push().key;
    _salaChat.child(_keySala).set(sala.toJson());

    //String mGroupId = mGroupRef.Push().getKey();
    print("Key : ${_keySala}");
    final userChat = UserChat(_keySala);
    guardarUserSala(userChat, uid);
  }

  void guardarUserSala(UserChat userSala, uid) {
    _userChat.child(uid).set(userSala.toJson());
  }

  Query getMensajes() => _mensajesRef;
  getMensajesDetail(id) => _mensajesRef.child(id);

  Query getSala(uidSala) => _salaChat.child(uidSala);

  Query getUsuario(id) => _usuarios.child(id);

  Future<Map> getuser(id, userid) async {
    final sala = await _salaChat.child(id).once();
    //_userSala = sala.key.toString();
    _userUid1.value = sala.value['members']['uid1'].toString();
    _userUid2.value = sala.value['members']['uid2'].toString();

    // Datos del compañero de chat
    if (userid != _userUid1.value) {
      _receptor.value = _userUid1.value;
    } else if (userid != _userUid2.value) {
      _receptor.value = _userUid2.value;
    }
    final info = await _usuarios.child(_receptor.value).once();
    //print("Query ${info.value}");
    return info.value;
  }

  // Comprueba que el usuario incio chat y devuelve la sala
  Future<String> getuserChatSala(id) async {
    String _userSala;
    //Información de la sala de los usuarios.
    final snapshot = await _userChat.child(id).once();
    _userSala = snapshot.value[0];

    _salaChat.child(_userSala).once().then((data) {
      //print("ver salas: ${data.value['lastMensaje']}");
      _uid.value = data.key;
      _userUid1.value = data.value['members']['uid1'];
      _userUid2.value = data.value['members']['uid2'];
    });
    //print("User uid ${data.value['members']['uid1']}");

    // Uid de usuarios en la sala
    if (_userSala == _uid.value) {
      //print("User uid ${_userUid1.value}, $id");
      if (id == _userUid1.value || id == _userUid2.value) {
        //print("User sala $_userSala, ${_uid.value}");
        return _uid.value;
      }
    }

    return "Sin Data";
  }

  String get uidChat => _uid.value;

  Future<String> getChat(id) async {
    String _chat;
    final snapshot = await _salaChat.child(id).once();
    _chat = snapshot.value[0];
    //print("Sala: $_chat");
    return _chat;
  }

  clearText() {
    mensajeController.clear();
  }
}
