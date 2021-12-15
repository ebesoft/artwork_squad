import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgregarEstado extends StatelessWidget {
  TextEditingController controltitulo = TextEditingController();
  TextEditingController controldetalle = TextEditingController();
  FirestoreController controlestados = Get.find();
  LoginController controluser = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Estado"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controltitulo,
                maxLines: null,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              TextField(
                controller: controldetalle,
                maxLines: null,
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              ElevatedButton(
                child: Text("Agregar Estado"),
                onPressed: () {
                  var estados = <String, dynamic>{
                    'title': controltitulo.text,
                    'email': controluser.userEmail(),
                    'detalle': controldetalle.text,
                    'time': DateTime.now(),
                    'estado': false,
                    'uid': controluser.getUid(),
                    'photo': controluser.photo,
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
