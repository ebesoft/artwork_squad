import 'package:artwork_squad/app/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
