import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../services/authentication_service.dart';
import '../../services/database_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService = context.watch<DatabaseService>();

    return Scaffold(
      body: StreamBuilder(
        stream: databaseService.getProductsStream(),
        builder: (context, snapshot) {
          List<Widget> listOfWidgets = [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final products = snapshot.data as List<ProductModel>;

            for (final product in products) {
              listOfWidgets.add(
                ListTile(
                  trailing: Text('\$${product.quantity.toString()}'),
                  leading: const Icon(Icons.local_cafe),
                  title: Text(product.name),
                  subtitle: Text(
                    product.description,
                  ),
                ),
              );
            }

            return ListView(
              children: listOfWidgets,
            );
          } else if (snapshot.hasError) {
            const Text('Something went wrong!');
          }

          return const Center(child: Text('No records to show!'));
        },
      ),
    );
  }
}
