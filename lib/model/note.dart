class Note {
  final String? uid;
  final String? note;

  Note({this.uid, this.note});

  @override
  String toString() {
    return note ?? '';
  }
}
