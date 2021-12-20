import 'dart:convert';

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
  late Rx<dynamic> _dataSala = "".obs;
  late Rx<dynamic> _newSala = "".obs;

  String get uidSala => _newSala.value;

  // Estado inicial
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Estado Listo cuando ya se cargaron todas las vistas.
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

// Estado cuando se va ha cerrar la pantalla.
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

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

  void guardarSala(ChatSala sala, uid1, uid2) {
    final _keySala = _salaChat.push().key;
    _salaChat.child(_keySala).set(sala.toJson());

    // pasar el id de la sala para crear a los usuarios con la misma sala.
    //print("Key : ${_keySala}");
    final userChat = UserChat(_keySala);

    _newSala.value = _keySala;

    // uid Usuario Logueado, id Usuario de la lista
    guardarUserSala(_keySala, uid1);
    guardarUserSala(_keySala, uid2);
    updateUsuario(_keySala, uid1, uid2);
    updateUsuario(_keySala, uid2, uid1);
  }

  void guardarUserSala(String userSala, uid) {
    _userChat.child(uid).update({userSala: userSala});
  }

// Actualiza usuario con datos de las salas de chat.
  void updateUsuario(String chat, String uidUser, uid) {
    _usuarios.child(uidUser).child('chat').update({uid: chat});
  }

  Future<Map> getMensajesDetail(id) async {
    final mensajes = await _mensajesRef.child(id).once();

    if (mensajes.value != null) {
      Map<dynamic, dynamic> values = mensajes.value!;
      return values;
    }
    return Map();
  }

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

  String get uidChat => _uid.value;

  clearText() {
    mensajeController.clear();
  }

// No usada
  Future getChat(idsala, String iduser) async {
    //var _chat = "";
    //print("Ver id sala: ${idsala.values}, $iduser");

    idsala.forEach((key, values) async {
      //print("Lista, ${key}");
      final snapshot = await _salaChat.child(key).once();
      //print("Miembros, ${snapshot.value[0]}");
      final usua_one = snapshot.value['members'][0];
      final usua_two = snapshot.value['members'][1];
      // Se comprueba que el usuario comparta la misma sala.
      if (iduser == usua_one || iduser == usua_two) {
        _dataSala.value = key;
        _newSala.value = key;
        //_chat = key;
        print("Chat, ${_dataSala.value}, ${iduser}, ${usua_one},  ${usua_two}");
      }
    });

    return _dataSala.value;
  }
}
