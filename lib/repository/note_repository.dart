import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/note.dart';

abstract class BaseNoteRepository {
  Stream<UserData?>? get userNoteStream;
  Future<String> saveNote();
  Future<void> updateNote();
  Future<void> deleteNote();
  Future<dynamic> initializeUserData();
}

class NoteRepository implements BaseNoteRepository {
  final Reader _reader;
  CollectionReference? noteCollection;

  NoteRepository(this._reader) {
    noteCollection = _reader(firebaseFirestoreProvider).collection('notes');
  }

  // transaction data from snapshot
  UserData? _noteDataFromSnapshot(DocumentSnapshot snapshot) {
    UserData user = UserData(uid: _reader(authControllerProvider)?.uid);

    user.data = snapshot.get('note').map<Note>((doc) {
      return Note(note: doc['note'] ?? []);
    }).toList();

    return user;
  }

  @override
  Future<void> deleteNote() {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future initializeUserData() {
    // TODO: implement initializeUserData
    throw UnimplementedError();
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
    return noteCollection
        ?.doc(_reader(authControllerProvider)?.uid)
        .snapshots()
        .map(_noteDataFromSnapshot);
  }
}
