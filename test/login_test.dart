import 'package:artwork_squad/app/app.dart';
import 'package:artwork_squad/app/ui/pages/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

//class MockFirebaseUser extends Mock implements FirebaseUser {}

//class MockAuthResult extends Mock implements AuthResult {}

void main() {
  MockFirebaseAuth auth = MockFirebaseAuth();
  //BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();

  group('Prueba de usuario', () {
    test('Login con email y contraseña', () {});
  });
}
