import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentification {
  FirebaseUser _currentUser;

  String getUserId() {
    FirebaseAuth.instance.onAuthStateChanged.listen(
      (user) {
        _currentUser = user;
      },
    );
    return _currentUser.uid;
  }

  Future<FirebaseUser> signIn(Map<String, String> data) async {
    if (_currentUser != null) return _currentUser;

    try {
      final AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data['email'].toString().trim(),
              password: data['password'].toString().trim());
      _currentUser = authResult.user;
      return _currentUser;
    } catch (error) {
      throw error;
    }
  }

  void register(Map<String, String> data) async {
    try {
      final AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: data['email'].toString().trim(),
          password: data['password'].toString().trim());
    } catch (error) {
      throw error;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _currentUser = null;
  }

}
