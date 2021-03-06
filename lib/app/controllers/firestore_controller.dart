import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FirestoreController extends GetxController {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
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

  Future<void> createPost(Map<String, dynamic> post, photoPost) async {
    var url = '';
    if (photoPost != null)
      url = await cargarfoto(photoPost, DateTime.now().toString());
    //print(url);
    post['photoPost'] = url.toString();

    await _db.collection('post').doc().set(post).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> updatePost(
      String id, Map<String, dynamic> post, photoPost) async {
    var url = '';
    if (photoPost != null) {
      url = await cargarfoto(photoPost, DateTime.now().toString());
      //print(url);
      post['photoPost'] = url.toString();
    }
    await _db.collection('post').doc(id).update(post).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> likePost(String id, Map<String, dynamic> post, like) async {
    post['like'] = like;
    await _db.collection('post').doc(id).update(post).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> commentPost(String id, comment) async {
    await _db
        .collection('post')
        .doc(id)
        .update({'comment': comment}).catchError((e) {
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

  Future<dynamic> cargarfoto(var foto, var idfoto) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Post");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idfoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    //print('url:' + url.toString());
    return url.toString();
  }

  //control ubicacion
  Stream<QuerySnapshot> readLocations() {
    CollectionReference listado = _db.collection('ubicacion');

    return listado.snapshots();
  }

  Future<void> guardarubicacion(Map<String, dynamic> ubicacion, uid) async {
    await _db.collection('ubicacion').doc(uid).set(ubicacion).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> updateLocation(String id, Map<String, dynamic> location) async {
    await _db.collection('ubicacion').doc(id).update(location).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarLocation(String id) async {
    await _db.collection('ubicacion').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
