import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:provider/provider.dart';
import 'widgets/body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productService = context.watch<ProductService>();

    return Scaffold(
      body: Body(productService: productService),
    );
  }
}
