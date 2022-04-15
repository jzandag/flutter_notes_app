import 'package:flutter_notes_app/model/note.dart';

class UserData {
  final String? uid;
  List<Note>? data;

  UserData({this.uid});

  @override
  String toString() {
    String userdt = '$uid';
    data?.forEach((element) {
      userdt = '$userdt $element';
    });
    return userdt;
  }
}
