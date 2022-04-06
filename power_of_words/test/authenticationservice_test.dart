// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:power_of_words/authentication_service.dart';
// import 'package:power_of_words/user.dart' as our;
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'mock.dart';

// class MockAuthenticationService extends Mock implements AuthenticationService {}

// void main() async {
//   late AuthenticationService authserv;
//   setupCloudFirestoreMocks();
//   Firebase.initializeApp();

//   setUp(() async {
//     authserv = AuthenticationService();
//     WidgetsFlutterBinding.ensureInitialized();
//   });

//   test("sign up with valid credentials", () async {
//     String userEmail = 'dat4@gmail.com';
//     String userPass = 'dat123456';
//   });
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_of_words/authentication_service.dart';
import 'package:power_of_words/user.dart' as our;

import 'mock.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase firebaseDatabase;
  AuthenticationService authserv;
  const userId = 'userID';
  const firstName = 'Bob';
  const fakeData = {
    'users': {
      userId: {
        'firstName': firstName,
        'email': 'bob@domain.com',
        'password': 'nice123'
      },
      'otherUserId': {
        'firstName': 'userName',
        'email': 'robert@domain.com',
        'password': 'nice1234',
      }
    }
  };
  MockFirebaseDatabase.instance.ref().set(fakeData);
  setUp(() {
    firebaseDatabase = MockFirebaseDatabase.instance;
    //authserv = AuthenticationService();
  });
  authserv = AuthenticationService();
  test('Should receive correct user...', () async {
    final userFromDatabase =
        await authserv.signIn(email: 'bob@domain.com', password: 'nice123');
    expect(
        userFromDatabase,
        equals({
          'firstName': firstName,
          'email': 'bob@domain.com',
        }));
  });
}

// void main() async {
//   // Mock sign in with Google.
//   final googleSignIn = MockGoogleSignIn();
//   final signinAccount = await googleSignIn.signIn();
//   final googleAuth = await signinAccount?.authentication;
//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   // Sign in.
//   final user = MockUser(
//     isAnonymous: false,
//     uid: 'someuid',
//     email: 'bob@somedomain.com',
//     displayName: 'Bob',
//   );
//   final auth = MockFirebaseAuth(mockUser: user);
//   final result = await auth.signInWithCredential(credential);
//   final user1 = await result.user;
//   print(user.displayName);
// }


