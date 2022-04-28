import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseStorageRepository {
  Future<void> saveFile(String noteId, String filePath, String fileName);
}

class StorageRepository implements BaseStorageRepository {
  final Ref _ref;
  final String userId;
  CollectionReference? imageCollection;

  StorageRepository(this._ref, this.userId) {
    imageCollection =
        _ref.watch(firebaseFirestoreProvider).collection('noteImages');
  }

  @override
  Future<void> saveFile(String noteId, String filePath, String fileName) async {
    File file = File(filePath);

    try {
      final ref = await _ref
          .watch(firebaseStorageProvider)
          .ref('note/$userId/$fileName')
          .putFile(file);
      if (ref.state == TaskState.success) {
        String url = await _ref
            .watch(firebaseStorageProvider)
            .ref('note/$userId/$fileName')
            .getDownloadURL();

        print("Here is the URL of Image $url");
        await imageCollection
            ?.doc()
            .set({"url": url, "note_id": noteId, "user_id": userId});
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> getNoteImages(String noteId) async {
    List<String> urls = [];
    await imageCollection
        ?.where("note_id", isEqualTo: noteId)
        .get()
        .then((doc) => urls = doc.docs.map<String>((e) => e['url']).toList());
    return urls;
  }
}
