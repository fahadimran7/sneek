import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  bool _googleLoading = false;

  get googleLoading => _googleLoading;

  final _db = FirebaseFirestore.instance;

  setGoogleLoading(value) {
    _googleLoading = value;
    notifyListeners();
  }

  Future<dynamic> signIn({email, password}) async {
    setLoading(true);

    final res = await _authenticationService.signInWithEmailAndPassword(
        email: email, password: password);

    if (res is! bool) {
      setError(res);
      setLoading(false);
    } else {
      setError('');
      setLoading(false);
    }
  }

  Future<dynamic> loginWithGoogle() async {
    setError('');
    setGoogleLoading(true);

    final res = await _authenticationService.signInWithGoogle();

    if (res is! bool) {
      setError(res);
      setGoogleLoading(false);
      return;
    } else {
      setGoogleLoading(true);

      final uid = _authenticationService.loggedInUser()!.uid;
      final email = _authenticationService.loggedInUser()!.email;
      final name = _authenticationService.loggedInUser()!.displayName;

      final record = await _db.collection('users/').doc(uid).get();

      if (record.exists) {
        setGoogleLoading(false);
        return;
      } else {
        final user = await _userService.addUserToFirestore(
          email: email!,
          name: name!,
          balance: 100,
          uid: uid,
        );

        if (user is bool) {
          setError('');
          setGoogleLoading(false);
        } else {
          setError(user);
          setGoogleLoading(false);
        }
      }
    }
  }
}
