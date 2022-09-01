import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/auth/authentication_service.dart';
import '../services/service_locator.dart';

class ProductViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Stream<List<ProductModel>> getProductsList() {
    return _productService.getProductsStream();
  }

  User? getLoggedInUser() {
    return _authenticationService.loggedInUser();
  }
}
