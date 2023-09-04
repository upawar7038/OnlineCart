import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:onlinecart/LoginModul/SignUpScreen.dart';
import 'package:onlinecart/Utils/ResponsiveWidget.dart';
import 'package:onlinecart/Widgets/custom_shape.dart';

String code_enter = "";

class OtpPage extends StatefulWidget {
  bool? isSignPage;
  String? mobno;

  OtpPage({this.mobno, this.isSignPage});

  @override
  OtpPageState createState() =>
      OtpPageState(mobno: mobno!, isSignPage: isSignPage);
}

class OtpPageState extends State<OtpPage> {
  double? _height;
  double? _width;
  double? _pixelRatio;
  bool? _large;
  bool? _medium;
  bool? isViewCode = true;
  String _code = "";
  bool? isSignPage;
  bool? _isResendEnable = true;

  String otpWaitTimeLabel = "";
  String _smsCode = "";
  bool? isListening = false;

  TextEditingController updatepassController = TextEditingController();
  TextEditingController updateconfirmpassController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey Key_nextotp = GlobalKey();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController currController = TextEditingController();

  String? mobno;
  String? otp = "";

  OtpPageState({this.mobno, this.isSignPage, this.otp});

  Future<bool> _onBackPressed() {
    bool? override;

    isSignPage!
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpScreen(
                      isSignPage: true,
                    )))
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpScreen(
                      isSignPage: false,
                    )));

    return Future<bool>.value(override);
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
//    controller5.dispose();
//    controller6.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currController = controller1;
    updatepassController.clear();
    updateconfirmpassController.clear();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    _medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);

    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 2.0),
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.1),
                border: Border.all(
                    width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: BorderRadius.circular(4.0)),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: false,
              decoration: const InputDecoration.collapsed(hintText: ""),
              controller: controller1,
              autofocus: false,
              obscureText: isViewCode!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: _large! ? 26 : (_medium! ? 25 : 24),
                  color: Colors.black),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              border: Border.all(
                  width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.circular(4.0)),
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            decoration: const InputDecoration.collapsed(hintText: ""),
            autofocus: false,
            enabled: false,
            obscureText: isViewCode!,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: _large! ? 26 : (_medium! ? 25 : 24),
                color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              border: Border.all(
                  width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.circular(4.0)),
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: const InputDecoration.collapsed(hintText: ""),
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            obscureText: isViewCode!,
            style: TextStyle(
                fontSize: _large! ? 26 : (_medium! ? 25 : 24),
                color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              border: Border.all(
                  width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.circular(4.0)),
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: const InputDecoration.collapsed(hintText: ""),
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: false,
            obscureText: isViewCode!,
            style: TextStyle(
                fontSize: _large! ? 26 : (_medium! ? 25 : 24),
                color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              border: Border.all(
                  width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.circular(4.0)),
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: const InputDecoration.collapsed(hintText: ""),
            textAlign: TextAlign.center,
            controller: controller5,
            autofocus: false,
            enabled: false,
            obscureText: isViewCode!,
            style: TextStyle(
                fontSize: _large! ? 26 : (_medium! ? 25 : 24),
                color: Colors.black),
          ),
        ),
      ),
      IconButton(
          icon: Icon(isViewCode! ? Icons.remove_red_eye : Icons.visibility_off),
          iconSize: _large! ? 28 : (_medium! ? 26 : 24),
          onPressed: () {
            setState(() {
              if (isViewCode!)
                isViewCode = false;
              else
                isViewCode = true;
            });
          }),
      Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 0.0),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ];

    return Material(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
//        backgroundColor: Color(0xFFeaeaea),
          body: Container(
            height: _height,
            width: _width,
            margin: const EdgeInsets.only(bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.88,
                    child: Container(
                      width: _width,
                      height: _large!
                          ? _height! / 8
                          : (_medium! ? _height! / 7 : _height! / 6.5),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.white],
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(
                                Icons.reply,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                isSignPage!
                                    ? Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                                  isSignPage: true,
                                                )))
                                    : Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                                  isSignPage: false,
                                                )));
                              })
                        ],
                      ),
                    ),
                  ),
                  clipShape(),
                  SizedBox(height: _height! / 80.0),
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GridView.count(
                            crossAxisCount: 7,
                            mainAxisSpacing: 10.0,
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.vertical,
                            children: List<Container>.generate(
                                7,
                                (int index) =>
                                    Container(child: widgetList[index]))),
                      ]),
                  SizedBox(height: _height! / 80.0),
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ElevatedButton(
                          key: Key_nextotp,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            primary: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                          ),
                          onPressed: () {
                            code_enter = controller1.text +
                                controller2.text +
                                controller3.text +
                                controller4.text +
                                controller5.text;
                            if (code_enter.isEmpty) {
                              AnimatedSnackBar.material(
                                      ("Please Enter 5 digit Number OTP"),
                                      type: AnimatedSnackBarType.error,
                                      desktopSnackBarPosition:
                                          DesktopSnackBarPosition.topCenter,
                                      mobileSnackBarPosition:
                                          MobileSnackBarPosition.bottom)
                                  .show(context);
                            } else {
                              isSignPage!
                                  ? Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen(
                                                isSignPage: true,
                                              )))
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen(
                                                isSignPage: false,
                                              )));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _large!
                                ? _width! / 1.4
                                : (_medium! ? _width! / 1.5 : _width! / 1.5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)),
                              gradient: LinearGradient(
                                colors: <Color>[Colors.green, Colors.green],
                              ),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Next',
                                style: TextStyle(
                                    fontSize:
                                        _large! ? 13 : (_medium! ? 12 : 12))),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't receive the code ? ",
                              style: TextStyle(
                                  fontSize: _large! ? 17 : (_medium! ? 16 : 15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Resend ",
                              style: TextStyle(
                                  fontSize: _large! ? 17 : (_medium! ? 16 : 15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ]),
                  SizedBox(height: _height! / 80.0),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("1");
                                },
                                child: Text("1",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("2");
                                },
                                child: Text("2",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("3");
                                },
                                child: Text("3",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("4");
                                },
                                child: Text("4",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("5");
                                },
                                child: Text("5",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  inputTextToField("6");
                                },
                                child: Text("6",
                                    style: TextStyle(
                                        fontSize:
                                            _large! ? 38 : (_medium! ? 35 : 30),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("7");
                              },
                              child: Text("7",
                                  style: TextStyle(
                                      fontSize:
                                          _large! ? 38 : (_medium! ? 35 : 30),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("8");
                              },
                              child: Text("8",
                                  style: TextStyle(
                                      fontSize:
                                          _large! ? 38 : (_medium! ? 35 : 30),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("9");
                              },
                              child: Text("9",
                                  style: TextStyle(
                                      fontSize:
                                          _large! ? 38 : (_medium! ? 35 : 30),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                                onPressed: () async {
                                  code_enter = controller1.text +
                                      controller2.text +
                                      controller3.text +
                                      controller4.text +
                                      controller5.text;
                                  if (code_enter.isEmpty) {
                                    AnimatedSnackBar.material(("Enter OTP"),
                                            type: AnimatedSnackBarType.error,
                                            desktopSnackBarPosition:
                                                DesktopSnackBarPosition
                                                    .topCenter,
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom)
                                        .show(context);
                                  }
                                },
                                child: Image.asset('assets/images/success.png',
                                    width: _large! ? 38 : (_medium! ? 35 : 30),
                                    height:
                                        _large! ? 38 : (_medium! ? 35 : 30))),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("0");
                              },
                              child: Text("0",
                                  style: TextStyle(
                                      fontSize:
                                          _large! ? 38 : (_medium! ? 35 : 30),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                                onPressed: () {
                                  deleteText();
                                },
                                child: Image.asset('assets/images/delete.png',
                                    width: _large! ? 31 : (_medium! ? 30 : 25),
                                    height:
                                        _large! ? 31 : (_medium! ? 30 : 25))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large!
                  ? _height! / 8
                  : (_medium! ? _height! / 7 : _height! / 6.5),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large!
                  ? _height! / 12
                  : (_medium! ? _height! / 11 : _height! / 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Enter OTP Code",
                  style: TextStyle(
                      fontSize: _large! ? 20 : (_medium! ? 19 : 18),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0),
                child: Text(
                  "A verification code has sent to",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: _large! ? 17 : (_medium! ? 16 : 15),
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, top: 2.0, right: 30.0),
                child: Text(
                  "+91 ${"******${mobno!.substring(6, 10)}"}",
                  style: TextStyle(
                      fontSize: _large! ? 17 : (_medium! ? 16 : 15),
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }

    //Edit fourth textField
    else if (currController == controller4) {
      controller4.text = str;
      currController = controller5;
    }

    //Edit fifth textField
    else if (currController == controller5) {
      controller5.text = str;
      currController = controller5;
    }
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller5;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    } else if (currController == controller5) {
      controller4.text = "";
      currController = controller4;
    }
  }
}
