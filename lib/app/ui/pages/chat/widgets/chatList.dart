import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/chat/chatDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Devuelve la plantilla que contiene los valores.
//class ChatWidget extends StatelessWidget {
class ChatWidget extends StatefulWidget {
  String email;
  String id;
  String imgUrl;
  ChatWidget(this.email, this.id, this.imgUrl);
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ChatDetailController detail = Get.find();
  LoginController loginController = Get.find();
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    //final Future<Map> _verificacion =
    //    detail.getuserChatSala(loginController.getUid());
    //return FutureBuilder<dynamic>(
    //future: _verificacion, // a previously-obtained Future<String> or null
    //builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    // Retiro de la vista mi usuario.
    /*
          List lists = [];
          _logger.i("Lista, ${snapshot.data}");
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data!;
            values.forEach((key, values) {
              //_logger.i("Lista, ${key}");
              lists.add(values);
            });
          }*/
    //if (loginController.getUid() != widget.id) {
    return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (loginController.getUid() != widget.id) {
            return FutureBuilder<dynamic>(
                future: detail.getuserChatSala(loginController.getUid()),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  _logger.i("Data Shop: ${snapshot.data}, ${widget.id}");
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.hasData) {
                        final _chatUid = snapshot.data;
                        /*
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatDetailPage(chatUid: _chatUid!);
                        }),);*/
                      } else {
                        final lastMensaje = "Hola!!";
                        final members = [loginController.getUid(), widget.id];
                        final chat =
                            ChatSala(lastMensaje, DateTime.now(), members);
                        detail.guardarSala(
                            chat, loginController.getUid(), widget.id);
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
                                  backgroundImage: NetworkImage(widget.imgUrl),
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
                                          widget.email,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          widget.id,
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
          return SizedBox(
            height: 6,
          );
        });
  }
}
