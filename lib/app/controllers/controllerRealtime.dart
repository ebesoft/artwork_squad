import 'package:artwork_squad/app/data/models/commentModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RealtimeController extends GetxController {
  late Rx<dynamic> _like = false.obs;
  get like => _like.value;

  final dabatabeReference = FirebaseDatabase.instance.reference();

  // Instancia Post
  final DatabaseReference _post =
      FirebaseDatabase.instance.reference().child('Post');

  final DatabaseReference _comment =
      FirebaseDatabase.instance.reference().child('Comment');

  void createLikePost(String iddoc, String uiduser, bool like) {
    _post.child(iddoc).child(uiduser).set({
      'like': like,
    });
  }

  void createCommentPost(CommentUsers comentario, iddoc) {
    _comment.child(iddoc).set(comentario.toJson());
  }

  // Comprueba que el usuario ya tiene like en el post y devuelve el estado.
  Future<dynamic> getLike(String iddoc, String uid) async {
    //Información de la sala de los usuarios.

    final snapshot = await _post.child(iddoc).child(uid).once();

    if (snapshot.value != null) {
      _like.value = snapshot.value['like'];
      return _like.value;
    }

    return false;
  }

  Future<Map> getComment(id) async {
    final comentario = await _comment.child(id).once();

    if (comentario.value != null) {
      Map<dynamic, dynamic> values = comentario.value!;
      return values;
    }
    return Map();
  }
}
