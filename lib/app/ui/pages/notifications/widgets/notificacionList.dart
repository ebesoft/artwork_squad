import 'package:flutter/material.dart';

// Devuelve la plantilla que contiene los valores.
class NotificationList extends StatelessWidget {
  final List estados;
  final String uidrf;
  NotificationList({required this.estados, required this.uidrf});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemCount: estados.length == 0 ? 0 : estados.length,
        itemBuilder: (context, posicion) {
          return GestureDetector(
              onTap: () {
                if (uidrf == estados[posicion]['uid']) {
                  /*Get.to(() => ModificarEstado(
                                      estado: estados,
                                      pos: posicion,
                                      iddoc: estados[posicion].id,
                                    ));*/

                }
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    estados[posicion]['email'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    estados[posicion]['title'] +
                                        ". " +
                                        estados[posicion]['detalle'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        fontWeight: estados[posicion]['estado']
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*
                    Text(
                      //estados[posicion]['time']
                      //DateFormat('kk:mma')
                      //    .format(estados[posicion]['time'])
                      //    .toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: estados[posicion]['estado']
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),*/
                  ],
                ),
              ));
        });
  }
}
