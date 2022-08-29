import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/models/cart_model.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';

import 'widgets/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CartService()
          .getCartItemsForUser(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          final cartItems = snapshot.data as List<CartModel>;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Your Shopping Cart',
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
              body: Body(cartItems: cartItems),
            ),
          );
        } else if (snapshot.hasError) {
          const SafeArea(
            child: Scaffold(
              body: Text('Something went wrong!'),
            ),
          );
        }

        return const Center(
          child: SafeArea(
            child: Scaffold(
              body: Text('No records to show!'),
            ),
          ),
        );
      },
    );
  }
}
