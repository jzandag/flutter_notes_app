import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_notes_app/controller/auth_controller.dart';
import 'package:flutter_notes_app/model/UserModel.dart';
import 'package:flutter_notes_app/providers/note_change_notifier.dart';
import 'package:flutter_notes_app/repository/auth_repository.dart';
import 'package:flutter_notes_app/repository/note_repository.dart';
import 'package:flutter_notes_app/repository/storage_repository.dart';
import 'package:flutter_notes_app/storageService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final firebaseStorageProvider = Provider<FirebaseStorage>(
  (ref) => FirebaseStorage.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read),
);

final noteRepositoryProvider = Provider<NoteRepository>(
  (ref) => NoteRepository(ref, ref.watch(authControllerProvider)?.uid ?? ''),
);

final storageRepositoryProvider = Provider<StorageRepository>((ref) =>
    StorageRepository(ref, ref.watch(authControllerProvider)?.uid ?? ''));

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>(
  (ref) => AuthController(ref.read),
);

final noteChangeNotifier = ChangeNotifierProvider((ref) {
  return NoteFormChangeNotifier();
});

final storageServiceProvider =
    Provider<StorageService>((ref) => StorageService());
