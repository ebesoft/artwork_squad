import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MensajeWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  //final String idmensaje;
  final String tipo;

  MensajeWidget(this.texto, this.fecha, this.tipo);

  @override
  Widget build(BuildContext context) {
    //ChatDetailController controlchat = Get.find();

    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 5),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 5),
          child: Align(
            alignment:
                (tipo == "receiver" ? Alignment.topLeft : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (tipo == "receiver"
                    ? Colors.grey.shade200
                    : Colors.blue[200]),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                texto,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ),
        );
      },
    );
  }
}
