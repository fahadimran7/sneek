import 'package:flutter_mvvm_project/app/models/product_model.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';

class ProductViewModel extends BaseViewModel {
  final ProductService _productService = ProductService();

  Stream<List<ProductModel>> getProductsList() {
    return _productService.getProductsStream();
  }
}
