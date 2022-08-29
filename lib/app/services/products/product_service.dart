import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';

class ProductService {
  final _db = FirebaseFirestore.instance;

  static const productsPath = 'products/';

  Stream<List<ProductModel>> getProductsStream() {
    final productsStream = _db.collection(productsPath).snapshots();

    final streamToPublish = productsStream.map(
      (snapshot) {
        final productsMap = snapshot.docs;

        final productList = productsMap.map(
          (product) {
            return ProductModel.fromJson(
              product.data(),
            );
          },
        ).toList();

        return productList;
      },
    );

    return streamToPublish;
  }
}
