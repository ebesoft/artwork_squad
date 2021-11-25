import 'package:artwork_squad/blocs/theme.dart';
import 'package:artwork_squad/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppBar {
  //MyAppBar(BuildContext context);

  getAppBar(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return AppBar(
      leading: PopupMenuButton(
        icon: Icon(Icons.menu),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.light_mode),
              title: TextButton(
                onPressed: () => theme.setTheme(ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.lime,
                    backgroundColor: Colors.lime)),
                child: Text('Tema Light'),
              ),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.dark_mode),
              title: TextButton(
                onPressed: () => theme.setTheme(ThemeData.dark()),
                child: Text('Tema Dark'),
              ),
            ),
          ),
        ],
      ),
      title: TextButton(
        onPressed: () => Get.toNamed(HOME_ROUTE),
        child: Text('Artwork Squad'),
        //style: TextStyle(color: Colors.blueAccent),
      ),
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
            child: IconButton(
                icon: Icon(Icons.chat_outlined),
                onPressed: () {
                  Get.toNamed(CHAT_ROUTE);
                })),
        //Icon(Icons.more_vert), Puntos vrticales
      ],
      //backgroundColor: Colors.black87,
    );
  }
}
