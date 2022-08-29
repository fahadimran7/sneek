import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/views/products_screen/widgets/product_card.dart';

import '../../../models/product_model.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productService.getProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final products = snapshot.data as List<ProductModel>;

          return GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 313,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext ctx, index) {
                return ProductCard(product: products[index]);
              });
        } else if (snapshot.hasError) {
          const Text('Something went wrong!');
        }

        return const Center(
          child: Text('No records to show!'),
        );
      },
    );
  }
}
