import 'package:flutter/material.dart';
import '../../components/globals/custom_app_bar.dart';
import 'components/body.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.rating,
    required this.description,
  }) : super(key: key);

  final String id;
  final String name;
  final String details;
  final num price;
  final String imageUrl;
  final int quantity;
  final int rating;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product Details', enableActions: true),
      body: Body(
        id: id,
        name: name,
        details: details,
        price: price,
        imageUrl: imageUrl,
        quantity: quantity,
        rating: rating,
        description: description,
      ),
    );
  }
}
