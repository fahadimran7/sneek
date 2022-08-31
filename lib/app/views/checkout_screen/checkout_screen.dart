import 'package:flutter/material.dart';

import '../../components/globals/custom_app_bar.dart';
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
      appBar: const CustomAppBar(title: 'Checkout', enableActions: false),
      body: Body(totalPrice: totalPrice, items: items),
    );
  }
}
