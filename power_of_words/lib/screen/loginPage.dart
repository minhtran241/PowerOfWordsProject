import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/authentication_service.dart';
import '../model/user.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Create a text controller  to retrieve the value
  final _textController = TextEditingController();
  String title = "Welcome\nTo\nPower of Words";
  String second =
      "Your Number One Personal Journey.Where every one of your thoughts is cared for properly.\n\nJoin us to improve your mental wellbeing!";
  double topMargin = 90;
  double loginWidth = 0;
  double registerWidth = 0;
  double nextWidth = 0;
  int _pageState = 0;
  double windowHeight = 0;
  double windowWidth = 0;
  double _loginYOffset = 0;
  double _RegisterYOffset = 0;
  double _nextYOffset = 0;
  double _loginXOffset = 0;
  double _registerXOffset = 0;
  double nextXOffset = 0;
  double _loginHeight = 0;
  double _registerHeight = 0;
  double _nextHeight = 0;
  double loginOpacity = 1;
  double registerOpacity = 1;
  var purple = Color(0xFF3B1B6A);
  var notPurple = Color(0xFFD5D4EA);
  bool isKeyboardVisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  DateTime birthday = DateTime(1950 - 05 - 10);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController race = TextEditingController();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final authService = Provider.of<AuthenticationService>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    _loginYOffset = windowHeight;
    _RegisterYOffset = windowHeight;
    _nextYOffset = windowHeight;
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    _loginHeight = windowHeight - 200;
    _registerHeight = windowHeight - 360;
    _nextHeight = windowHeight - 360;
    switch (_pageState) {
      case 0:
        title = "Welcome\nTo\nPower of Words";
        second =
            "Your Number One Personal Journey.Where every one of your thoughts is cared for properly.\n\nJoin us to improve your mental wellbeing!";

        topMargin = 90;
        _loginYOffset = windowHeight;
        _RegisterYOffset = windowHeight;
        _nextYOffset = windowHeight;
        loginWidth = windowWidth;
        registerWidth = windowWidth;
        nextWidth = windowWidth;

        break;
      case 1:
        title = "Welcome\nTo\nPower of Words";
        second = "";
        topMargin = 90.4;
        loginOpacity = 1;
        _loginXOffset = 0;

        loginWidth = windowWidth;

        _loginYOffset = isKeyboardVisible ? 0 : 250;
        _RegisterYOffset = windowHeight;
        _nextYOffset = windowHeight;
        break;
      case 2:
        title = "Create New Account";
        second = "";

        topMargin = 150.5;
        loginOpacity = 0.7;
        registerOpacity = 1;

        _loginXOffset = 20;
        _registerXOffset = 0;

        loginWidth = windowWidth - 40;

        registerWidth = windowWidth;

        _loginYOffset = 230;
        _RegisterYOffset = 250;
        _nextYOffset = windowHeight;
        break;
      case 3:
        title = "Let's finish \nsetting up your account!";
        second = "";

        topMargin = 90.6;
        loginOpacity = 0.5;
        registerOpacity = 0.7;

        _loginXOffset = 40;
        _registerXOffset = 20;
        nextXOffset = 0;

        loginWidth = windowWidth - (2 * _loginXOffset);

        registerWidth = windowWidth - (2 * _registerXOffset);

        nextWidth = windowWidth;

        _loginYOffset = 210;
        _RegisterYOffset = 230;
        _nextYOffset = 250;
    }
    return Material(
        child: Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (_pageState > 0) {
              setState(() {
                _pageState--;
              });
            }
          },
          child: AnimatedContainer(
            width: windowWidth,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 1000),
                  margin: EdgeInsets.only(top: topMargin),
                  child: Column(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(fontSize: 30, color: purple),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(40, 50, 40, 10),
                          child: Text(
                            second,
                            style: TextStyle(fontSize: 15, color: purple),
                            textAlign: TextAlign.center,
                          )),
                    ],
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
                          margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: purple, width: 3),
                              color: notPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Get Start",
                            style: TextStyle(color: purple, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ))),
              ],
            ),
          ),
        ),

        //login
        AnimatedContainer(
          width: loginWidth,
          padding: EdgeInsets.all(40),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
          decoration: BoxDecoration(
              color: notPurple.withOpacity(loginOpacity),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  "Login to Continue",
                  style: TextStyle(color: purple, fontSize: 30),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 100),
                child: Column(children: <Widget>[
                  InputBox(
                    flag: false,
                    btnText: "Email",
                    controller: emailController,
                  ),
                  InputBox(
                    flag: true,
                    btnText: "Password",
                    controller: passwordController,
                  ),
                ]),
              ),
              Flexible(
                  child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    authService.signIn(
                        email: emailController.text,
                        password: passwordController.text);
                  },
                  child: PrimaryButton(btnText: 'Login'),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 2;
                    });
                  },
                  child: PrimaryButton(btnText: 'Sign Up'),
                )
              ]))
            ],
          ),
        ),

        //register
        AnimatedContainer(
          width: registerWidth,
          padding: EdgeInsets.all(40),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform:
              Matrix4.translationValues(_registerXOffset, _RegisterYOffset, 1),
          decoration: BoxDecoration(
              color: notPurple.withOpacity(registerOpacity),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 160),
              child: Column(
                children: <Widget>[
                  InputBox(
                    flag: false,
                    btnText: "Email",
                    controller: email,
                  ),
                  InputBox(
                    flag: true,
                    btnText: "Password",
                    controller: password,
                  ),
                  const Text('Birthday'),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in date picker mode.
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: birthday,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => birthday = newDate);
                        },
                      ),
                    ),
                    // In this example, the date value is formatted manually. You can use intl package
                    // to format the value based on user's locale settings.
                    child: Text(
                      '${birthday.month}-${birthday.day}-${birthday.year}',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _pageState = 3;
                });
              },
              child: PrimaryButton(btnText: "Continue"),
            )
          ]),
        ),

        //next
        AnimatedContainer(
          width: nextWidth,
          padding: EdgeInsets.all(40),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(nextXOffset, _nextYOffset, 1),
          decoration: BoxDecoration(
              color: notPurple,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 70),
                child: Column(
                  children: <Widget>[
                    InputBox(
                      flag: false,
                      btnText: "First Name",
                      controller: firstName,
                    ),
                    InputBox(
                      flag: false,
                      btnText: "Last Name",
                      controller: lastName,
                    ),
                    InputBox(
                      flag: false,
                      btnText: "Gender",
                      controller: gender,
                    ),
                    InputBox(
                      flag: false,
                      btnText: "Race",
                      controller: race,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    User? user = await authService.signUp(
                        email: email.text,
                        password: password.text,
                        firstName: firstName.text,
                        lastName: lastName.text,
                        age: calculateAge(birthday),
                        race: race.text,
                        gender: gender.text);
                    addUser(user!.uid, email.text, password.text, birthday,
                        firstName.text, lastName.text, gender.text, race.text);
                  },
                  child: PrimaryButton(btnText: "Finish")),
            ],
          ),
        ),
      ],
    ));
  }


