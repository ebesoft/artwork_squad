import 'package:artwork_squad/app/bindings/arte_bindings.dart';
import 'package:artwork_squad/app/bindings/chat_binding.dart';
import 'package:artwork_squad/app/bindings/home_binding.dart';
import 'package:artwork_squad/app/bindings/location_binding.dart';
import 'package:artwork_squad/app/bindings/notification_binding.dart';
import 'package:artwork_squad/app/bindings/post_binding.dart';
import 'package:artwork_squad/app/bindings/register_binding.dart';
import 'package:artwork_squad/app/ui/pages/authentication/login_page.dart';
import 'package:artwork_squad/app/ui/pages/authentication/register_page.dart';
import 'package:artwork_squad/app/ui/pages/chat/chatList_page.dart';
import 'package:artwork_squad/app/ui/pages/contenido/home_page.dart';
import 'package:artwork_squad/app/ui/pages/location/location_screen.dart';
import 'package:artwork_squad/app/ui/pages/notifications/notification_page.dart';
import 'package:artwork_squad/app/ui/pages/post/post_page.dart';
import 'package:artwork_squad/app/ui/pages/response/response_page.dart';
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
        binding: ChatBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.NOTIFICATION,
        page: () => NotificationPage(),
        binding: NotificationBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.LOCATION,
        page: () => LocationPage(),
        binding: LocationBinding(),
        transition: Transition.zoom),
    GetPage(
        name: Routes.POST,
        page: () => PostPage(),
        binding: PostBinding(),
        transition: Transition.zoom),
    GetPage(
        name: Routes.ARTE,
        page: () => ResponsePage(),
        binding: ArteBinding(),
        transition: Transition.zoom),
  ];
}
