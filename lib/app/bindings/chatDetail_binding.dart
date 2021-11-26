import 'package:artwork_squad/app/controllers/chatDetail_controller.dart';
import 'package:get/get.dart';

class ChatDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(() => ChatDetailController());
  }
}
