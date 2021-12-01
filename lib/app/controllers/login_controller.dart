import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuarior = "Sin Registro".obs;
  String get userf => _usuarior.value;

  Future<void> login(theEmail, thePassword) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      print('OK');
      _usuarior.value = usuario.user!.uid;

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
}
