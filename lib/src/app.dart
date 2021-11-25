import 'package:artwork_squad/blocs/theme.dart';
import 'package:artwork_squad/src/constants.dart';
import 'package:artwork_squad/src/pages/authentication/login_page.dart';
import 'package:artwork_squad/src/pages/authentication/register_page.dart';

import 'package:artwork_squad/src/pages/chat/chatList_page.dart';

import 'package:artwork_squad/src/pages/contenido/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeChanger(ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            backgroundColor: Colors.white)),
        child: MaterialAppTheme());
  }
}

class MaterialAppTheme extends StatelessWidget {
  const MaterialAppTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      title: 'ARTwork Squad',
      //theme: ThemeData(
      //  primarySwatch: Colors.blueGrey,
      //),
      initialRoute: LOGIN_ROUTE,
      getPages: [
        GetPage(name: LOGIN_ROUTE, page: () => LoginScreen()),
        GetPage(name: SIGNUP_ROUTE, page: () => SignUpScreen()),
        GetPage(
            name: HOME_ROUTE,
            page: () => HomeScreen(),
            transition: Transition.zoom),
        GetPage(
            name: CHAT_ROUTE,
            page: () => ChatListScreen(),
            transition: Transition.zoom),
      ],
    );
  }
}
