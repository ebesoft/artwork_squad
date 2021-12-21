import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  Rx<dynamic> controltitulo = "".obs;
  Rx<dynamic> controldetalle = "".obs;

  // Estado inicial
  @override
  void onInit() {
    controltitulo.value;
    // TODO: implement onInit

    String argumento = 'no-data';
    if (Platform.isAndroid ){
      argumento = info ['chat'] ['post'] ['location'] ?? 'No-dada'
    } else {
      argumento = info [post] ?? 'No-data-ios'
    }

    _mensajeStreamControler.sink.add(argumento);


    super.onInit();
  }

  // Estado Listo cuando ya se cargaron todas las vistas.
  @override
  void onReady() {
    // TODO: implement onReady

    String argumento = 'no-data';
    if (Platform.isAndroid ){
      argumento = info ['chat'] ['post'] ['location'] ?? 'No-dada'
    } else {
      argumento = info [post] ?? 'No-data-ios'
    }

    _mensajeStreamControler.sink.add(argumento);

    super.onReady();
  }

// Estado cuando se va ha cerrar la pantalla.
  @override
  void onClose() {
    // TODO: implement onClose

String argumento = 'no-data';
    if (Platform.isAndroid ){
      argumento = info ['chat'] ['post'] ['location'] ?? 'No-dada'
    } else {
      argumento = info [post] ?? 'No-data-ios'
    }

    _mensajeStreamControler.sink.add(argumento);

    super.onClose();
  }
}
