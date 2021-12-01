import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Future<void> register(theEmail, thePassword, theConfirm) async {
    await validacion(
        email: theEmail, password: thePassword, confirm: theConfirm);

    return Future.value(true);
  }

  validacion({email, password, confirm}) {
    String valmail = 'test@mail.com';
    String valpass = 'test123';

    if (email != valmail) {
      if (password == confirm) {
        Get.offNamed(Routes.HOME);
        return true;
      } else {
        return Future.error("Contraseñas no coinciden");
      }
    }

    if (email == valmail) {
      return Future.error("Email ya registrado");
    }
  }
}
