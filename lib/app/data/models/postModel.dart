class PostModel {
  final String email;
  final bool estado;
  final String detalle;
  final String photo;
  final String photoPost;
  final String uid;
  final int like;
  final int comment;

  PostModel(
    this.email,
    this.estado,
    this.detalle,
    this.photo,
    this.photoPost,
    this.uid,
    this.like,
    this.comment,
  );
  PostModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'] as String,
        detalle = json['detalle'] as String,
        estado = json['estado'] as bool,
        photo = json['photo'] as String,
        photoPost = json['photoPost'] as String,
        uid = json['uid'] as String,
        like = json['like'],
        comment = json['comment'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'email': email,
        'detalle': detalle,
        'estado': estado,
        'photo': photo,
        'photoPost': photoPost,
        'uid': uid,
        'like': like,
        'comment': comment,
      };
}
