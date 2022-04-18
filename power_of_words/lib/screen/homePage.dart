import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:power_of_words/auth/authentication_service.dart';
import 'package:power_of_words/screen/inputPage.dart';
import 'package:power_of_words/screen/loginPage.dart';
import 'package:provider/provider.dart';
import '../extension/string_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> _flag = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    var listViewKey = RectGetter.createGlobalKey();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    var purple = Color(0xFF3B1B6A);
    var notpurple = Color(0XFFD5D4EA);
    String uid;
    String url = "";
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
        floatingActionButton: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: Duration(milliseconds: 400),
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return ValueListenableBuilder(
              valueListenable: _flag,
              builder: (BuildContext context, bool value, Widget? child) {
                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 100),
                    child: value
                        ? FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            backgroundColor: purple,
                            onPressed: openContainer,
                            child: const FaIcon(FontAwesomeIcons.penNib))
                        : SizedBox());
              },
            );
          },
          openBuilder: (BuildContext context, _) {
            return inputPage(
                uid: uid, first: capfirst, last: caplast, url: url);
          },
        ),
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
                        child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
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
                              if (gen == 'Inclusive Male') {
                                url = 'pic/inclusivemale.svg';
                              } else if (gen == 'Inclusive Female') {
                                url = 'pic/inclusivefemale.svg';
                              } else if (race == 'Middle Eastern' &&
                                  gen.toLowerCase() == "male") {
                                url = 'pic/middleman.svg';
                              } else if (age >= 40 &&
                                  gen != 'Inclusive Male' &&
                                  gen != 'Inclusive Female' &&
                                  (race == 'Middle Eastern' &&
                                      gen.toLowerCase() == "male")) {
                                url =
                                    'pic/${race.toLowerCase()}${gen.toLowerCase()}40.svg';
                              } else {
                                url =
                                    'pic/${race.toLowerCase()}${gen.toLowerCase()}20.svg';
                              }
                              return Container(
                                  width: 60,
                                  height: 60,
                                  child: SvgPicture.asset(url));
                            }

                            return Container(
                                height: 10,
                                child: Loading(
                                    indicator: LineScaleIndicator(),
                                    size: 10.0,
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
                        child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
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
                                    size: 10.0,
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
                                size: 10.0,
                                color: notpurple));
                      }
                      final data = snapshot.requireData;

                      if (data.size == 0) {
                        return Column(
                          children: <Widget>[
                            VisibilityDetector(
                                key: Key("This open container"),
                                onVisibilityChanged: (
                                  VisibilityInfo info,
                                ) {
                                  if (info.visibleFraction > 0.2) {
                                    _flag.value = false;
                                  } else {
                                    _flag.value = true;
                                  }

                                  print("${info.visibleFraction}");
                                },
                                child: OpenContainer(
                                  transitionType:
                                      ContainerTransitionType.fadeThrough,
                                  transitionDuration:
                                      Duration(milliseconds: 400),
                                  closedBuilder: (BuildContext context,
                                      VoidCallback openContainer) {
                                    return OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            bottom: 50, left: 15),
                                        minimumSize:
                                            Size(windowWidth - 20, 100),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        side:
                                            BorderSide(width: 2, color: purple),
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
                                        url: url);
                                  },
                                )),
                            SizedBox(
                              height: unitHeightValue * 10,
                            ),
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: data.size + 1,
                            itemBuilder: (contex, index) {
                              String userinput = "";
                              double scoreData = 0.0;
                              String dayinput = "";
                              String hoursinput = "";
                              if (index > 0) {
                                userinput =
                                    data.docs[data.size - (index)]['message'];
                                DateTime dateinput = data
                                    .docs[data.size - (index)]['date']
                                    .toDate();
                                scoreData =
                                    data.docs[data.size - (index)]['score'];

                                dayinput = DateFormat.yMMMd()
                                    .format(dateinput)
                                    .toString();
                                hoursinput = DateFormat.jm()
                                    .format(dateinput)
                                    .toString();
                              }
                              return index == 0
                                  ? VisibilityDetector(
                                      key: Key("This open container"),
                                      onVisibilityChanged: (
                                        VisibilityInfo info,
                                      ) {
                                        if (info.visibleFraction > 0.2) {
                                          _flag.value = false;
                                        } else {
                                          _flag.value = true;
                                        }

                                        print("${info.visibleFraction}");
                                      },
                                      child: OpenContainer(
                                        transitionType:
                                            ContainerTransitionType.fadeThrough,
                                        transitionDuration:
                                            Duration(milliseconds: 400),
                                        closedBuilder: (BuildContext context,
                                            VoidCallback openContainer) {
                                          return OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  bottom: 50, left: 15),
                                              minimumSize:
                                                  Size(windowWidth - 20, 100),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              side: BorderSide(
                                                  width: 2, color: purple),
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
                                              url: url);
                                        },
                                      ))
                                  : TimelineTile(
                                      afterLineStyle: LineStyle(
                                          color: notpurple, thickness: 2),
                                      indicatorStyle: IndicatorStyle(
                                        width: 50,
                                        height: 50,
                                        indicator: SvgPicture.asset(url),
                                        indicatorXY: 0,
                                        padding: const EdgeInsets.only(
                                            top: 30, right: 10),
                                      ),
                                      alignment: TimelineAlign.start,
                                      endChild: Container(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          constraints: const BoxConstraints(
                                            minHeight: 150,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "$dayinput\n$hoursinput",
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("$userinput"),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                      child: scoreData > 0
                                                          ? FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidFaceSmileBeam,
                                                              size:
                                                                  unitHeightValue *
                                                                      2,
                                                              color: Color(
                                                                  0xff66bb6a),
                                                            )
                                                          : scoreData < 0
                                                              ? FaIcon(
                                                                  FontAwesomeIcons
                                                                      .solidFaceSadTear,
                                                                  size:
                                                                      unitHeightValue *
                                                                          2,
                                                                  color: Color(
                                                                      0xffff5722),
                                                                )
                                                              : FaIcon(
                                                                  FontAwesomeIcons
                                                                      .solidFaceMeh,
                                                                  size:
                                                                      unitHeightValue *
                                                                          2,
                                                                  color: Color(
                                                                      0xffffa000),
                                                                )),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      scoreData
                                                          .abs()
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              unitHeightValue *
                                                                  2))
                                                ],
                                              ),
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
