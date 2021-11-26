import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:get/get.dart';

// Inyecta a memoria de cada uno de los controladores.
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
