import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  bool _loading = false;
  final ProductService _productService = ProductService();

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  get loading => _loading;

  Stream<List<ProductModel>> getProductsList() {
    return _productService.getProductsStream();
  }
}
