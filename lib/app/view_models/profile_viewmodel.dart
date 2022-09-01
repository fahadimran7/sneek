import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../models/user_model.dart';
import '../services/auth/authentication_service.dart';
import '../services/service_locator.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  num _balance = 0;

  get userBalance => _balance;

  Stream<UserModel> getUserInfoStream(uid) {
    return _userService.getUserInfo(uid);
  }

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }

  Future<dynamic> logOut() async {
    setLoading(true);
    await _authenticationService.logOut();

    setLoading(false);
  }

  Future<dynamic> getUserBalance(uid) async {
    final res = await _userService.getUserBalance(uid);
    _balance = res;
    notifyListeners();
  }
}
