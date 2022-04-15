import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/note.dart';

abstract class BaseNoteRepository {
  Stream<UserData?>? get userNoteStream;
  Future<String> saveNote();
  Future<void> updateNote();
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
      return Note(note: doc['note'] ?? []);
    }).toList();

    return user;
  }

  @override
  Future<void> deleteNote(String noteId) async {
    // final batch = _reader(firebaseFirestoreProvider).batch();
    await noteCollection?.doc(_ref.read(authControllerProvider)?.uid).update({
      "notes": FieldValue.arrayRemove([
        {"noteId": noteId}
      ])
    });
  }

  @override
  Future initializeUserData() async {
    return await noteCollection
        ?.doc(_ref.read(authControllerProvider)?.uid)
        .set({'notes': [], 'noteId': const Uuid().v1()});
  }

  @override
  Future<String> saveNote() {
    // TODO: implement saveNote
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote() {
    // TODO: implement updateNote
    throw UnimplementedError();
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
