import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MensajeWidget extends StatelessWidget {
  final String message;
  final DateTime fecha;
  final String sendBy;
  final bool estado;

  MensajeWidget(this.message, this.fecha, this.sendBy, this.estado);
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 5, bottom: 5),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
              child: Align(
                // Dependiendo si es emisor o receptor alinea el texto.
                alignment: (loginController.getUid() != sendBy
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: (loginController.getUid() != sendBy
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ),
            ),
            /*
            Text(
              DateFormat('yyyyy-MM-dd').format(fecha).toString(),
              style: TextStyle(fontSize: 10),
            ),*/
          ],
        );
      },
    );
  }
}
