import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_notes_app/model/UserModel.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// we create abstract repository so we can easily create mock repository in case we implement testing in our app
abstract class BaseAuthRepository {
  Stream<UserModel?> get authStateChange;
  Future<void> signInAnon();
  UserModel? getCurrentUser();
  Future<void> signOut();
  Future<dynamic> signInUsingEmailAndPassword(String email, String password);
  Future<dynamic> registerUsingEmailAndPassword(String email, String password);
}

class AuthRepository implements BaseAuthRepository {
  final Reader _reader;

  const AuthRepository(this._reader);

  //create user obj based on FirebaseUser
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  @override
  Stream<UserModel?> get authStateChange => _reader(firebaseAuthProvider)
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
      print('error in signout');
      print(e.toString());
    }
  }

  @override
  Future<dynamic> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = (await _reader(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password));
      User? user = result.user;

      print(user?.uid);
      // initialize user data
      _reader(noteRepositoryProvider).initializeUserData();

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error in register');
      print(e.toString());
      return null;
    }
  }

  @override
  Future<dynamic> signInUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _reader(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