/*************************************************************************************************
 * In this method, the users information is passed into the method to be inserted into the 
 * database as a new user. 
 * 
 * @param uid - the users id in the database, email - users email, 
 * password - users password to account, birth - users birthday, 
 * first - users first name, last - users last name, gender - users selected gender, 
 * race - users selected race 
 *************************************************************************************************/

  void addUser(String uid, String email, String password, DateTime birth, String first, 
               String last, String gender, String race) {
    //creating a reference to access the Firebase RealTime Database
    final database = FirebaseDatabase.instance.ref();

    //putting all user information into the database - commented parts are the labels
    //in which the values are under
    database.child('user/').child(uid).set({
      'email': email,
      'password': password,
      'birthday': birth.toString(),
      'firstName': first,
      'lastName': last,
      'gender': gender,
      'race': race,
    });
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  final String btnText;
  final TextEditingController controller;
  final bool flag;
  InputBox(
      {required this.btnText, required this.controller, required this.flag});
  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  var purple = Color(0xFF3B1B6A);
  var notPurple = Color.fromRGBO(213, 212, 234, 1);
  var purpleBorder = Color.fromRGBO(202, 201, 229, 1);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2.5, color: purpleBorder),
            borderRadius: BorderRadius.circular(15)),
        child: Container(
            child: TextFormField(
          obscureText: widget.flag,
          controller: widget.controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.btnText,
              hintStyle: TextStyle(
                  fontSize: 30, color: Color.fromRGBO(226, 225, 240, 1)),
              contentPadding: EdgeInsets.only(top: 15, bottom: 15)),
        )));
  }
}

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({required this.btnText});
  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  var purple = Color(0xFF3B1B6A);
  var notPurple = Color(0xFFD5D4EA);
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: notPurple,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: purple, width: 2.5),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Center(
            child: Text(
          widget.btnText,
          style: TextStyle(
            color: purple,
            fontSize: 30,
          ),
        )));
  }
}
