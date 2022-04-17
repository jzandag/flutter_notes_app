import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';

class NoteFormChangeNotifier extends ChangeNotifier {
  int colorId = 0;
  late Note note;

  void changeColor(int color) {
    colorId = color;

    notifyListeners();
  }

  void setNote(Note note) {
    this.note = note;
  }
}
