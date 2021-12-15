import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/blocs/theme.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:artwork_squad/app/ui/pages/authentication/login_page.dart';
import 'package:artwork_squad/app/ui/pages/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppBar {
  LoginController loginController = Get.find();

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
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: IconButton(
                icon: Icon(Icons.home_filled),
                onPressed: () {
                  Get.toNamed(Routes.HOME);
                })),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATION);
              }),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  Get.offNamed(Routes.LOCATION);
                })),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: IconButton(
                icon: Icon(Icons.chat_outlined),
                onPressed: () {
                  Get.toNamed(Routes.CHAT);
                })),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                loginController.logOut();
                Get.offAll(() => LoginPage());
              }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://elrincondeldchome.files.wordpress.com/2019/06/joe-west.jpg?w=500'),
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
