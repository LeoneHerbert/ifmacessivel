import 'package:firebase_auth/firebase_auth.dart';

class Authentification {
  FirebaseUser _currentUser;

  FirebaseUser getUser() {
    FirebaseAuth.instance.onAuthStateChanged.listen(
      (user) {
        _currentUser = user;
      },
    );
    return _currentUser;
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

  void logout() {
    _currentUser = null;
  }
}
