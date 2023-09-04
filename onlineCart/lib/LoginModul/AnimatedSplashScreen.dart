import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinecart/Utils/ResponsiveWidget.dart';
import 'package:onlinecart/Utils/delayed_animation.dart';
import 'package:onlinecart/constant/constant.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  double? _height;
  double? _width;
  double? _pixelRatio;
  bool? _large;
  bool? _medium;

  var _visible = true;
  double? _scale;

  final int? delayedAmount = 500;
  AnimationController? animationController;
  Animation<double>? animation;
  Timer? _timer;
  int? isBackButtonActivated = 0;

  String? password = '';



  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _checkCurrentApiData);
  }

  _checkCurrentApiData() async {
    if (isInstall == false ||isInstall == null || MobileN == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
    } else {
      Navigator.of(context).pushReplacementNamed(SIGN_IN);
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();
    super.initState();
    setState(() {
      _visible = !_visible;
    });

    startTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    _medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    _scale = 1 - animationController!.value;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              DelayedAnimation(
                delay: delayedAmount! + 1000,
                child: Text(
                  "Welcome to Online Grocery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _large! ? 25 : (_medium! ? 18 : 18)),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/iocn.png',
                width: animation!.value * 1500,
                height: animation!.value * 1500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String logtoken = "";
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  double? _height;
  double? _width;
  double? _pixelRatio;
  bool? _large;
  bool? _medium;

  final pages = [
    PageViewModel(
        pageColor: Colors.white,
       // bubble: Image.asset('assets/images/firstimage.jpeg'),
        body: const Text(
          'Find thousand products from the nearest store and quickly delivery',
        ),
        title: const Text(
          'Find nearest store',
        ),
        // iconColor: Colors.white,
        titleTextStyle: const TextStyle(
            fontSize: 23,
            color: Colors.indigoAccent,
            letterSpacing: 0.6,
            fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 17, color: Colors.blue),
        mainImage: Image.asset(
          'assets/intro/Second.jpeg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.white,
       // bubble: Image.asset('assets/images/Second.jpeg'),
        body:
            const Text('Order fruit and experience fastly and safely delivery'),
        title: const Text(
          'Safe food delivery',
        ),
        // iconColor: Colors.white,
        titleTextStyle: const TextStyle(
            fontSize: 23,
            color: Colors.indigoAccent,
            letterSpacing: 0.6,
            fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 17, color: Colors.blue),
        mainImage: Image.asset(
          'assets/intro/third.jpeg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.white,
       // bubble: Image.asset('assets/images/third.jpeg'),
        body: const Text(
          'Green fruit has less harmful pollution in the production process, so it is safer to eat ',
        ),
        title: const Text(
          'Order fresh fruit',
        ),
        // iconColor: Colors.white,
        titleTextStyle: const TextStyle(
            fontSize: 23,
            color: Colors.indigoAccent,
            letterSpacing: 0.6,
            fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 17, color: Colors.blue),
        mainImage: Image.asset(
          'assets/intro/firstimage.jpeg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    _medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);

    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          setState(() {
            isInstall=true;
            Navigator.of(context).pushReplacementNamed(SIGN_IN);
            Constants.sharedPreferences!.setBool("IsInstall", true) ;
            Constants.sharedPreferences!.commit();

          });

        },
        onTapSkipButton: () {
          setState(() {
            isInstall=true;
            Navigator.of(context).pushReplacementNamed(SIGN_IN);
            Constants.sharedPreferences!.setBool("IsInstall", true);
            Constants.sharedPreferences!.commit();

          });

        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.indigo,
          fontSize: 14.0,
        ),
      ), //IntroViewsFlutter//Builder
    );
  }
}
