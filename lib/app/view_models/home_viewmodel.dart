import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class HomeViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<DocumentSnapshot<Object?>> findUserById({required String uid}) async {
    return await _userService.findUserById(uid: uid);
  }

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }
}
