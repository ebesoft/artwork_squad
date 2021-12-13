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

  void guardarMensaje(ChatMessage mensaje, chatUid) {
    _mensajesRef.child(chatUid).push().set(mensaje.toJson());
  }

  void guardarSala(ChatSala sala, uid, id) {
    final _keySala = _salaChat.push().key;
    _salaChat.child(_keySala).set(sala.toJson());

    //String mGroupId = mGroupRef.Push().getKey();
    // pasar el id de la sala para crear a los usuarios con la misma sala.
    //print("Key : ${_keySala}");
    final userChat = UserChat(_keySala);
    guardarUserSala(userChat, uid);
    guardarUserSala(userChat, id);
  }

  void guardarUserSala(UserChat userSala, uid) {
    _userChat.child(uid).set(userSala.toJson());
  }

  /*Query getMensajes() => _mensajesRef;*/

  Future<Map> getMensajesDetail(id) async {
    final mensajes = await _mensajesRef.child(id).once();

    if (mensajes.value != null) {
      Map<dynamic, dynamic> values = mensajes.value!;
      return values;
    }
    return Map();
  }

  /*
  getMensajesDetail(id) {
    final mensajes = _mensajesRef.child(id).once();
    print("Mensajes ${id}");
    if (mensajes != null) {
      return mensajes;
    }
    return Map();
  }
*/
  Query getSala(uidSala) => _salaChat.child(uidSala);

  Query getUsuario(id) => _usuarios.child(id);

// En uso.
  Future<Map> getuser(id, userid) async {
    //print("VER ERROR ${id}");
    final sala = await _salaChat.child(id).once();
    //_userSala = sala.key.toString();
    if (sala.value != null) {
      _userUid1.value = sala.value['members'][0].toString();
      _userUid2.value = sala.value['members'][1].toString();

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
    return Map();
  }

  // Comprueba que el usuario incio chat y devuelve la sala
  Future<String> getuserChatSala(id) async {
    String _userSala;
    //Información de la sala de los usuarios.
    final snapshot = await _userChat.child(id).once();
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value!;
      values.forEach((key, values) {
        //print("VER ERROR 1 ${key}");
        //_userSala = snapshot.value[0].toString();
        _userSala = key;
        _salaChat.child(_userSala).once().then((data) {
          //print("ver salas: ${data.value}");
          _uid.value = data.key;
          _userUid1.value = data.value['members'][0];
          _userUid2.value = data.value['members'][1];
        });

        // Uid de usuarios en la sala
        if (_userSala == _uid.value) {
          //print("User uid ${_userUid1.value}, $id");
          if (id == _userUid1.value || id == _userUid2.value) {
            //print("User sala $_userSala, ${_uid.value}");
            return _uid.value;
          }
        }
      });
    }

    return _uid.value;
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
