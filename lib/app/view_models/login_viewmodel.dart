import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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
}
