import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class PostController extends GetxController {
  Rx<dynamic> _detalle = "".obs;
  Rx<dynamic> _image = "".obs;
  RxBool numLike = false.obs;
  late Rx<dynamic> _like = false.obs;

  get like => _like.value;

  Logger _logger = new Logger();

  ImagePicker picker = ImagePicker();

  get image => _image;

  imagen(image) {
    _image.value = (image != null) ? File(image.path) : null;
    //_image.value = File(image!.path).obs;
    _logger.i("_Ver $_image.value");
    update();
  }

  void cambiolike() {
    if (numLike.value == true) {
      numLike.value = false;
    } else {
      numLike.value = true;
    }
  }

  // Estado inicial
  @override
  void onInit() {
    numLike.value;
    // TODO: implement onInit
    super.onInit();
  }
}
