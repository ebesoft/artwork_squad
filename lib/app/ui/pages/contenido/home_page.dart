import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/home_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:artwork_squad/app/ui/pages/contenido/widgets/post_widget.dart';
import 'package:artwork_squad/app/ui/pages/post/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  FirestoreController control = Get.find();
  LoginController user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getInfo(context, control.readPost(), user.uidrf),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => PostPage());
          },
          tooltip: 'Adicionar',
          child: Icon(Icons.add)),
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> post, String uidrf) {
  return StreamBuilder(
    stream: post,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? PostWidget(
                  post: snapshot.data!.docs,
                  uid: uidrf,
                )
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}
