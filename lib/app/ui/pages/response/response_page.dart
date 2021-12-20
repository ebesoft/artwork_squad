import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:artwork_squad/app/ui/pages/response/widget/response_widget.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  //final ThemeController controller = Get.find();
  //ResponsePage({Key? key}) : super(key: key);

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: ResponseScreen(),
        ),
      ),
    );
  }
}
