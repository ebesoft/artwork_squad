import 'package:artwork_squad/app/ui/pages/notifications/widgets/editar_notificacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  Get.to(() => ModificarEstado(
                        estado: estados,
                        pos: posicion,
                        iddoc: estados[posicion].id,
                      ));
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
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            estados[posicion]['photo']),
                                        maxRadius: 30,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            estados[posicion]['email'] +
                                                " - " +
                                                estados[posicion]['title'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            estados[posicion]['detalle'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                                fontWeight: estados[posicion]
                                                        ['estado']
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (uidrf == estados[posicion]['uid'])
                        ? IconButton(
                            onPressed: () {
                              Get.to(() => ModificarEstado(
                                    estado: estados,
                                    pos: posicion,
                                    iddoc: estados[posicion].id,
                                  ));
                            },
                            icon: Icon(Icons.edit),
                          )
                        : Text(''),
                  ],
                ),
              ));
        });
  }
}
