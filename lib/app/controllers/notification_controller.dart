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
    super.onInit();
  }

  // Estado Listo cuando ya se cargaron todas las vistas.
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

// Estado cuando se va ha cerrar la pantalla.
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  title() {
    controltitulo.value;

    update();
  }
}
