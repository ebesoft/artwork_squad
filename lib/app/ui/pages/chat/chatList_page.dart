import 'package:artwork_squad/app/controllers/chat_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatUsersModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/widgets/chatList.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Rodrigo Lara",
        message: "Mi hermano!, ¿Un partido hoy?",
        time: "15:30",
        avatarUrl:
            "https://media-exp1.licdn.com/dms/image/C4E03AQFmcFwqwvJNMA/profile-displayphoto-shrink_200_200/0?e=1586995200&v=beta&t=4cwKRH-KwJGyOVUtu82PjVt9ss35d643fH-T7VFhxLQ",
        newMessage: 1),
    ChatUsers(
        name: "Codigo Fuente",
        message: "Hey! Tengo un nuevo video",
        time: "17:30",
        avatarUrl:
            "https://yt3.ggpht.com/a-/AOh14Ggu5Wml45UPksoMVJq2rqctYSp_bLbg3U1zYmoO5g=s288-c-k-c0xffffffff-no-rj-mo",
        newMessage: 1),
    ChatUsers(
        name: "Bill Gates",
        message: "Windows 12 esta disponible!",
        time: "5:00",
        avatarUrl:
            "https://mouse.latercera.com/wp-content/uploads/2018/05/bill.jpg",
        newMessage: 0),
    ChatUsers(
        name: "Rachel",
        message: "Estoy bien, gracias",
        time: "10:30",
        avatarUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWXUImijoB6F3msIRS96kTHW8YpthkyaONhzthSC4v7RYUzFya",
        newMessage: 0),
    ChatUsers(
        name: "Barry Allen",
        message: "Soy el hombre mas rapido",
        time: "12:30",
        avatarUrl:
            "https://pbs.twimg.com/profile_images/1157751049928814592/5zHaCqeT_400x400.jpg",
        newMessage: 0),
    ChatUsers(
        name: "Joe West",
        message: "Te vi con Iris, le diré a Barry",
        time: "18:30",
        avatarUrl:
            "https://elrincondeldchome.files.wordpress.com/2019/06/joe-west.jpg?w=500",
        newMessage: 1),
  ];

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    RealtimeController controlReal = Get.find();

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
                      "Conversaciones recientes",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatList(
                  name: chatUsers[index].name,
                  message: chatUsers[index].message,
                  avatarUrl: chatUsers[index].avatarUrl,
                  time: chatUsers[index].time,
                  newMessage: chatUsers[index].newMessage,
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
