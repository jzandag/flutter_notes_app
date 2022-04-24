import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseStorageRepository {
  Future<void> saveFile(String filePath, String fileName);
}

class StorageRepository implements BaseStorageRepository {
  final Ref _ref;
  final String userId;

  const StorageRepository(this._ref, this.userId);

  @override
  Future<void> saveFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await _ref
          .watch(firebaseStorageProvider)
          .ref('note/<id>/$fileName')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
