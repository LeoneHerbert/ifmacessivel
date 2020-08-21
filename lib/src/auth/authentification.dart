import 'package:firebase_auth/firebase_auth.dart';

class Authentification {
  Map<String, String> user = Map();
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
      user = data;
      return authResult.user;
    } catch (error) {
      throw error;
    }
  }

  bool passwordRedefinitionViaEmail(String email) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  void passwordRedefinition(String password) async {
    try {
      AuthCredential authCredential = EmailAuthProvider.getCredential(
        email: user['email'].toString().trim(),
        password: user['password'].toString().trim(),
      );
      _currentUser.reauthenticateWithCredential(authCredential);
      _currentUser.updatePassword(password);
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _currentUser = null;
  }
}
