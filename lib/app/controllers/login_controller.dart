import 'package:artwork_squad/app/data/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuario = "Sin Registro".obs;
  late Rx<dynamic> _uid = "0".obs;
  late Rx<dynamic> _validarUid = "".obs;
  String get userf => _usuario.value;
  String get uidrf => _uid.value;

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('Users');

  Future<void> login(theEmail, thePassword) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);

      _usuario.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;

      _validarUid.value = getUser(_uid.value);
      //print("Usuario Existe: ${_validarUid.value}");
      if (_validarUid.value) {
        print("Ingreso");
      }
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
      // Autenticación de inicio de sesión de Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Crea nuevas credenciales.
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

  //Crea arbol de usuario
  void guardarUsuario(UserModel users) {
    _usersRef.child(getUid()).set(users.toJson());
  }

// Devuelve instancia del usuario
  Future<String> getUser(id) async {
    //String _chat;
    final snapshot = await _usersRef.child(id).once();

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value!;
      //_validarUid.value = values;
      //print("Sala: ${values['id']}");
      return values['id'].toString();
    }
    return "";
  }
}
