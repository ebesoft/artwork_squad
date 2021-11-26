import 'package:artwork_squad/app/app.dart';
import 'package:artwork_squad/app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ThemeController());
  runApp(App());
}
