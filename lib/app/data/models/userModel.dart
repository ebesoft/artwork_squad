import 'package:flutter/material.dart';

class UserModel {
  final String email;
  final String id;
  final String imgUrl;

  UserModel(this.email, this.id, this.imgUrl);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'] as String,
        id = json['id'] as String,
        imgUrl = json['imgUrl'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'email': email,
        'id': id,
        'imgUrl': imgUrl,
      };
}
