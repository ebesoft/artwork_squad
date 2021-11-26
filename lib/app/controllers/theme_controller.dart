import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool selectDark = false.obs;

  // Estado inicial
  @override
  void onInit() {
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

  cambioTheme() {
    if (selectDark.value == false) {
      selectDark.value = true;
    }
    update();
  }
}
