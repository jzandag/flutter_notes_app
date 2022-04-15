import 'dart:async';

import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final noteControllerProvider = StateNotifierProvider<NoteController, UserData?>(
  (ref) => NoteController(ref.read),
);

class NoteController extends StateNotifier<UserData?> {
  final Reader _reader;

  StreamSubscription<UserData?>? _noteStateChangesSubscription;

  NoteController(this._reader) : super(null) {
    _noteStateChangesSubscription?.cancel();
    _noteStateChangesSubscription = _reader(noteRepositoryProvider)
        .userNoteStream
        ?.listen((userData) => state = userData);
  }

  @override
  void dispose() {
    _noteStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _reader(authRepositoryProvider).getCurrentUser();
  }

  Future<void> signOut() async {
    await _reader(authRepositoryProvider).signOut();
  }
}
