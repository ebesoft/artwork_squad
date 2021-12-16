import 'dart:io';
import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/controllers/post_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditarPostPage extends StatefulWidget {
  final iddoc;
  final index;
  final List post;
  EditarPostPage({required this.post, this.index, this.iddoc});

  @override
  _EditarPostPageState createState() => _EditarPostPageState();
}

class _EditarPostPageState extends State<EditarPostPage> {
  TextEditingController controldetalle = TextEditingController();
  FirestoreController control = Get.find();
  LoginController user = Get.find();
  PostController controlPost = Get.find();

  ImagePicker picker = ImagePicker();
  var _image;
  var _imagen;
  var urlphoto;

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
  void initState() {
    controldetalle =
        TextEditingController(text: widget.post[widget.index]['detalle']);
    _imagen = widget.post[widget.index]['photoPost'];
    print("Tipo: ${_imagen}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Estado"),
        actions: [
          IconButton(
              tooltip: 'Eliminar Estado',
              icon: Icon(Icons.delete),
              onPressed: () {
                //controlestados.eliminarPost(estado[pos].id);
                Get.back();
              })
        ],
      ),
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
                title: Text(widget.post[widget.index]['email']),
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
                            : Image.network(
                                _imagen,
                                width: 100,
                                height: 150,
                                fit: BoxFit.fitHeight,
                              )),
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
                maxLines: null,
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              ElevatedButton(
                child: Text("Actualizar"),
                onPressed: () {
                  if (_image != null) {
                    urlphoto = _image;
                  } else {
                    urlphoto = null;
                  }
                  var post = <String, dynamic>{
                    'detalle': controldetalle.text,
                    'estado': true,
                    'photo': user.photo,
                    'email': user.userf,
                    'uid': user.getUid(),
                    'photoPost': _imagen,
                  };

                  control.updatePost(
                      widget.post[widget.index].id, post, urlphoto);
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
