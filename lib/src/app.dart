import 'package:artwork_squad/src/constants.dart';
import 'package:artwork_squad/src/pages/authentication/login_page.dart';
import 'package:artwork_squad/src/pages/authentication/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARTwork Squad',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: LOGIN_ROUTE,
      getPages: [
        GetPage(name: LOGIN_ROUTE, page: () => LoginScreen()),
        GetPage(name: SIGNUP_ROUTE, page: () => SignUpScreen()),
        //GetPage(
        //    name: HOME_ROUTE,
        //    page: () => HomePage(),
        //    transition: Transition.zoom),
      ],
    );
  }
}
