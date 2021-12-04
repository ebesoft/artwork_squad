import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/widgets/chatDetail_widget.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

// Trae el detalle del chat.
class ChatDetailPage extends GetView<ChatDetailController> {
  LoginController loginController = Get.find();
  RealtimeController controlReal = Get.find();
  ChatDetailController detailChat = Get.find();

  //_mensajeController = detailChat.mensajeController;
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
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
                  backgroundImage: NetworkImage(
                      "https://elrincondeldchome.files.wordpress.com/2019/06/joe-west.jpg?w=500"),
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
                        "Kriss Benwat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
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
            ),
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
      final mensaje = ChatMessage(
          detailChat.mensajeController.text, DateTime.now(), 'transmitter');
      detailChat.guardarMensaje(mensaje);
      detailChat.clearText();
    }
  }

  Widget _getListaMensajes() {
    return Expanded(
      child: FirebaseAnimatedList(
        query: detailChat.getMensajes(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          //print('Id_unico:${snapshot.key}');
          final mensaje = ChatMessage.fromJson(json);
          _logger.i('Estado $json');
          return MensajeWidget(mensaje.texto, mensaje.fecha, mensaje.tipo);
        },
      ),
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
