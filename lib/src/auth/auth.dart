import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseUser _currentUser;

  String getUserId() {
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

  Future<FirebaseUser> register(Map<String, String> data) async {
    try {
      final AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data['email'].toString().trim(),
              password: data['password'].toString().trim());
      return authResult.user;
    } catch (error) {
      throw error;
    }
  }

  bool resetPasswordViaEmail(String email) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _currentUser = null;
  }
}
