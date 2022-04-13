import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_notes_app/model/UserModel.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// we create abstract repository so we can easily create mock repository incase we implement testing in our app
abstract class BaseAuthRepository {
  Stream<UserModel?> get authStateChanges;
  Future<void> signInAnon();
  UserModel? getCurrentUser();
  Future<void> signOut();
}

class AuthRepository implements BaseAuthRepository {
  final Reader _reader;

  const AuthRepository(this._reader);

  //create user obj based on FirebaseUser
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  @override
  Stream<UserModel?> get authStateChanges => _reader(firebaseAuthProvider)
      .authStateChanges()
      .map(_userFromFirebaseUser);

  @override
  UserModel? getCurrentUser() {
    return _userFromFirebaseUser(_reader(firebaseAuthProvider).currentUser);
  }

  @override
  Future<void> signInAnon() async {
    try {
      UserCredential userCredential =
          await _reader(firebaseAuthProvider).signInAnonymously();
      User? user = userCredential.user;
      UserModel? usr = _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _reader(firebaseAuthProvider).signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
