class Note {
  final String? uid;
  final String? title;
  final String? note;
  final String? createDate;
  final int? colorId;
  final bool? isPinned;

  Note(
      {this.uid,
      this.title,
      this.note,
      this.createDate,
      this.colorId,
      this.isPinned});

  @override
  String toString() {
    return note ?? '';
  }
}
