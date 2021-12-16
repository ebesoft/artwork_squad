import 'dart:io';
import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/controllers/post_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController controldetalle = TextEditingController();
  FirestoreController control = Get.find();
  LoginController user = Get.find();
  PostController controlPost = Get.find();

  ImagePicker picker = ImagePicker();
  var _image;

  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    _image = (image != null) ? File(image.path) : null;
    //_image = File(image!.path);
    setState(() {
      _image = (image != null) ? File(image.path) : null;
      //_image = File(image!.path);
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      // _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.photo),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(user.userEmail()),
                subtitle: Text('Secondary Text'),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _opcioncamara(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 200,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: _image != null
                          ? Image.file(
                              _image,
                              width: 100,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            )
                          : Icon(
                              Icons.camera_alt_rounded,
                              size: 100,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: controldetalle,
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              ElevatedButton(
                child: Text("Publicar"),
                onPressed: () {
                  var post = <String, dynamic>{
                    'detalle': controldetalle.text,
                    'estado': true,
                    'photo': user.photo,
                    'email': user.userf,
                    'uid': user.getUid(),
                    'photoPost': '',
                    'like': 0,
                    'comment': 0,
                  };

                  control.createPost(post, _image);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//Seleccionar la camara o la galeria

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Imagen de Galeria'),
                      onTap: () {
                        _galeria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Capturar Imagen'),
                    onTap: () {
                      _camara();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
