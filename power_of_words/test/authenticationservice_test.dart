//import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:power_of_words/authentication_service.dart';
import 'package:power_of_words/user.dart';

import 'mock.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  late AuthenticationService authserv;
  setupCloudFirestoreMocks();
  Firebase.initializeApp();

  setUp(() async {
    authserv = AuthenticationService();
    WidgetsFlutterBinding.ensureInitialized();
  });

  test("sign in with valid credentials", () async {
    String userEmail = 'dat4@gmail.com';
    String userPass = 'dat123456';
    //Future<User?> credential =
    //    authserv.signIn(email: userEmail, password: userPass);
    await expectLater(authserv.signIn(email: userEmail, password: userPass),
        completion(User('RORKX36biXSDNk6q6wgcRHUSKkC2', 'dat4@gmail.com')));
  });
}
