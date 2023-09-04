import 'dart:async';
import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinecart/LoginModul/otp_page.dart';
import 'package:onlinecart/Utils/ResponsiveWidget.dart';
import 'package:onlinecart/Utils/delayed_animation.dart';

import 'package:onlinecart/Utils/progress_hud.dart';
import 'package:onlinecart/Widgets/custom_shape.dart';
import 'package:onlinecart/constant/constant.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  double? _height;
  double? _width;
  double? _pixelRatio;
  bool? _large;
  bool? _medium;
  String mobileno = "";
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  final int delayedAmount = 500;
  double? _scale;
  bool mobilemren = false;
  String mobhinttext = "";

  //use check internet connection
  bool isConnection = false;
  bool isViewPassword = true;
  bool _isLoading = false;
  bool _isotp = false;
  String logtoken = "";
  String text = "";
  int maxLength = 10;

  GlobalKey Key_ChangeLanguage = GlobalKey();
  GlobalKey Key_SignInWithOTP = GlobalKey();
  GlobalKey Key_MobileNo = GlobalKey();
  GlobalKey Key_Password = GlobalKey();
  GlobalKey Key_ForgotPassword = GlobalKey();
  GlobalKey Key_SignIn = GlobalKey();
  GlobalKey Key_SignUp = GlobalKey();
  GlobalKey otpkey_MobileNo = GlobalKey();
  GlobalKey otpkey_GetOTP = GlobalKey();
  GlobalKey otpkey_SignUp = GlobalKey();
  GlobalKey otpkey_Password = GlobalKey();

  int isBackButtonActivated = 0;
  BuildContext? _scaffoldContext;

  Future<bool> _onBackPressed() {
    bool override;
    Timer _timer;

    if (isBackButtonActivated > 0) {
      override = true;
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      override = false;

      AnimatedSnackBar.material(
        'Please click BACK again to exit',
        type: AnimatedSnackBarType.warning,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
      isBackButtonActivated++;
    }
    _timer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        isBackButtonActivated = 0;
      });
    });
    return new Future<bool>.value(override);
  }

  AnimationController? _animationController;

  @override
  void initState() {

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController?.addListener(() => setState(() {}));
    _animationController?.repeat();
    super.initState();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    _medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    _scale = 1 - _animationController!.value;
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Builder(builder: (BuildContext context) {
          _scaffoldContext = context;
          return WillPopScope(
            onWillPop: _onBackPressed,
            child: ProgressHUD(
              inAsyncCall: _isLoading,
              opacity: 0.0,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DelayedAnimation(
                        delay: delayedAmount + 500, child: welcomeTextRow()),
                    DelayedAnimation(delay: delayedAmount + 800, child: form()),
                    SizedBox(height: _height! / 12),
                    DelayedAnimation(
                        delay: delayedAmount + 1000, child: button()),
                    const SizedBox(height: 10),

                    // helpLineRow(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large!
                  ? _height! / 4
                  : (_medium! ? _height! / 3.75 : _height! / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200]!, Colors.pinkAccent],
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
                  ? _height! / 4.5
                  : (_medium! ? _height! / 4.25 : _height! / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200]!, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large!
                  ? _height! / 30
                  : (_medium! ? _height! / 25 : _height! / 20)),
          child: Container(
            alignment: Alignment.bottomCenter,
            height: _large! ? 130 : (_medium! ? 125 : 120),
            width: _large! ? 130 : (_medium! ? 125 : 120),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(7, 86, 127, 1),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/icons.png',
                ),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Colors.red, width: 0.0),
              borderRadius: const BorderRadius.all(Radius.circular(80.0)),
            ),
          ),
        ),
        FadeTransition(
          opacity: _animationController!,
          child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 20.0),
              margin: EdgeInsets.only(
                  top: _large!
                      ? _height! / 25
                      : (_medium! ? _height! / 20 : _height! / 15)),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: const EdgeInsets.only(top: 200.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: _large! ? 23 : (_medium! ? 20 : 18),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Enter Your Phone Number to continue",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                  fontSize: _large! ? 20 : (_medium! ? 15 : 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width! / 12.0, right: _width! / 12.0, top: _height! / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[mobileTextFormField()],
        ),
      ),
    );
  }

  Widget mobileTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large! ? 12 : (_medium! ? 10 : 8),
      child: TextFormField(
        key: (_isotp == true) ? otpkey_MobileNo : Key_MobileNo,
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        controller: _mobileController,
        keyboardType: TextInputType.number,
        // cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.star, color: Colors.red[700], size: 20),
          hintText: "Mobile Number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide.none),
        ),

        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      key: Key_SignIn,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
        primary: Colors.white,
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: () async {
        setState(() {
          mobileno = _mobileController.text;
          if (mobileno.isEmpty) {
            AnimatedSnackBar.material(("Please Enter Mobile Number"),
                type: AnimatedSnackBarType.error,
                desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom);
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpPage(
                      mobno: mobileno,
                      isSignPage: true,
                    )));
          }
        });

      },
      child: Container(
        alignment: Alignment.center,
        width: _large!
            ? _width! / 1.4
            : (_medium! ? _width! / 1.5 : _width! / 1.5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.green, Colors.green],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Next',
            style: TextStyle(fontSize: _large! ? 13 : (_medium! ? 12 : 12))),
      ),
    );
  }
}
