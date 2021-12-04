import 'package:artwork_squad/app/controllers/chat_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/data/models/chatMessageModel.dart';
import 'package:artwork_squad/app/ui/pages/contenido/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockChatController extends GetxService
    with Mock
    implements ChatController {
  var messages = <ChatMessage>[].obs;
  @override
  Future<void> sendMsg(String text) async {
    messages.add(ChatMessage('key', text, '001'));
  }
}

class MockAuthenticationController extends GetxService
    with Mock
    implements LoginController {
  @override
  String getUid() {
    return '001';
  }
}

void main() {
  setUp(() {
    MockAuthenticationController mockAuthenticationController =
        MockAuthenticationController();
    Get.put<LoginController>(mockAuthenticationController);

    MockChatController mockChatController = MockChatController();
    Get.put<ChatController>(mockChatController);
  });
  testWidgets('Simple chat test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: HomePage(),
    )));

    await tester.pump();

    await tester.enterText(find.byKey(const Key('MsgTextField')), 'Juan');

    await tester.tap(find.byKey(const Key('sendButton')));

    await tester.pump();

    expect(find.text('Juan'), findsOneWidget);
  });
}
