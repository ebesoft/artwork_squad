import 'package:flutter/material.dart';

class ChatUsers {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int newMessage;

  ChatUsers(
      {required this.name,
      required this.message,
      required this.time,
      required this.avatarUrl,
      required this.newMessage});
}
