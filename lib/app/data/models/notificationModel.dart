import 'package:flutter/material.dart';

class NotificationUsers {
  final String title;
  final String email;
  final String detalle;
  //final DateTime time;
  final bool estado;
  final String uid;
  final String photo;

  NotificationUsers(
    this.title,
    this.email,
    this.detalle,
    //this.time,
    this.estado,
    this.uid,
    this.photo,
  );

  NotificationUsers.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'] as String,
        email = json['email'] as String,
        detalle = json['detalle'] as String,
        //time = DateTime.parse(json['time'] as String),
        estado = json['estado'] as bool,
        uid = json['uid'] as String,
        photo = json['photo'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'title': title,
        'email': email,
        'detalle': detalle,
        //'time': time.toString(),
        'estado': estado,
        'uid': uid,
        'photo': photo
      };
}
