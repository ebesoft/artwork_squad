import 'package:artwork_squad/app/controllers/post_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar1.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 1'),
                  subtitle: Text('Secondary Text'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 12.0),
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Escribir...",
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
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
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.photo_album_outlined),
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art3.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
