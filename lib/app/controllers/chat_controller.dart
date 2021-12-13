import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  LoginController loginController = Get.find();

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('Users');

  Query getUsers() => _usersRef;
}
