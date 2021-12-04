import 'package:flutter/material.dart';

class MensajeWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  //final String idmensaje;
  final String tipo;

  MensajeWidget(this.texto, this.fecha, this.tipo);

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
                alignment: (tipo == "receiver"
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: (tipo == "receiver"
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    texto,
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
