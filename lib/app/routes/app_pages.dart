import 'package:artwork_squad/app/bindings/home_binding.dart';
import 'package:artwork_squad/app/bindings/register_binding.dart';
import 'package:artwork_squad/app/ui/pages/authentication/login_page.dart';
import 'package:artwork_squad/app/ui/pages/authentication/register_page.dart';
import 'package:artwork_squad/app/ui/pages/chat/chatList_page.dart';
import 'package:artwork_squad/app/ui/pages/contenido/home_page.dart';
import 'package:artwork_squad/app/ui/pages/location/location_screen.dart';
import 'package:artwork_squad/app/ui/pages/notifications/notification_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        transition: Transition.native),
    GetPage(
        name: Routes.SIGNUP,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.CHAT,
        page: () => ChatPage(),
        transition: Transition.native),
    GetPage(
        name: Routes.NOTIFICATION,
        page: () => NotificationPage(),
        transition: Transition.native),
    GetPage(
        name: Routes.LOCATION,
        page: () => LocationPage(),
        transition: Transition.zoom),
  ];
}
