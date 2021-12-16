import 'package:artwork_squad/app/ui/pages/comment/commentDetail.dart';
import 'package:artwork_squad/app/ui/pages/post/editar_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Devuelve la plantilla que contiene los valores.
class PostWidget extends StatelessWidget {
  final List post;
  final String uid;

  PostWidget({
    required this.post,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: post.length == 0 ? 0 : post.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
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
                                backgroundImage:
                                    NetworkImage(post[index]['photo']),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(post[index]['email']),
                              subtitle: Text(""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                post[index]['detalle'],
                                textAlign: TextAlign.justify,
                              ),
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
                                (uid == post[index]['uid'])
                                    ? IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Get.to(
                                            () => EditarPostPage(
                                              post: post,
                                              index: index,
                                              iddoc: post[index].id,
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
                        post[index]['photoPost'],
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
