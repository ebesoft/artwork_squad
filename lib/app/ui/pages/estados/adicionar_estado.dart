import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AgregarEstado extends StatefulWidget {
  @override
  _AgregarEstadoState createState() => _AgregarEstadoState();
}

class _AgregarEstadoState extends State<AgregarEstado> {
  TextEditingController controltitulo = TextEditingController();
  TextEditingController controldetalle = TextEditingController();
  FirestoreController controlestados = Get.find();
  LoginController controluser = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Estado"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controltitulo,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              TextField(
                controller: controldetalle,
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              ElevatedButton(
                child: Text("Adicioanar Estado"),
                onPressed: () {
                  var estados = <String, dynamic>{
                    'titulo': controltitulo.text,
                    'detalle': controldetalle.text,
                    //'photo': controluser.photorul,
                    'name': controluser.userEmail(),
                    'uid': controluser.getUid(),
                  };

                  controlestados.crearestado(estados);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
