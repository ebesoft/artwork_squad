import 'package:artwork_squad/app/controllers/home_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:artwork_squad/app/ui/pages/contenido/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  List<PostWidget> postWidget = [
    PostWidget(
        name: "Rodrigo Lara",
        message:
            "Mi hermano!, ¿Un partido hoy?. Greyhound divisively hello coldly wonderfully marginally far upon excluding. Greyhound divisively hello coldly wonderfully marginally far upon excluding.",
        estado: "15:30",
        avatar:
            "https://yt3.ggpht.com/a-/AOh14Ggu5Wml45UPksoMVJq2rqctYSp_bLbg3U1zYmoO5g=s288-c-k-c0xffffffff-no-rj-mo",
        photo:
            "https://drive.google.com/uc?export=view&id=1x5TxgXbdk0DboeJBivGmcwZZy3TUbrnQ"),
    PostWidget(
        name: "Codigo Fuente",
        message: "Hey! Tengo un nuevo video",
        estado: "17:30",
        avatar:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWXUImijoB6F3msIRS96kTHW8YpthkyaONhzthSC4v7RYUzFya",
        photo:
            "https://drive.google.com/uc?export=view&id=19RkYYSSbnNqRXFarylEd5KMOp4hZrMnE"),
    PostWidget(
        name: "Bill Gates",
        message: "Windows 12 esta disponible!",
        estado: "5:00",
        avatar:
            "https://elrincondeldchome.files.wordpress.com/2019/06/joe-west.jpg?w=500",
        photo:
            "https://drive.google.com/uc?export=view&id=1uEu--y7BXNJ7hJyEQdrZ0E-TYD6cCdMO"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              itemCount: postWidget.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PostWidget(
                  name: postWidget[index].name,
                  message: postWidget[index].message,
                  avatar: postWidget[index].avatar,
                  estado: postWidget[index].estado,
                  photo: postWidget[index].photo,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
