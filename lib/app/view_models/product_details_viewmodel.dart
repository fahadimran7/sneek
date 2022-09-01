import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';
import '../services/toast/toast_service.dart';

class ProductDetailsViewModel extends BaseViewModel {
  final CartService _cartService = locator<CartService>();
  final ToastService _toastService = locator<ToastService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }

  Future<dynamic> addItemToCart(
      uid, itemId, name, description, quantity, price, imageUrl) async {
    setLoading(true);
    final res = await _cartService.addItemToCart(
        uid, itemId, name, description, quantity, price, imageUrl);

    if (res is bool) {
      setError('');
      setLoading(false);
    } else {
      setError(res);
      setLoading(false);
    }
  }

  showToast(message) {
    _toastService.showToast(message);
  }
}
