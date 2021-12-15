import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/notification_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ModificarEstado extends GetView<NotificationController> {
  final iddoc;
  final pos;
  final List estado;
  ModificarEstado({required this.estado, this.pos, this.iddoc});

  TextEditingController controltitulo = TextEditingController();
  TextEditingController controldetalle = TextEditingController();
  FirestoreController controlestados = Get.find();
  NotificationController ctrNoti = Get.find();
  Logger _logger = new Logger();

/*
  @override
  void initState() {
    controltitulo =
        TextEditingController(text: widget.estado[widget.pos]['titulo']);
    controldetalle =
        TextEditingController(text: widget.estado[widget.pos]['detalle']);

    // TODO: implement initState
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    controltitulo = TextEditingController(text: estado[pos]['title']);
    controldetalle = TextEditingController(text: estado[pos]['detalle']);
    //Obx(() => ctrNoti.controltitulo.value = controltitulo);
    //ctrNoti.controldetalle.value = estado[pos]['detalle'];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Estado"),
        actions: [
          IconButton(
              tooltip: 'Eliminar Estado',
              icon: Icon(Icons.delete),
              onPressed: () {
                controlestados.eliminarestados(estado[pos].id);
                Get.back();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: controltitulo,
                maxLines: null,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: controldetalle,
                maxLines: null,
                decoration: InputDecoration(labelText: "Detalle"),
              ),
              ElevatedButton(
                child: Text("Modificar Estado"),
                onPressed: () {
                  var estados = <String, dynamic>{
                    'title': controltitulo.text,
                    'detalle': controldetalle.text,
                  };
                  //_logger.i("Ver ${estado}");
                  controlestados.actualizarestado(estado[pos].id, estados);

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
