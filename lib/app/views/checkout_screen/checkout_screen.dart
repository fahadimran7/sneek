import 'package:flutter/material.dart';

import 'components/body.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    Key? key,
    required this.totalPrice,
    required this.items,
  }) : super(key: key);
  final num totalPrice;
  final int items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Body(totalPrice: totalPrice, items: items),
    );
  }
}
