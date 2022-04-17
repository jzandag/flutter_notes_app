import 'package:flutter/material.dart';

var linkStyle = const TextStyle(color: Color(0xff57cc99));
var textStyle = const TextStyle(color: Colors.black);
var errorStyle = TextStyle(color: Colors.redAccent[100]);
var textInputDecoration = InputDecoration(
  errorStyle: errorStyle,
  hintStyle: const TextStyle(color: Colors.grey),
  focusColor: Constants.mainColor,
);

class Constants {
  static const mainColor = Color(0xff99E2B4);
  static const secondaryMainColor = Color(0xff57cc99);

  static const List<Color> notesColorList = [
    Color(0xffffffff), // white
    Color(0xfffdfd96), // yellow
    Color(0xfff5c27d), // orange
    Color(0xfff6cebf), // pink
    Color(0xffe3b7d2), // violet
    Color(0xffbfe7f6), // blue
  ];

  static const titleStyle =
      TextStyle(fontWeight: FontWeight.w900, fontSize: 16);

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  static const appBarTheme = AppBarTheme(
    color: Constants.secondaryMainColor,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 1,
    centerTitle: true,
  );
}
