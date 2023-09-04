import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
  static showErrorDialog(BuildContext context, String message, String title) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.ERROR,
      title: title,
      desc: message,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.red,
      btnOkText:"Okay" ,
      btnOkOnPress: () {},
    ).show();
  }


  static showSuccesDialog(BuildContext context, String message, String title) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.SUCCES,
      title: title,
      desc: message,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
      btnOkText:  "Okay",
      btnOkOnPress: () {},
    ).show();
  }

  static showSuccesDialogAddProperty(BuildContext context, String message, String title) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.SUCCES,
      title: title,
      desc: message,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
      btnOkText:"Okay",
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
    ).show();
  }
}
