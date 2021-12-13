import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Trae el detalle del chat.
class ChatDetailPage extends GetView<ChatDetailController> {
  String chatUid;

  ChatDetailPage(this.chatUid);

  LoginController loginController = Get.find();
  RealtimeController controlReal = Get.find();
  ChatDetailController detailChat = Get.find();

  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    String imagen;

    String email;

    String uidUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: FutureBuilder<Map>(
                future: detailChat.getuser(
                    chatUid,
                    loginController
                        .getUid()), // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                  if (snapshot.hasData) {
                    imagen = snapshot.data!['imgUrl'];
                    email = snapshot.data!['email'];
                    uidUser = snapshot.data!['email'];
                  } else {
                    imagen =
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWXUImijoB6F3msIRS96kTHW8YpthkyaONhzthSC4v7RYUzFya";
                    email = "None";
                    uidUser = "None";
                  }

                  return Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(imagen),
                        maxRadius: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              email,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              uidUser,
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.settings,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _getListaMensajes(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  _textMensaje(),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    //FloatingActionButton(

                    //onPressed: () {
                    // _enviarMensaje();
                    //controlReal.createData(
                    //    _mensajeController.text, loginController.uidrf);
                    //},
                    icon: Icon(
                      _puedoEnviarMensaje()
                          ? Icons.send
                          : Icons.send_and_archive_rounded,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onPressed: () {
                      _enviarMensaje();
                    },
                    //backgroundColor: Colors.blue,
                    // elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _puedoEnviarMensaje() => detailChat.mensajeController.text.length > 0;

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final mensaje = ChatMessage(detailChat.mensajeController.text,
          DateTime.now(), loginController.getUid(), false);
      detailChat.guardarMensaje(mensaje, chatUid);
      detailChat.clearText();
    }
  }

  Widget _getListaMensajes() {
    //final Future<Map> mensajes = detailChat.getMensajesDetail(chatUid);
    return Expanded(
      child: FutureBuilder<Map>(
          future: detailChat.getMensajesDetail(chatUid),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            List lists = [];
            _logger.i("Lista, ${snapshot.data}");
            if (snapshot.hasData) {
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data!;
              values.forEach((key, values) {
                _logger.i("Lista, ${key}");
                lists.add(values);
              });
              return ListView.builder(
                itemCount: lists.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 5),
                        child: Align(
                          // Dependiendo si es emisor o receptor alinea el texto.
                          alignment: (loginController.getUid() !=
                                  lists[index]["sendBy"]
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (loginController.getUid() !=
                                      lists[index]["sendBy"]
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              lists[index]["message"],
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Text("Sin mensajes");
          }),
    );
  }

  Widget _textMensaje() {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.text,
        controller: detailChat.mensajeController,
        //onChanged: (detailChat.mensajeController.text),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
        ),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Escribir...",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
        ),
      ),
    );
  }

/*
  _dateActual() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25
    return formattedDate;
  }*/
}
