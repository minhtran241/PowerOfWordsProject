import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:power_of_words/authentication_service.dart';
import 'package:firebase_auth_mocks/src/mock_user_credential.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
    //_firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}

void main() {
  final MockAuth mockAuth = MockAuth();
  final AuthenticationService auth =
      AuthenticationService(firebaseAuth: mockAuth);

  setUp(() {});
  tearDown(() {});
}
