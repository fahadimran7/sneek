import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  Future<dynamic> signUp({
    email,
    password,
    required String name,
    required num balance,
  }) async {
    setLoading(true);

    final res = await _authenticationService.registerNewUser(
        email: email, password: password);

    if (res is bool) {
      setError('Unable to sign up with given credentials');
      setLoading(false);
      return;
    } else {
      setLoading(true);
      final user = await _userService.addUserToFirestore(
        email: email,
        name: name,
        balance: balance,
        uid: res.uid,
      );

      if (user is bool) {
        setError('');
        setLoading(false);
      } else {
        setError(res);
        setLoading(false);
      }
    }
  }
}
