import 'package:flutter/material.dart';

var linkStyle = TextStyle(color: Color(0xff57cc99));
var textStyle = TextStyle(color: Colors.black);
var errorStyle = TextStyle(color: Colors.redAccent[100]);
var textInputDecoration = InputDecoration(
  errorStyle: errorStyle,
  hintStyle: TextStyle(color: Colors.grey),
  focusColor: Constants.mainColor,
);
var expenseStyle = TextStyle(color: Colors.redAccent);
var incomeStyle = TextStyle(color: Colors.greenAccent);

class Constants {
  static final mainColor = Colors.redAccent[100];
}
