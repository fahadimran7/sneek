import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/app_error.dart';
import 'package:flutter_mvvm_project/app/components/app_loading.dart';
import 'package:flutter_mvvm_project/app/components/app_no_records.dart';
import 'package:flutter_mvvm_project/app/components/custom_app_bar.dart';
import 'package:flutter_mvvm_project/app/models/cart_model.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Shopping Cart',
        enableActions: false,
      ),
      body: StreamBuilder(
        stream: CartService()
            .getCartItemsForUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          }

          if (snapshot.hasData) {
            final cartItems = snapshot.data as List<CartModel>;

            if (cartItems.isEmpty) {
              return const AppNoRecords(message: 'No items in cart');
            }

            return Body(
              cartItems: cartItems,
            );
          } else if (snapshot.hasError) {
            const AppError();
          }

          return const AppNoRecords(message: 'No records to show');
        },
      ),
    );
  }
}
