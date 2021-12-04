import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RealtimeController extends GetxController {
  final dabatabeReference = FirebaseDatabase.instance.reference();

  void createData(String mensaje, String uid) {
    dabatabeReference.child("mensajes").push().set({
      'nombre': mensaje,
      'uid': uid,
    });
  }
}
