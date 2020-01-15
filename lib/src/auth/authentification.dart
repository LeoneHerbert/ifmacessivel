import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentification {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _currentUser;

  FirebaseUser isLogged() {
    if (_currentUser != null) return _currentUser;

    return null;
  }

  void getUser() {
    FirebaseAuth.instance.onAuthStateChanged.listen(
      (user) {
        _currentUser = user;
      },
    );
  }

  Future<FirebaseUser> signIn(Map<String, dynamic> data) async {
    if (_currentUser != null) return _currentUser;

    try {
      final AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: data['email'], password: data['password']);
      _currentUser = authResult.user;
      print(_currentUser.uid);
      return _currentUser;
    } catch (error) {
      throw error;
    }
  }

  void logout(){
    _currentUser = null;
  }
}
