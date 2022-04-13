import 'dart:async';

import 'package:flutter_notes_app/model/UserModel.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController extends StateNotifier<UserModel?> {
  final Reader _reader;

  StreamSubscription<UserModel?>? _authStateChangesSubscription;

  AuthController(this._reader) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _reader(authRepositoryProvider)
        .authStateChange
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _reader(authRepositoryProvider).getCurrentUser();
  }

  Future<void> signOut() async {
    await _reader(authRepositoryProvider).signOut();
  }
}
