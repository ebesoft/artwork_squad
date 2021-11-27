import 'package:artwork_squad/app/data/blocs/theme.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:artwork_squad/app/ui/pages/post/post_page.dart';
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
              title: Text('Modo Dark'),
              leading: Switch(
                value: theme.getIsDark(),
                activeColor: Colors.purpleAccent,
                onChanged: (_) {
                  if (theme.getIsDark()) {
                    theme.setTheme(
                        ThemeData(
                            brightness: Brightness.light,
                            primaryColor: Colors.white,
                            backgroundColor: Colors.white),
                        false);
                  } else {
                    theme.setTheme(ThemeData.dark(), true);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      title: TextButton(
        onPressed: () => Get.toNamed(Routes.HOME),
        child: Text('Artwork Squad',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.add_circle_outline_outlined),
                onPressed: () {
                  Get.toNamed(Routes.POST);
                })),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(icon: Icon(Icons.favorite), onPressed: () {})),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATION);
              }),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  Get.offNamed(Routes.LOCATION);
                })),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: Icon(Icons.chat_outlined),
                onPressed: () {
                  Get.toNamed(Routes.CHAT);
                })),
      ],
    );
  }
}
