import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

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
  UserData? _noteDataFromSnapshot(DocumentSnapshot snapshot) {
    UserData user = UserData(uid: userId);

    user.data = snapshot.get('notes').map<Note>((doc) {
      return Note(
        note: doc['note'] ?? '',
        createDate: doc['create_date'],
        isPinned: doc['isPinned'],
        colorId: doc['colorId'],
        title: doc['title'],
        uid: doc['uid'],
      );
    }).toList();

    return user;
  }

  @override
  Future<void> deleteNote(String noteId) async {
    // final batch = _reader(firebaseFirestoreProvider).batch();
    await noteCollection?.doc(_ref.read(authControllerProvider)?.uid).update({
      "notes": FieldValue.arrayRemove([
        {"uid": noteId}
      ])
    });
  }

  @override
  Future initializeUserData() async {
    return await noteCollection
        ?.doc(_ref.read(authControllerProvider)?.uid)
        .set({'notes': []});
  }

  @override
  Future<void> saveNote(Note data) async {
    await noteCollection?.doc(userId).update({
      "notes": FieldValue.arrayUnion([
        {
          "title": data.title,
          "note": data.note,
          "create_date": data.createDate,
          "uid": const Uuid().v1(),
          "colorId": data.colorId,
          "isPinned": false,
        }
      ])
    });
  }

  @override
  Future<void> updateNote(Note data) async {
    await noteCollection?.doc(userId).update({
      "notes": FieldValue.arrayUnion([
        {
          "title": data.title,
          "note": data.note,
          "create_date": data.createDate,
          "uid": data.uid,
          "colorId": data.colorId,
          "isPinned": false,
        }
      ])
    });
  }

  @override
  Stream<UserData?>? get userNoteStream {
    print('user nnote strwam');
    return noteCollection
        ?.doc(_ref.watch(authControllerProvider)?.uid)
        .snapshots()
        .map(_noteDataFromSnapshot);
  }
}
