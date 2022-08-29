import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/block_button.dart';
import 'package:flutter_mvvm_project/app/components/white_space.dart';
import 'package:flutter_mvvm_project/app/models/cart_model.dart';

import 'cart_item.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.cartItems,
  }) : super(key: key);
  final List<CartModel> cartItems;

  calculateTotalPrice(cartItems) {
    num total = 0;
    for (CartModel item in cartItems) {
      total += item.quantity * item.price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItem(cartItem: cartItems[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                ' Total',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${calculateTotalPrice(cartItems).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const WhiteSpace(size: 'md'),
          BlockButton(title: 'Proceed to Checkout', onPressAction: () {})
        ],
      ),
    );
  }
}
