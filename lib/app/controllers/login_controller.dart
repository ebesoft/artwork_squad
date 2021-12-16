import 'package:artwork_squad/app/data/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuario = "Sin Registro".obs;
  late Rx<dynamic> _uid = "0".obs;
  String get userf => _usuario.value;
  String get uidrf => _uid.value;
  late Rx<dynamic> _photo =
      "https://firebasestorage.googleapis.com/v0/b/artwork-squad.appspot.com/o/user.png?alt=media&token=7ab87de4-fbd8-4f4b-aaaa-527521220eca"
          .obs;

  String get photo => _photo.value;

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('Users');

  Future<void> login(theEmail, thePassword) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);

      _usuario.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;

      //_validarUid.value = await getUser(_uid.value);
      //print("Usuario Existe: ${await getUser(_uid.value)}");
      if (usuario.user!.photoURL != null) {
        _photo.value = usuario.user!.photoURL;
      }
      if (await getUser(_uid.value) == false) {
        final users = UserModel(_usuario.value, _uid.value, _photo.value);
        guardarUsuario(users);
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

      // Una vez que haya iniciado sesión, devuelva la credencial de usuario
      UserCredential usuario =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _usuario.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;
      if (usuario.user!.photoURL != null) {
        _photo.value = usuario.user!.photoURL;
      }
      if (await getUser(_uid.value) == false) {
        final users = UserModel(_usuario.value, _uid.value, _photo.value);
        guardarUsuario(users);
      }

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
  Future getUser(id) async {
    //String _chat;
    final snapshot = await _usersRef.child(id).once();

    if (snapshot.value != null) {
      //Map<dynamic, dynamic> values = snapshot!;
      //_validarUid.value = values;
      //print("Sala: ${snapshot.key}");
      return true;
    }
    return false;
  }
}
