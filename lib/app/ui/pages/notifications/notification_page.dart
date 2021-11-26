import 'package:artwork_squad/app/controllers/notification_controller.dart';
import 'package:artwork_squad/app/data/models/notificationModel.dart';
import 'package:artwork_squad/app/ui/pages/notifications/notificacionList.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController> {
  List<NotificationUsers> notificationUsers = [
    NotificationUsers(
        name: "Rodrigo Lara",
        message: "Mi hermano!, ¿Un partido hoy?",
        time: "15:30"),
    NotificationUsers(
        name: "Codigo Fuente",
        message: "Hey! Tengo un nuevo video",
        time: "17:30"),
    NotificationUsers(
        name: "Bill Gates",
        message: "Windows 12 esta disponible!",
        time: "5:00"),
    NotificationUsers(
        name: "Rachel", message: "Estoy bien, gracias", time: "10:30"),
    NotificationUsers(
        name: "Barry Allen",
        message: "Soy el hombre mas rapido",
        time: "12:30"),
    NotificationUsers(
        name: "Joe West",
        message: "Te vi con Iris, le diré a Barry",
        time: "18:30"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Notificaciones",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: notificationUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NotificationList(
                  name: notificationUsers[index].name,
                  message: notificationUsers[index].message,
                  time: notificationUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
