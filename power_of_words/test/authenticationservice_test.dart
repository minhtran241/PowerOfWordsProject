import 'package:firebase_auth/firebase_auth.dart' as fPrefix;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:power_of_words/main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:power_of_words/authentication_service.dart' as authent;
import 'package:power_of_words/user.dart' as mPrefix;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MockFirebaseAuth extends Mock implements fPrefix.FirebaseAuth {}

class MockFirebaseUser extends Mock implements fPrefix.User {}

class MockAuthResult extends Mock implements fPrefix.UserCredential {}

// adapted from https://github.com/lohanidamodar/flutter_auth
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MockFirebaseAuth _auth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  when(_auth.authStateChanges()).thenAnswer((_) {
    return _user;
  });
  authent.AuthenticationService _repo = authent.AuthenticationService();
  runApp(MyApp());
  group('user repository test', () {
    when(_auth.signInWithEmailAndPassword(email: "email", password: "password"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.signInWithEmailAndPassword(email: "mail", password: "pass"))
        .thenThrow(() {
      return null;
    });
    test("sign in with email and password", () async {
      mPrefix.User? signedIn =
          await _repo.signIn(email: 'email', password: 'password');
      expect(signedIn?.email, 'email');
      //expect(signedIn?.uid, 'uid');
    });

    // test("sing in fails with incorrect email and password", () async {
    //   mPrefix.User? signedIn =
    //       await _repo.signIn(email: 'email', password: 'password');
    //   expect(signedIn, false);
    // });

    // test('sign out', () async {
    //   await _repo.signOut();
    // });
  });
}
