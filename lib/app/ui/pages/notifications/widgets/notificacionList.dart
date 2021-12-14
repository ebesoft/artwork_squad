import 'package:flutter/material.dart';

// Devuelve la plantilla que contiene los valores.
class NotificationList extends StatelessWidget {
  //String email;
  //String message;
  //String time;
  //bool estado;
  final List estados;
  NotificationList({required this.estados});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemCount: estados.length == 0 ? 0 : estados.length,
        itemBuilder: (context, posicion) {
          return GestureDetector(
            onTap: () {},
            child: Text(
              estados[posicion]['name'],
              style: TextStyle(fontSize: 16),
            ),

            /*
            Container(
              
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  estados[posicion]['name'],
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  estados[posicion]['detalle'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                      fontWeight: estados[posicion]['detalle']
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
                  Text(
                    estados[posicion]['detalle'],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: estados[posicion]['detalle']
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              ),
            ),*/
          );
        });
  }
}
