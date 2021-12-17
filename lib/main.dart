import 'package:artwork_squad/app/app.dart';
import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:artwork_squad/app/controllers/chat_controller.dart';
import 'package:artwork_squad/app/controllers/controllerRealtime.dart';
import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/controllers/notification_controller.dart';
import 'package:artwork_squad/app/controllers/post_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Workmanager().initializer();

  await Firebase.initializeApp();
  Get.put(LoginController());
  Get.put(RealtimeController());
  Get.put(ChatDetailController());
  Get.put(FirestoreController());
  Get.put(ChatController());
  Get.put(NotificationController());
  Get.put(PostController());
  runApp(App());
}

void updatePositionBackground() {}
