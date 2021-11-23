import 'package:flutter/material.dart';

class MyAppBar {
  //MyAppBar(BuildContext context);

  getAppBar(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      title: Text('Artwork Squad'),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.add_circle_outline_outlined),
                onPressed: () {})),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(icon: Icon(Icons.favorite), onPressed: () {})),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.notifications_active), onPressed: () {})),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(icon: Icon(Icons.search), onPressed: () {})),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child:
                IconButton(icon: Icon(Icons.chat_outlined), onPressed: () {})),
        //Icon(Icons.more_vert), Puntos vrticales
      ],
      backgroundColor: Colors.black,
    );
  }
}