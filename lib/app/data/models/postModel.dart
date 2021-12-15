class PostModel {
  final String email;
  final bool estado;
  final String detalle;
  final String photo;
  final String photoPost;
  final String uid;

  PostModel(
    this.email,
    this.estado,
    this.detalle,
    this.photo,
    this.photoPost,
    this.uid,
  );
  PostModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'] as String,
        detalle = json['detalle'] as String,
        estado = json['estado'] as bool,
        photo = json['photo'] as String,
        photoPost = json['photoPost'] as String,
        uid = json['uid'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'email': email,
        'detalle': detalle,
        'estado': estado,
        'photo': photo,
        'photoPost': photoPost,
        'uid': uid,
      };
}
