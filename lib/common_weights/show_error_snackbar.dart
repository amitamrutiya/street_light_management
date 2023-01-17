import 'package:flutter/material.dart';
import 'package:street_light_management/main.dart';

class ShowErrorSnackBar {
  static showSnackBar(
      {required String text, Color? backgroundcolor = Colors.redAccent}) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundcolor,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
