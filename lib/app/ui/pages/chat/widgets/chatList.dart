import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/chatDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Devuelve la plantilla que contiene los valores.
class ChatWidget extends StatelessWidget {
  final List usuarios;
  ChatWidget({required this.usuarios});

  ChatDetailController detail = Get.find();
  LoginController loginController = Get.find();
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //itemCount: usuarios.length == 0 ? 0 : usuarios.length,
        itemCount: 1,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var salaChat;
          if (loginController.getUid() != usuarios[index]['id']) {
            final uidChat = loginController.getUid();
            // _logger.i(
            //    "Rrsultado: ${usuarios[index]}, ${loginController.getUid()}");
            if (usuarios[index]['chat'] != null) {
              //_logger.i("Final data: ${usuarios[index]['chat'][uidChat]}");
              salaChat = usuarios[index]['chat'][uidChat];
            } else {
              salaChat = null;
            }
            return GestureDetector(
              onTap: () async {
                if (salaChat != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ChatDetailPage(chatUid: salaChat);
                    }),
                  );
                } else {
                  final lastMensaje = "Hola!!";
                  //final members = [loginController.getUid(), widget.id];
                  final members = [
                    loginController.getUid(),
                    usuarios[index]['id'].toString()
                  ];
                  final chat = ChatSala(lastMensaje, DateTime.now(), members);
                  detail.guardarSala(chat, loginController.getUid(),
                      usuarios[index]['id'].toString());

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ChatDetailPage(chatUid: detail.uidSala);
                    }),
                  );
                }
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                usuarios[index]['imgUrl'].toString()),
                            maxRadius: 30,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    usuarios[index]['email'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    usuarios[index]['id'].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),

                                  /*
                          Text(
                            widget.message,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          */
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
            */
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        });
  }
}
