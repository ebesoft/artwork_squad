import 'package:artwork_squad/app/data/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuarior = "Sin Registro".obs;
  late Rx<dynamic> _uid = "0".obs;
  late Rx<dynamic> _name = "".obs;
  
  late Rx<dynamic> _photo =
      "https://firebasestorage.googleapis.com/v0/b/artwork-squad.appspot.com/o/user.png?alt=media&token=7ab87de4-fbd8-4f4b-aaaa-527521220eca"
          .obs;
  String get userf => _usuarior.value;
  
  String get name => _name.value;

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('Users');

  Future<void> register(email, password) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _usuarior.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;
      _name.value = usuario.user!.email;
      //_photo.value = usuario.user!.photoURL;
      //print("Error ${usuario.user!.photoURL}");
      if (usuario.user!.photoURL != null) {
        _photo.value = usuario.user!.photoURL;
      }

      final users = UserModel(_usuarior.value, _uid.value, _photo.value);
      guardarUsuario(users);

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
}
