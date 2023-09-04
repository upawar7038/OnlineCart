
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinecart/LoginModul/AnimatedSplashScreen.dart';
import 'package:onlinecart/LoginModul/signin.dart';
import 'package:onlinecart/constant/constant.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      MaterialApp(
        title: 'Online Cart',
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          primaryColor: Color.fromRGBO(204, 242, 255, 1),
        ),

        routes: <String, WidgetBuilder>{
          SPALSH: (BuildContext context) => AnimatedSplashScreen(),
          SIGN_IN: (BuildContext context) => SignInPage()
          /*SIGN_UP: (BuildContext context) => SignUpScreen(
            isSignPage: true,
          ),*/
        },
        initialRoute: SPALSH,
      ));
}
