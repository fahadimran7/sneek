import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/auth/authentication_service.dart';
import '../services/service_locator.dart';
import '../services/toast/toast_service.dart';

class ProductViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final CartService _cartService = locator<CartService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ToastService _toastService = locator<ToastService>();

  Stream<List<ProductModel>> getProductsList() {
    return _productService.getProductsStream();
  }

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }

  Future<dynamic> addItemToCart(
      uid, itemId, name, description, quantity, price, imageUrl) async {
    final res = await _cartService.addItemToCart(
        uid, itemId, name, description, quantity, price, imageUrl);

    if (res is bool) {
      setError('');
    } else {
      setError(res);
    }
  }

  showToast(message) {
    _toastService.showToast(message);
  }
}
