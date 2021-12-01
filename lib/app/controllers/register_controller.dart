import 'package:artwork_squad/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuarior = "Sin Registro".obs;
  String get userf => _usuarior.value;

  Future<void> register(email, password) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _usuarior.value = usuario.user!.uid;

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error(
            'La cuenta ya existe para este correo electrónico.');
      }
    }
  }
}
