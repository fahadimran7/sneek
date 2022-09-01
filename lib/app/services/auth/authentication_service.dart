import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  User? loggedInUser() {
    return _auth.currentUser;
  }

  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerNewUser(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user.user;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> logOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
