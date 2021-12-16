import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class PostController extends GetxController {
  Rx<dynamic> _detalle = "".obs;
  Rx<dynamic> _image = "".obs;

  Logger _logger = new Logger();

  ImagePicker picker = ImagePicker();

  get image => _image;

  imagen(image) {
    _image.value = (image != null) ? File(image.path) : null;
    //_image.value = File(image!.path).obs;
    _logger.i("_Ver $_image.value");
    update();
  }
}
