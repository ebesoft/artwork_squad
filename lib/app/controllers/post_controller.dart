import 'package:get/get.dart';

class PostController extends GetxController {
  Rx<dynamic> _detalle = "".obs;
  Rx<dynamic> _image = "".obs;

  get image => _image;

  void imagen() {
    this._image = _image.value;
    update();
  }
}
