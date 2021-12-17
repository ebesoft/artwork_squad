import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/commentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Trae el detalle del chat.
class CommentDetailPage extends StatefulWidget {
  final String iddoc;

  CommentDetailPage({required this.iddoc});

  @override
  _CommentDetailPageState createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> {
  LoginController loginController = Get.find();
  RealtimeController controlFirebase = Get.find();
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
                Text(
                  'Comentarios',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
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
          /*
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey[100],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          messages[index].name,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          messages[index].comment,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),*/

          // Caja de comentario.
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
                  /* Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 12.0),
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Comentar...",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _enviarMensaje();
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
          ),
        ],
      ),
    );
  }

// Se usa para evitar envio de textos en blanco...
  bool _puedoEnviarMensaje() => detailChat.mensajeController.text.length > 0;

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final comentario = CommentUsers(
          loginController.getUid(),
          detailChat.mensajeController.text,
          loginController.userEmail(),
          DateTime.now());
      controlFirebase.createCommentPost(comentario, widget.iddoc);
      detailChat.clearText();
      setState(() {});
    }
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

  Widget _getListaMensajes() {
    //final Future<Map> mensajes = detailChat.getMensajesDetail(chatUid);
    return Expanded(
      child: FutureBuilder<Map>(
          future: controlFirebase.getComment(widget.iddoc),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            List lists = [];
            //_logger.i("Lista, ${snapshot.data}");
            if (snapshot.hasData) {
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data!;
              values.forEach((key, values) {
                //_logger.i("Lista, ${key}");
                lists.add(values);
              });
              return ListView.builder(
                itemCount: lists.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey[100],
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              lists[index].email,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              lists[index].comment,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Text("Sin mensajes");
          }),
    );
  }
}
