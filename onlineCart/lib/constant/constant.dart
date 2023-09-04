
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

final String SPALSH = 'AnimatedSplashScreen';
final String SIGN_IN = 'signin';
final String SIGN_UP = 'signup';

 bool? isInstall;
String? MobileN = '';

var header = {
  "Content-Type": "application/json",
  "Authorization": "Basic secure@puneit"
};


class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class Constants {
  static SharedPreferences? sharedPreferences;
}
