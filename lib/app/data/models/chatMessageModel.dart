import 'package:flutter/material.dart';

class ChatMessage {
  final String texto;
  final DateTime fecha;
  final String tipo;

  ChatMessage(this.texto, this.fecha, this.tipo);

  ChatMessage.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        texto = json['texto'] as String,
        tipo = json['tipo'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'texto': texto,
        'tipo': tipo,
      };
}
