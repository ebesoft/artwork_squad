import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuario = "Sin Registro".obs;
  late Rx<dynamic> _uid = "0".obs;
  String get userf => _usuario.value;
  String get uidrf => _uid.value;

  Future<void> login(theEmail, thePassword) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      print('OK');
      _usuario.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;

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
      _usuario.value = "Sin Registro";
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> ingresarGoogle() async {
    // Trigger the authentication flow

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// Obtain the auth details from the request

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential usuario =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _usuario.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;

      return Future.value(true);
    } catch (e) {
      return Future.error('Error');
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
