import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/controllers/post_controller.dart';
import 'package:artwork_squad/app/ui/pages/comment/commentDetail.dart';
import 'package:artwork_squad/app/ui/pages/post/editar_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Devuelve la plantilla que contiene los valores.
//class PostWidget extends GetView<PostController> {
class PostWidget extends StatefulWidget {
  final List post;
  final String uid;

  PostWidget({
    required this.post,
    required this.uid,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  RealtimeController controlFirebase = Get.find();
  LoginController loginController = Get.find();
  PostController controlPost = Get.find();
  FirestoreController controlFirestore = Get.find();
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.post.length == 0 ? 0 : widget.post.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final Future _likeVal = controlFirebase.getLike(
              widget.post[index].id, loginController.getUid());
          //_logger.i("Valor esperado: ${_like}");

          var post = <String, dynamic>{
            'detalle': widget.post[index]['detalle'],
            'estado': true,
            'photo': widget.post[index]['photo'],
            'email': widget.post[index]['email'],
            'uid': widget.post[index]['uid'],
            'photoPost': widget.post[index]['photoPost'],
            'like': widget.post[index]['like'],
            'comment': widget.post[index]['comment'],
          };

          return FutureBuilder<dynamic>(
              future: _likeVal, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //_logger.i("Valor esperado: ${snapshot.data}");
                var like = snapshot.data;
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
                                      backgroundImage: NetworkImage(
                                          widget.post[index]['photo']),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: Text(widget.post[index]['email']),
                                    subtitle: Text(""),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      widget.post[index]['detalle'],
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      _getMegusta(like, index, post),
                                      Text(widget.post[index]['like']
                                          .toString()),
                                      IconButton(
                                          padding: const EdgeInsets.all(5.0),
                                          iconSize: 15,
                                          icon:
                                              Icon(Icons.comment_bank_outlined),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return CommentDetailPage(
                                                  iddoc: widget.post[index].id);
                                            }));
                                          }),
                                      Text(widget.post[index]['comment']
                                          .toString()),
                                      (widget.uid == widget.post[index]['uid'])
                                          ? IconButton(
                                              iconSize: 15,
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Get.to(
                                                  () => EditarPostPage(
                                                    post: widget.post,
                                                    index: index,
                                                    iddoc:
                                                        widget.post[index].id,
                                                  ),
                                                );
                                              })
                                          : Text(""),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              widget.post[index]['photoPost'],
                              height: 250,
                              //width: 300,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  Widget _getMegusta(like, index, post) {
    return (like == true)
        ? IconButton(
            iconSize: 15,
            color: Colors.red,
            icon: Icon(Icons.favorite_rounded),
            onPressed: () {
              controlFirebase.createLikePost(
                  widget.post[index].id, widget.uid, false);

              final megusta = widget.post[index]['like'] - 1;
              controlFirestore.likePost(widget.post[index].id, post, megusta);

              setState(() {});
            })
        : IconButton(
            iconSize: 15,
            icon: Icon(Icons.favorite_outline_sharp),
            onPressed: () {
              controlFirebase.createLikePost(
                  widget.post[index].id, widget.uid, true);
              final megusta = widget.post[index]['like'] + 1;
              controlFirestore.likePost(widget.post[index].id, post, megusta);
              setState(() {});
            });
  }
}
