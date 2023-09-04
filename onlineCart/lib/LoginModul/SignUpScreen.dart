import 'package:flutter/material.dart';
import 'package:onlinecart/Utils/ResponsiveWidget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

  bool? isSignPage;

  SignUpScreen({super.key, this.isSignPage});
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double? _height;
  double? _width;
  double? _pixelRatio;
  double? _scale;
  bool? _large;
  bool? _medium;

  AnimationController? _animationController;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    _medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);

    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 11.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0))),
                  child: Image.asset(
                    'assets/images/iocn.png',
                    width: _large!
                        ? _height! / 2
                        : (_medium! ? _width! / 2 : _width! / 2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0.0),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                    offset: Offset(5.0, 15.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                    margin: const EdgeInsets.only(top: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nice to Meet you,",
                          style: TextStyle(
                            fontSize: _large! ? 25 : (_medium! ? 20 : 18),
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please Enter your Phone Number to continue",
                          style: TextStyle(
                            fontSize: _large! ? 20 : (_medium! ? 15 : 15),
                            color: Colors.black12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                            child: const Text(
                              "Connect With Phone Number",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: const BoxDecoration(
                              color: Colors.indigo,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                            child: const Text(
                              "Connect With Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                            child: const Text(
                              "Connect With Email",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
