import 'package:artwork_squad/app/controllers/arte_controller.dart';
import 'package:flutter/gestures.dart';

import 'package:get/get.dart';

class ArteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArteController>(() => ArteController());
  }
}
