import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userInfomation =
      FirebaseFirestore.instance.collection('UserID');
  final CollectionReference messaged =
      FirebaseFirestore.instance.collection('Message');
  //to add user information into the firestore
  Future updateUserData(String firstName, String lastName, int age,
      String gender, String race) async {
    return await userInfomation.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'race': race,
    });
  }

  Future updateMessage(String message, DateTime date) async {
    return await messaged
        .doc(uid)
        .collection("message")
        .doc(date.toString())
        .set({
      'message': message,
      'date': date,
    });
  }
}
