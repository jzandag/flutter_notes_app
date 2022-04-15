import 'package:flutter/material.dart';

var linkStyle = TextStyle(color: Color(0xff57cc99));
var textStyle = TextStyle(color: Colors.black);
var errorStyle = TextStyle(color: Colors.redAccent[100]);
var textInputDecoration = InputDecoration(
  errorStyle: errorStyle,
  hintStyle: TextStyle(color: Colors.grey),
  focusColor: Constants.mainColor,
);

class Constants {
  static const mainColor = Color(0xff99E2B4);
  static const secondaryMainColor = Color(0xff57cc99);

  static const List<Color> notesColorList = [
    Color(0xffffe666), // yellow
    Color(0xfff5c27d), // orange
    Color(0xfff6cebf), // pink
    Color(0xffe3b7d2), // violet
    Color(0xffbfe7f6), // blue
  ];
}
