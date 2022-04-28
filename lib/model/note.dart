import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? uid;
  final String? title;
  final String? note;
  final String? createDate;
  final int? colorId;
  bool? isPinned;
  final String? userId;
  List<String>? images;

  Note(
      {this.uid,
      this.title,
      this.note,
      this.createDate,
      this.colorId,
      this.isPinned,
      this.userId,
      this.images});

  @override
  String toString() {
    return note ?? '';
  }

  static Note fromSnapshot(DocumentSnapshot doc, String userId) {
    return Note(
      note: doc['note'] ?? '',
      createDate: doc['create_date'] ?? '',
      isPinned: doc['isPinned'] ?? '',
      colorId: doc['colorId'] ?? '',
      title: doc['title'] ?? '',
      uid: doc.id,
      userId: userId,
    );
  }
}
