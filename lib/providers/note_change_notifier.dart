import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';

class NoteFormChangeNotifier extends ChangeNotifier {
  int colorId = 0;
  bool isPinned = false;
  String title = '';
  String main = '';
  late Note note;

  void changeColor(int color) {
    colorId = color;

    notifyListeners();
  }

  void setNote(Note note) {
    this.note = note;
  }

  void reversePinned() {
    note.isPinned = !(note.isPinned ?? false);
    notifyListeners();
  }

  void changeNewNotePinned() {
    isPinned = !isPinned;
    notifyListeners();
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setMain(String main) {
    this.main = main;
  }
}
