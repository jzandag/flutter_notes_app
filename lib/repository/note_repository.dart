import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/storage_controller.dart';
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
    if (user.data != null) {
      user.data?.forEach((note) {
        String? noteId = note.uid;
        Future<List<String>> future =
            _ref.read(storageRepositoryProvider).getNoteImages(noteId ?? '');
        future.then((value) {
          note.images = value;
        });
      });
    }

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
    DocumentReference<Object?>? doc = noteCollection?.doc();
    await doc?.set({
      "title": data.title,
      "note": data.note,
      "create_date": data.createDate,
      "colorId": data.colorId,
      "isPinned": data.isPinned,
      "user_id": userId
    });
    if (_ref.watch(noteChangeNotifier).imgPaths.isNotEmpty) {
      for (int x = 0; x < _ref.watch(noteChangeNotifier).imgPaths.length; x++) {
        _ref.watch(storageControllerProvider).saveNoteImage(
              doc?.id ?? '',
              _ref.watch(noteChangeNotifier).imgPaths[x],
              _ref.watch(noteChangeNotifier).imgFileNames[x],
            );
      }
    }
  }

  @override
  Future<void> updateNote(Note data) async {
    await noteCollection?.doc(data.uid).update({
      "title": data.title,
      "note": data.note,
      "colorId": data.colorId,
      "isPinned": data.isPinned,
    });
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      await noteCollection?.doc(noteId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<UserData?>? get userNoteStream {
    return noteCollection
        ?.where("user_id", isEqualTo: userId)
        .orderBy("isPinned", descending: true)
        .snapshots()
        .map(_noteDataFromSnapshot);
  }
}
