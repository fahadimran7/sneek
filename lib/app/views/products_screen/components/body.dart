import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/app_error.dart';
import 'package:flutter_mvvm_project/app/components/app_loading.dart';
import 'package:flutter_mvvm_project/app/components/app_no_records.dart';
import 'package:flutter_mvvm_project/app/view_models/product_view_model.dart';
import 'package:flutter_mvvm_project/app/views/products_screen/components/product_card.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    return StreamBuilder(
      stream: productViewModel.getProductsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoading();
        }

        if (snapshot.hasData) {
          final products = snapshot.data as List<ProductModel>;
          return _buildGridView(products);
        } else if (snapshot.hasError) {
          return const AppError();
        }
        return const AppNoRecords(message: 'No products to show');
      },
    );
  }
}

_buildGridView(products) {
  return GridView.builder(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisExtent: 313,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
    ),
    itemCount: products.length,
    itemBuilder: (BuildContext ctx, index) {
      return ProductCard(product: products[index]);
    },
  );
}
