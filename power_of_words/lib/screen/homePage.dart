import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:power_of_words/auth/authentication_service.dart';
import 'package:power_of_words/screen/inputPage.dart';
import 'package:provider/provider.dart';
import '../model/database.dart';
import '../extension/string_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';

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
    String capfirst = "";
    String caplast = "";
    final FirebaseAuth _ath = FirebaseAuth.instance;
    final User? user = _ath.currentUser;
    uid = user!.uid;
    print(uid);
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
                        return Container(
                            height: 10,
                            child: Loading(
                                indicator: LineScaleIndicator(),
                                size: 50.0,
                                color: notpurple));
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
                          capfirst = first.capitalize();
                          caplast = last.capitalize();
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
                        return Container(
                            height: 10,
                            child: Loading(
                                indicator: LineScaleIndicator(),
                                size: 50.0,
                                color: notpurple));
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
          const SizedBox(
            height: 20,
          ),
          OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: Duration(milliseconds: 550),
            closedBuilder: (BuildContext context, VoidCallback openContainer) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.only(bottom: 50, left: 15),
                  minimumSize: Size(windowWidth - 20, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: BorderSide(width: 2, color: purple),
                ),
                onPressed: openContainer,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "What do you have in mine ?",
                      style: TextStyle(
                        color: purple,
                      ),
                      textAlign: TextAlign.left,
                    )),
              );
            },
            openBuilder: (BuildContext context, _) {
              return inputPage(
                  uid: uid,
                  first: capfirst,
                  last: caplast,
                  url: 'pic/americanafrican.svg');
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: mess,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("something wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: 10,
                        child: Loading(
                            indicator: LineScaleIndicator(),
                            size: 50.0,
                            color: notpurple));
                  }
                  final data = snapshot.requireData;

                  if (data.size == 0) {
                    return Container();
                  } else {
                    return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (contex, index) {
                          String userinput =
                              data.docs[data.size - (index + 1)]['message'];
                          DateTime dateinput = data
                              .docs[data.size - (index + 1)]['date']
                              .toDate();
                          String dayinput =
                              DateFormat.yMMMd().format(dateinput).toString();
                          String hoursinput =
                              DateFormat.jm().format(dateinput).toString();
                          return TimelineTile(
                            afterLineStyle:
                                LineStyle(color: notpurple, thickness: 2),
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              height: 50,
                              indicator:
                                  SvgPicture.asset('pic/americanafrican.svg'),
                              indicatorXY: 0,
                              padding:
                                  const EdgeInsets.only(top: 10, right: 10),
                            ),
                            alignment: TimelineAlign.start,
                            endChild: Container(
                                padding: const EdgeInsets.only(top: 20),
                                constraints: const BoxConstraints(
                                  minHeight: 150,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "$dayinput\n$hoursinput",
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("$userinput")
                                  ],
                                )),
                          );
                        });
                  }
                }),
          ),
        ]),
      ),
    ));
  }
}
