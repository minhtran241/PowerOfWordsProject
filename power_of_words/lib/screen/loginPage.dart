import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/authentication_service.dart';
import '../model/user.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

late TextEditingController emailController = TextEditingController();
late TextEditingController passwordController = TextEditingController();
late TextEditingController firstName = TextEditingController();
late TextEditingController lastName = TextEditingController();
late TextEditingController gender = TextEditingController();
late TextEditingController race = TextEditingController();

late TextEditingController email = TextEditingController();
late TextEditingController password = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isEmailVaid = false;
  var isPasswordValid = false;
  var isEmailSignUpVaid = false;
  var isPasswordSignUpValid = false;
  var isFirstNameValid = false;
  var isLastNameValid = false;
  double heightratio = 0.0;
  double widthRatio = 0.0;
  double fontSizeBig = 0;
  double fontSizeSmall = 0;
  double fontSizeMedium = 0;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();

    email = TextEditingController();
    password = TextEditingController();
    emailController.addListener(() {
      if (emailController.text.isNotEmpty &&
          emailController.text.contains("@") &&
          emailController.text.contains(".")) {
        setState(() {
          isEmailVaid = true;
        });
      } else {
        setState(() {
          isEmailVaid = false;
        });
      }
    });
    passwordController.addListener(() {
      setState(() {
        isPasswordValid = passwordController.text.isNotEmpty;
      });
    });
    email.addListener(() {
      if (email.text.isNotEmpty &&
          email.text.contains("@") &&
          email.text.contains(".")) {
        setState(() {
          isEmailSignUpVaid = true;
        });
      } else {
        setState(() {
          isEmailSignUpVaid = false;
        });
      }
    });
    password.addListener(() {
      setState(() {
        isPasswordSignUpValid = password.text.isNotEmpty;
      });
    });
    firstName.addListener(() {
      setState(() {
        isFirstNameValid = firstName.text.isNotEmpty;
      });
    });
    lastName.addListener(() {
      setState(() {
        isLastNameValid = lastName.text.isNotEmpty;
      });
    });
  }

  // Create a text controller  to retrieve the value
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
  var dateValid = false;
  DateTime birthday = DateTime(1950 - 05 - 10);

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

  List<String> genderlist = [
    'Male',
    'Female',
    'Inclusive Male',
    'Inclusive Female',
  ];
  List<String> racelist = [
    'Asian',
    'American',
    'African American',
    'Hispanic',
    'European',
    'Middle Eastern',
  ];
  String? selectedGender;
  String? selectedRace;
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final authService = Provider.of<AuthenticationService>(context);

    _loginYOffset = windowHeight;
    _RegisterYOffset = windowHeight;
    _nextYOffset = windowHeight;
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    heightratio = windowHeight / 100;
    widthRatio = windowWidth / 100;
    fontSizeBig = heightratio * 4;
    fontSizeSmall = heightratio * 2;
    fontSizeMedium = heightratio * 2.5;
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
        _loginYOffset = heightratio * 30;
        _RegisterYOffset = windowHeight;
        _nextYOffset = windowHeight;
        break;
      case 2:
        title = "Create New Account";
        second = "";

        topMargin = heightratio * 15;
        loginOpacity = 0.7;
        registerOpacity = 1;

        _loginXOffset = widthRatio * 5;
        _registerXOffset = 0;

        loginWidth = windowWidth - widthRatio * 10;

        registerWidth = windowWidth;
        _loginYOffset = heightratio * 28;
        _RegisterYOffset = heightratio * 30;
        _nextYOffset = windowHeight;
        break;
      case 3:
        title = "Let's finish \nsetting up your account!";
        second = "";

        topMargin = heightratio * 10;
        loginOpacity = 0.5;
        registerOpacity = 0.7;

        _loginXOffset = widthRatio * 7;
        _registerXOffset = widthRatio * 5;
        nextXOffset = 0;

        loginWidth = windowWidth - (2 * _loginXOffset);

        registerWidth = windowWidth - (2 * _registerXOffset);

        nextWidth = windowWidth;

        _loginYOffset = heightratio * 26;
        _RegisterYOffset = heightratio * 28;
        _nextYOffset = heightratio * 30;
    }
    return Material(
        child: Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (_pageState == 3) {
              setState(() {
                _pageState = 2;
              });
            } else if (_pageState == 2) {
              email.clear();
              password.clear();
              firstName.clear();
              lastName.clear();
              race.clear();
              gender.clear();
              setState(() {
                _pageState = 1;
              });
            } else {
              setState(() {
                _pageState = 0;
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
                        style: TextStyle(fontSize: fontSizeBig, color: purple),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(40, 50, 40, 10),
                          child: Text(
                            second,
                            style: TextStyle(
                                fontSize: fontSizeSmall, color: purple),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),

                //picture container
                Container(
                    padding: EdgeInsets.symmetric(horizontal: heightratio * 5),
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
                          margin: EdgeInsets.fromLTRB(widthRatio * 9, 0,
                              widthRatio * 9, heightratio * 6),
                          padding: EdgeInsets.all(widthRatio * 4),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: purple, width: 3),
                              color: notPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Get Start",
                            style:
                                TextStyle(color: purple, fontSize: fontSizeBig),
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
          padding: EdgeInsets.all(widthRatio * 10),
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
                  style: TextStyle(color: purple, fontSize: fontSizeBig),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(top: heightratio * 5),
                child: Column(children: <Widget>[
                  InputBox(
                    flag: false,
                    btnText: "Email",
                    controller: emailController,
                    fontSizehint: fontSizeMedium,
                    fontSizeSmall: fontSizeMedium,
                    height: windowHeight,
                    width: windowWidth,
                  ),
                  SizedBox(height: heightratio * 2),
                  InputBox(
                    flag: true,
                    btnText: "Password",
                    controller: passwordController,
                    fontSizehint: fontSizeMedium,
                    fontSizeSmall: fontSizeMedium,
                    height: windowHeight,
                    width: windowWidth,
                  ),
                ]),
              ),
              SizedBox(height: heightratio * 9),
              Expanded(
                  child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      right: widthRatio * 2, left: widthRatio * 2),
                  width: windowWidth,
                  height: heightratio * 9,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: notPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widthRatio * 4)),
                          side: BorderSide(color: purple, width: 3)),
                      onPressed: isEmailVaid && isPasswordValid
                          ? () {
                              Future<User?> user = authService.signIn(
                                  email: emailController.text,
                                  password: passwordController.text);
                              if (user != null) {
                                emailController.clear();
                                passwordController.clear();
                              }
                            }
                          : null,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: fontSizeBig, color: purple),
                      )),
                ),
                SizedBox(
                  height: heightratio * 3.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: widthRatio * 2, left: widthRatio * 2),
                  width: windowWidth,
                  height: heightratio * 9,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: notPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widthRatio * 4)),
                          side: BorderSide(color: purple, width: 3)),
                      onPressed: () {
                        setState(() {
                          _pageState = 2;
                        });
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: purple, fontSize: fontSizeBig),
                      )),
                ),
              ]))
            ],
          ),
        ),

        //register
        AnimatedContainer(
          width: registerWidth,
          padding: EdgeInsets.all(widthRatio * 10),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform:
              Matrix4.translationValues(_registerXOffset, _RegisterYOffset, 1),
          decoration: BoxDecoration(
              color: notPurple.withOpacity(registerOpacity),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "First Step ",
                  style: TextStyle(color: purple, fontSize: fontSizeBig),
                ),
                SizedBox(
                  height: heightratio * 7,
                ),
                Container(
                  child: InputBox(
                    flag: false,
                    btnText: "Email",
                    controller: email,
                    fontSizehint: fontSizeMedium,
                    fontSizeSmall: fontSizeMedium,
                    height: windowHeight,
                    width: windowWidth,
                  ),
                ),
                SizedBox(
                  height: heightratio * 2,
                ),
                Container(
                  child: Column(children: <Widget>[
                    Container(
                      child: InputBox(
                        flag: true,
                        btnText: "Password",
                        controller: password,
                        fontSizehint: fontSizeMedium,
                        fontSizeSmall: fontSizeMedium,
                        height: windowHeight,
                        width: windowWidth,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 30),
                Text(
                  'Birthday',
                  style: TextStyle(fontSize: 20, color: purple),
                ),
                CupertinoButton(
                  // Display a CupertinoDatePicker in date picker mode.
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: birthday,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          birthday = newDate;
                          if (DateTime.now().year - birthday.year >= 100) {
                            dateValid = false;
                          } else {
                            dateValid = true;
                          }
                        });
                      },
                    ),
                  ),
                  // In this example, the date value is formatted manually. You can use intl package
                  // to format the value based on user's locale settings.
                  child: Text(
                    '${birthday.month}-${birthday.day}-${birthday.year}',
                    style: TextStyle(
                      color: purple,
                      fontSize: fontSizeMedium,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: heightratio * 5,
            ),
            Container(
              margin:
                  EdgeInsets.only(right: widthRatio * 2, left: widthRatio * 2),
              width: windowWidth,
              height: heightratio * 9,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: notPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widthRatio * 4)),
                      side: BorderSide(color: purple, width: 3)),
                  onPressed:
                      isEmailSignUpVaid && isPasswordSignUpValid && dateValid
                          ? () => setState(() {
                                _pageState = 3;
                              })
                          : null,
                  child: Text("Continue",
                      style: TextStyle(
                        color: purple,
                        fontSize: fontSizeBig,
                      ))),
            ),
          ]),
        ),

        //next
        AnimatedContainer(
          width: nextWidth,
          padding: EdgeInsets.all(widthRatio * 10),
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
                margin: EdgeInsets.only(
                    right: widthRatio * 3, left: widthRatio * 3),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Finalizing",
                      style: TextStyle(color: purple, fontSize: fontSizeBig),
                    ),
                    SizedBox(
                      height: heightratio * 3,
                    ),
                    InputBox(
                      flag: false,
                      btnText: "First Name",
                      controller: firstName,
                      fontSizehint: fontSizeMedium,
                      fontSizeSmall: fontSizeMedium,
                      height: windowHeight,
                      width: windowWidth,
                    ),
                    SizedBox(
                      height: heightratio * 2,
                    ),
                    InputBox(
                      flag: false,
                      btnText: "Last Name",
                      controller: lastName,
                      fontSizehint: fontSizeMedium,
                      fontSizeSmall: fontSizeMedium,
                      height: windowHeight,
                      width: windowWidth,
                    ),
                    SizedBox(
                      height: heightratio * 2,
                    ),
                    Container(
                      width: windowWidth,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            buttonPadding: EdgeInsets.all(5),
                            buttonDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2.5,
                                  color: Color.fromRGBO(202, 201, 229, 1)),
                            ),
                            hint: Container(
                              child: Text("Select Your Gender",
                                  style: TextStyle(
                                      color: notPurple,
                                      fontSize: fontSizeMedium)),
                            ),
                            items: genderlist
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: purple,
                                            fontSize: fontSizeSmall),
                                      ),
                                    ))
                                .toList(),
                            value: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value as String;
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: heightratio * 2,
                    ),
                    Container(
                      width: windowWidth,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            dropdownMaxHeight: 120,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: false,
                            buttonPadding: EdgeInsets.all(5),
                            buttonDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2.5,
                                  color: Color.fromRGBO(202, 201, 229, 1)),
                            ),
                            hint: Container(
                              child: Text("Select Your Race",
                                  style: TextStyle(
                                      color: notPurple,
                                      fontSize: fontSizeMedium),
                                  textAlign: TextAlign.center),
                            ),
                            items: racelist
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: purple,
                                            fontSize: fontSizeSmall),
                                      ),
                                    ))
                                .toList(),
                            value: selectedRace,
                            onChanged: (value) {
                              setState(() {
                                selectedRace = value as String;
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: heightratio * 3,
              ),
              Container(
                  margin: EdgeInsets.only(
                      right: widthRatio * 2, left: widthRatio * 2),
                  width: windowWidth,
                  height: heightratio * 9,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: notPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widthRatio * 4)),
                          side: BorderSide(color: purple, width: 3)),
                      onPressed: isFirstNameValid &&
                              isLastNameValid &&
                              isEmailSignUpVaid &&
                              dateValid &&
                              isPasswordSignUpValid &&
                              selectedGender != null &&
                              selectedRace != null
                          ? () async {
                              User? user = await authService.signUp(
                                  email: email.text,
                                  password: password.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  age: calculateAge(birthday),
                                  birthDay: birthday,
                                  race: selectedRace!,
                                  gender: selectedGender!);
                              if (user != null) {
                                email.clear();
                                password.clear();
                                firstName.clear();
                                lastName.clear();
                                race.clear();
                                gender.clear();
                              }
                            }
                          : null,
                      child: Text(
                        "Finish",
                        style: TextStyle(color: purple, fontSize: fontSizeBig),
                      ))),
            ],
          ),
        ),
      ],
    ));
  }

  void addUser(String uid, String email, String password, DateTime birth,
      String first, String last, String gender, String race) {
    final database = FirebaseDatabase.instance.ref();
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
  final double fontSizehint;
  final double fontSizeSmall;
  final double height;
  final double width;
  InputBox(
      {required this.btnText,
      required this.controller,
      required this.flag,
      required this.fontSizehint,
      required this.fontSizeSmall,
      required this.height,
      required this.width});
  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  var purple = Color(0xFF3B1B6A);
  var notPurple = Color.fromRGBO(213, 212, 234, 1);
  var purpleBorder = Color.fromRGBO(202, 201, 229, 1);

  @override
  Widget build(BuildContext context) {
    var contentHeight = widget.height;
    var contentWidth = widget.width;

    return Container(
        width: contentWidth,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2.5, color: purpleBorder),
            borderRadius: BorderRadius.circular(15)),
        child: Container(
            width: contentWidth,
            child: TextFormField(
              style: TextStyle(fontSize: widget.fontSizeSmall, color: purple),
              obscureText: widget.flag,
              controller: widget.controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.btnText,
                  hintStyle: TextStyle(
                      fontSize: widget.fontSizehint,
                      color: Color.fromRGBO(226, 225, 240, 1)),
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
