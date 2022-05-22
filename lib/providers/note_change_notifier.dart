import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';

class NoteFormChangeNotifier extends ChangeNotifier {
  int colorId = 0;
  bool isPinned = false;
  String title = '';
  String main = '';
  List<String> imgPaths = [];
  List<String> imgFileNames = [];
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

  void addImage(Map imgMap) {
    imgPaths.add(imgMap['path']);
    imgFileNames.add(imgMap['fileName']);
    notifyListeners();
  }

  void removeImage(String filePath) {
    int index = imgPaths.indexOf(filePath);
    imgPaths.removeAt(index);
    imgFileNames.removeAt(index);
    notifyListeners();
  }

  void resetForm() {
    main = '';
    title = '';
    imgPaths = [];
    imgFileNames = [];
    colorId = 0;
    notifyListeners();
  }
}
