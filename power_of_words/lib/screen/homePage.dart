import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_of_words/auth/authentication_service.dart';
import 'package:provider/provider.dart';
import '../model/database.dart';
import '../extension/string_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String name;
    String uid;
    final FirebaseAuth _ath = FirebaseAuth.instance;
    final User? user = _ath.currentUser;
    uid = user!.uid;
    print(uid);
    TextEditingController messageController = new TextEditingController();
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    //authentication serrivce proivde logout
    final authService = Provider.of<AuthenticationService>(context);
    // documentReference for user information
    DocumentReference doc_ref =
        FirebaseFirestore.instance.collection("UserID").doc(uid);
    //stream for old input journey
    final Stream<QuerySnapshot> mess = FirebaseFirestore.instance
        .collection("Message")
        .doc(uid)
        .collection('message')
        .snapshots();
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("UserID")
                  .doc(uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  var output = snapshot.data!.data();
                  String first = output!['firstName'];
                  String last = output['lastName'];
                  String capfirst = first.capitalize();
                  String caplast = last.capitalize();
                  return Text("Welcome $capfirst $caplast");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          TextField(
              controller: messageController,
              decoration:
                  InputDecoration(hintText: "What do you have in mine")),
          ElevatedButton(
              onPressed: (() async {
                DatabaseService(uid: uid)
                    .updateMessage(messageController.text, DateTime.now());
              }),
              child: Text("Submit")),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: mess,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("something wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final data = snapshot.requireData;
                  print(data.docs[0]['date']);
                  print(data.docs[0]['message']);
                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (contex, index) {
                        String userinput = data.docs[index]['message'];
                        DateTime dateinput = data.docs[index]['date'].toDate();
                        String dateToString = dateinput.toString();
                        return Text("$dateToString \n $userinput");
                      });
                }),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ),
        ]),
      ),
    ));
  }
}
