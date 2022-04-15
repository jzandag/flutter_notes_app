import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/note.dart';

abstract class BaseNoteRepository {
  Stream<UserData?>? get userNoteStream;
  Future<void> saveNote(Note note);
  Future<void> updateNote(Note data);
  Future<void> deleteNote(String noteId);
  Future<dynamic> initializeUserData();
}

class NoteRepository implements BaseNoteRepository {
  final Ref _ref;
  final String userId;
  CollectionReference? noteCollection;

  NoteRepository(this._ref, this.userId) {
    noteCollection = _ref.watch(firebaseFirestoreProvider).collection('notes');
  }

  // transaction data from snapshot
  UserData? _noteDataFromSnapshot(QuerySnapshot snapshot) {
    UserData user = UserData(uid: userId);

    user.data = snapshot.docs
        .map<Note>((doc) => Note.fromSnapshot(doc, userId))
        .toList();

    return user;
  }

  @override
  Future initializeUserData() async {
    return await noteCollection
        ?.doc(_ref.read(authControllerProvider)?.uid)
        .set({'notes': []});
  }

  @override
  Future<void> saveNote(Note data) async {
    await noteCollection?.doc().set({
      "title": data.title,
      "note": data.note,
      "create_date": data.createDate,
      "colorId": data.colorId,
      "isPinned": false,
      "user_id": userId
    });
  }

  @override
  Future<void> updateNote(Note data) async {
    print('update, ' + (data.uid ?? ''));
    await noteCollection?.doc(data.uid).update({
      "title": data.title,
      "note": data.note,
      "colorId": data.colorId,
      "isPinned": false,
    });
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      print('delete function');
      await noteCollection?.doc(noteId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<UserData?>? get userNoteStream {
    print('user note stream' + userId);
    return noteCollection
        ?.where("user_id", isEqualTo: userId)
        .snapshots()
        .map(_noteDataFromSnapshot);
  }
}
