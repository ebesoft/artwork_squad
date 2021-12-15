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

  // Post a new
  Stream<QuerySnapshot> readPost() {
    CollectionReference listado = _db.collection('post');

    return listado.snapshots();
  }

  Future<void> createPost(Map<String, dynamic> post) async {
    await _db.collection('post').doc().set(post).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> updatePost(String id, Map<String, dynamic> post) async {
    await _db.collection('post').doc(id).update(post).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarPost(String id) async {
    await _db.collection('post').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }

  // Locations
  Stream<QuerySnapshot> readLocation() {
    CollectionReference listado = _db.collection('location');

    return listado.snapshots();
  }

  Future<void> createLocation(Map<String, dynamic> location) async {
    await _db.collection('location').doc().set(location).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> updateLocation(String id, Map<String, dynamic> location) async {
    await _db.collection('location').doc(id).update(location).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarLocation(String id) async {
    await _db.collection('location').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
