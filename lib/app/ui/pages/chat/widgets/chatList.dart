import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/chatDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Devuelve la plantilla que contiene los valores.
class ChatWidget extends StatelessWidget {
  String email;
  String id;
  String imgUrl;

  ChatWidget(this.email, this.id, this.imgUrl);
  ChatDetailController detail = Get.find();
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Future<String> _verificacion =
        detail.getuserChatSala(loginController.getUid());
    return FutureBuilder<String>(
        future: _verificacion, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          // Retiro de la vista mi usuario.
          if (loginController.getUid() != id) {
            return ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //print("Valor encontrado 1 ${snapshot.data}");
                      final chatUid = snapshot.data;
                      if (snapshot.data != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatDetailPage(chatUid!);
                        }));
                      } else {
                        final lastMensaje = "Hola!!";
                        final members = [loginController.getUid(), id];
                        final chat =
                            ChatSala(lastMensaje, DateTime.now(), members);
                        detail.guardarSala(chat, loginController.getUid());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(imgUrl),
                                  maxRadius: 30,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          email,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          id,
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
                });
          }
          return Divider();
        });
  }
}
