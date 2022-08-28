import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  Stream<User?> listenToAuthChanges() {
    return _auth.authStateChanges();
  }

  User? loggedInUser() {
    return _auth.currentUser;
  }

  dynamic signInWithEmailAndPassword(
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

  dynamic registerNewUser(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user.user;
    } catch (e) {
      return null;
    }
  }

  logOut() async {
    await _auth.signOut();
  }
}
