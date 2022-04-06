import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../model/user.dart';
import '../model/database.dart';

//handle connection
class AuthenticationService {
  final auth.FirebaseAuth firebaseAuth;
  AuthenticationService({required this.firebaseAuth});

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(credential.user);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String race,
    required String gender,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = credential.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData(firstName, lastName, age, gender, race);
      return _userFromFirebase(credential.user);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
