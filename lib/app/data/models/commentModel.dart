import 'package:flutter/material.dart';

class CommentUsers {
  final String sendBy;
  final String comment;
  final String email;
  final DateTime fecha;

  CommentUsers(
    this.sendBy,
    this.comment,
    this.email,
    this.fecha,
  );

  CommentUsers.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        comment = json['comment'] as String,
        email = json['email'] as String,
        sendBy = json['sendBy'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'comment': comment,
        'email': email,
        'sendBy': sendBy,
      };
}
