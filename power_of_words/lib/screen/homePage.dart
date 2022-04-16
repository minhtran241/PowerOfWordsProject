import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_of_words/auth/authentication_service.dart';
import 'package:provider/provider.dart';
import '../model/database.dart';
import '../extension/string_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';
import 'package:timelines/timelines.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    var purple = Color(0xFF3B1B6A);
    var notpurple = Color(0XFFD5D4EA);
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
        width: windowWidth,
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("UserID")
                          .doc(uid)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error = ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          var output = snapshot.data!.data();
                          String gen = output!['gender'];
                          String race = output['race'];
                          int age = output['age'];
                          if (age > 40) {
                          } else {
                            return Container(
                                width: 60,
                                height: 60,
                                child: SvgPicture.asset(
                                    'pic/americanafrican.svg'));
                          }
                        }
                        return Text("Loading");
                      },
                    ),
                  ),
                  Stack(children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: unitHeightValue * 3,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = purple),
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: unitHeightValue * 3, color: notpurple),
                    ),
                  ]),
                  Container(
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("UserID")
                          .doc(uid)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error = ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          var output = snapshot.data!.data();
                          String first = output!['firstName'];
                          String last = output['lastName'];
                          String capfirst = first.capitalize();
                          String caplast = last.capitalize();
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Stack(children: [
                                Text(
                                  "$capfirst $caplast !",
                                  style: TextStyle(
                                      fontSize: unitHeightValue * 3,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = purple),
                                ),
                                Text(
                                  "$capfirst $caplast !",
                                  style: TextStyle(
                                      color: notpurple,
                                      fontSize: unitHeightValue * 3),
                                )
                              ]));
                        }
                        return Text("Loading");
                      },
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
                color: Color(0xFF472973),
                onPressed: () async {
                  await authService.signOut();
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: messageController,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: "What do you have in mine")),
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
                        return Column(children: <Widget>[
                          Row(children: <Widget>[
                            Container(
                                width: 60,
                                height: 60,
                                child: SvgPicture.asset(
                                    'pic/americanafrican.svg')),
                            Text("$dateToString \n $userinput"),
                            SizedBox(
                              height: 120,
                            ),
                          ]),
                        ]);
                      });
                }),
          ),
        ]),
      ),
    ));
  }
}
