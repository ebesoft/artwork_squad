import 'package:flutter/material.dart';

class NotificationUsers {
  final String email;
  final String message;
  final DateTime time;
  final bool estado;

  NotificationUsers(
    this.email,
    this.message,
    this.time,
    this.estado,
  );

  NotificationUsers.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'] as String,
        message = json['message'] as String,
        time = DateTime.parse(json['time'] as String),
        estado = json['estado'] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'email': email,
        'message': message,
        'time': time,
      };
}
