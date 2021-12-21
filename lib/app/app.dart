import 'dart:html';

import 'package:artwork_squad/app/bindings/login_binding.dart';
import 'package:artwork_squad/app/data/blocs/theme.dart';
import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeChanger(
            ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.white,
                backgroundColor: Colors.white),
            false),
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
      defaultTransition: Transition.fade,
      title: 'ARTwork Squad',
      initialRoute: Routes.LOGIN,
      initialBinding: LoginBinding(),
      getPages: AppPages.pages,
    );
  }
}
