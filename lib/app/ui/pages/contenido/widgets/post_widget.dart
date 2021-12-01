import 'package:artwork_squad/app/ui/pages/chat/chatDetail_page.dart';
import 'package:artwork_squad/app/ui/pages/comment/commentDetail.dart';
import 'package:flutter/material.dart';

// Devuelve la plantilla que contiene los valores.
class PostWidget extends StatefulWidget {
  String name;
  String avatar;
  String estado;
  String message;
  String photo;

  PostWidget({
    required this.name,
    required this.avatar,
    required this.estado,
    required this.message,
    required this.photo,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        //padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Card(
          elevation: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(widget.avatar),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(widget.name),
                        subtitle: Text(widget.estado),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(widget.message),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              icon: Icon(Icons.favorite_outline_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.comment_bank_outlined),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CommentDetailPage();
                                }));
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Image.network(
                  widget.photo,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
