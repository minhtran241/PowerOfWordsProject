import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_of_words/model/database.dart';
import 'package:power_of_words/screen/homePage.dart';
import 'package:intl/intl.dart';
import 'package:dart_sentiment/dart_sentiment.dart';

class inputPage extends StatelessWidget {
  final String uid;
  final String first;
  final String last;
  final String url;
  const inputPage(
      {Key? key,
      required String this.uid,
      required String this.first,
      required String this.last,
      required String this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime a = DateTime.now();
    final b = Sentiment();
    String day = DateFormat.yMMMd().format(a).toString();
    String hours = DateFormat.jm().format(a).toString();
    TextEditingController messageController = new TextEditingController();
    var height = MediaQuery.of(context).size.height;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffeeeeee),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0XFFD5D4EA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(width: 2, color: Color(0xFF3B1B6A)),
                  ),
                  onPressed: (() async {
                    var result =
                        b.analysis(messageController.text, emoji: true);
                    DatabaseService(uid: uid).updateMessage(
                        messageController.text,
                        DateTime.now(),
                        result['score']);
                    return Navigator.of(context).pop(null);
                  }),
                  child: Text(
                    "Post",
                    style: TextStyle(color: Color(0xFF3B1B6A)),
                  )),
            ],
          ),
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.xmark),
            color: Color(0xFF472973),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ),
        body: SafeArea(
            child: ListView(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 50, height: 50, child: SvgPicture.asset(url)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: Text(
                          first + " " + last,
                          style: TextStyle(
                              fontSize: unitHeightValue * 3,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Color(0xFF3B1B6A)),
                        ),
                      ),
                      Container(
                        child: Text(first + " " + last,
                            style: TextStyle(
                              color: Color(0XFFD5D4EA),
                              fontSize: unitHeightValue * 3,
                            )),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          child: Text(
                        day + " " + hours,
                        style: TextStyle(
                            fontSize: unitHeightValue * 2,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Color(0xFF3B1B6A)),
                      )),
                      Container(
                          child: Text(
                        day + " " + hours,
                        style: TextStyle(
                          color: Color(0XFFD5D4EA),
                          fontSize: unitHeightValue * 2,
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Container(
                  height: height - 200,
                  child: TextField(
                    maxLines: 50,
                    controller: messageController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Color(0xFF3B1B6A)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Color(0xFF3B1B6A), width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Color(0XFFD5D4EA), width: 2)),
                        hintText: "What do you have in mine"),
                  ),
                ),
              ]))
        ])));
  }
}
