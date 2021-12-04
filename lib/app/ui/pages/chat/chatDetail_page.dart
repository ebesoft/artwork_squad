import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/widgets/chatDetail_widget.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Trae el detalle del chat.
class ChatDetailPage extends GetView<ChatDetailController> {
  TextEditingController _mensajeController = TextEditingController();
  Logger _logger = new Logger();

  LoginController loginController = Get.find();
  RealtimeController controlReal = Get.find();
  ChatDetailController detailChat = Get.find();

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
          //Container(
          //  padding: EdgeInsets.only(right: 16),
          //child:
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
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
                  Flexible(
                    child: _textMensaje(),
                  ),
                  //_textMensaje(),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _enviarMensaje();
                      //controlReal.createData(
                      //    _mensajeController.text, loginController.uidrf);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
            // ),
          ),
        ],
      ),
    );
  }

  void _enviarMensaje() {
    final mensaje =
        ChatMessage(_mensajeController.text, DateTime.now(), 'receiver');
    detailChat.guardarMensaje(mensaje);
    Obx() => _mensajeController.clear();
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
        controller: _mensajeController,
        style: TextStyle(fontSize: 12.0),
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
}
