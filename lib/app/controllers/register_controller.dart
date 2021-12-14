import 'package:artwork_squad/app/data/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuarior = "Sin Registro".obs;
  late Rx<dynamic> _uid = "0".obs;
  late Rx<dynamic> _photo =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWXUImijoB6F3msIRS96kTHW8YpthkyaONhzthSC4v7RYUzFya"
          .obs;
  String get userf => _usuarior.value;

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('Users');

  Future<void> register(email, password) async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _usuarior.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;
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
