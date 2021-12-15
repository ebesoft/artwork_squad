import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FirestoreController extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Control de estados.
  Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('estados');

    return listado.snapshots();
  }

  Future<void> crearestado(Map<String, dynamic> estados) async {
    await _db.collection('estados').doc().set(estados).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> actualizarestado(String id, Map<String, dynamic> estados) async {
    print("Data: $id");
    await _db.collection('estados').doc(id).update(estados).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarestados(String id) async {
    await _db.collection('estados').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
