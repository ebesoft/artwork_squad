import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<void> login(theEmail, thePassword) async {
    await validacion(email: theEmail, password: thePassword);

    return Future.value(true);
  }

  validacion({email, password}) {
    String valmail = 'test@mail.com';
    String valpass = 'test123';
    if (email == valmail && password == valpass) {
      Get.offNamed(Routes.HOME);
      return true;
    }

    if (email != valmail) {
      return Future.error("Usuario no encontrado");
    }

    if (password != valpass) {
      return Future.error("Contraseña incorrecta");
    }
  }

  /*
  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      print('OK');
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NOK 1');
        return Future.error("Usuario no encontrado");
      } else if (e.code == 'wrong-password') {
        print('NOK 2');
        return Future.error("Contraseña incorrecta");
      }
    }
    print('NOK');
  }

  Future<void> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('La cuenta ya existe para este correo electrónico.');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }
  */
}
