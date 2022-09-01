import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'package:flutter_mvvm_project/app/services/toast/toast_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class CartViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final CartService _cartService = locator<CartService>();
  final ToastService _toastService = locator<ToastService>();

  bool _itemRemoved = false;

  get isItemRemoved => _itemRemoved;

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }

  Future<dynamic> removeCartItem(uid, itemId) async {
    final res = await _cartService.removeItemFromCart(uid, itemId);

    if (res is bool) {
      _itemRemoved = true;
      notifyListeners();
    }
  }

  showToast(message) {
    _toastService.showToast(message);
  }
}
