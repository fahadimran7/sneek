import 'package:flutter/material.dart';
import '../../components/globals/custom_app_bar.dart';
import '../../components/globals/custom_drawer.dart';
import 'components/body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SNEEK',
        enableActions: true,
      ),
      drawer: CustomDrawer(
        data: widget.data,
      ),
      body: const Body(),
    );
  }
}
