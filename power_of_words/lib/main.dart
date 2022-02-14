import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: "Aeonik"),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: LoginPage(),
          ),
        ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _pageState = 0;
  double windowHeight = 0;
  double windowWidth = 0;
  double _loginYOffset = 0;
  double _RegisterYOffset = 0;
  double _nextYOffset = 0;
  double _loginHeight = 0;
  double _registerHeight = 0;
  double _nextHeight = 0;
  var purple = Color(0xFF3B1B6A);
  var notPurple = Color(0xFFD5D4EA);
  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    _loginHeight = windowHeight - 200;
    _registerHeight = windowHeight - 360;
    _nextHeight = windowHeight - 360;
    switch (_pageState) {
      case 0:
        _loginYOffset = windowHeight;
        break;
      case 1:
        _loginYOffset = 220;
        break;
      case 2:
        _loginYOffset = 340;
        _RegisterYOffset = 360;
        break;
      case 3:
        _loginYOffset = 320;
        _RegisterYOffset = 340;
        _nextYOffset = 360;
    }
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 0;
                  });
                },
                //title container
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome\nTo\nPower of Words",
                        style: TextStyle(fontSize: 30, color: purple),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(40, 30, 40, 10),
                          child: Text(
                            "Your Number One Personal Journey.Where every one of your thoughts is cared for properly.\n\nJoin us to improve your mental wellbeing!",
                            style: TextStyle(fontSize: 15, color: purple),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ),
              //picture container
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Image.asset('pic/Frame1.png'),
                  )),
              //button container
              Container(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(30, 0, 20, 30),
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: notPurple,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Get Start",
                          style: TextStyle(color: purple, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ))),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _pageState = 2;
            });
          },
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _loginYOffset, 1),
            decoration: BoxDecoration(
                color: notPurple,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        ),
      ],
    );
  }
}
