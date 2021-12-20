import 'package:artwork_squad/app/controllers/chat_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/userModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/widgets/chatList.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatPage extends GetView<ChatController> {
  LoginController loginController = Get.find();
  RealtimeController controlReal = Get.find();
  ChatController listUsers = Get.find();
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: Stack(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
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
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                ],
              ),
              _getListaUsers(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getListaUsers() {
    return Expanded(
      child: FirebaseAnimatedList(
        query: listUsers.getUsers(),
        itemBuilder: (context, snapshot, animation, index) {
          //final json = snapshot.value as Map<dynamic, dynamic>;
          //_logger.i('Users Sla ${snapshot.value['chat']}');
          //final usuarios = UserModel.fromJson(json);
          //_logger.i('Users id ${usuarios}');
          List data = [];
          data.clear();
          Map<dynamic, dynamic> values = snapshot.value!;
          values.forEach((key, values) {
            //_logger.i("Lista, ${key}");
            data.add(snapshot.value);
          });
          //return ChatWidget(usuarios.email, usuarios.id, usuarios.imgUrl);
          return ChatWidget(usuarios: data);
        },
      ),
    );
  }
}
