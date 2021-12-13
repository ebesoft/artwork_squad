import 'package:flutter/material.dart';

class ChatSala {
  final String lastMensaje;
  final DateTime fecha;
  final List<String> members;

  ChatSala(this.lastMensaje, this.fecha, this.members);

  ChatSala.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        lastMensaje = json['lastMensaje'] as String,
        members = List<String>.from(json["members"].map((x) => x));

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'lastMensaje': lastMensaje,
        'members': List<dynamic>.from(members.map((x) => x)),
      };
}

class UserChat {
  final String uidUser;

  UserChat(this.uidUser);

  UserChat.fromJson(Map<dynamic, dynamic> json)
      : uidUser = json['uidUser'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        uidUser: uidUser,
      };
}

class ChatMessage {
  final String message;
  final DateTime fecha;
  final String sendBy;
  final bool estado;

  ChatMessage(this.message, this.fecha, this.sendBy, this.estado);

  ChatMessage.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        message = json['message'] as String,
        sendBy = json['sendBy'] as String,
        estado = json['estado'] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'message': message,
        'sendBy': sendBy,
        'estado': estado,
      };
}
