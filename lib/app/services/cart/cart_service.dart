import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_project/app/models/cart_model.dart';
import 'package:flutter_mvvm_project/app/models/user_model.dart';

class CartService {
  final _db = FirebaseFirestore.instance;

  static const cartPath = 'cart/';

  Stream<List<CartModel>> getCartItemsForUser(uid) {
    final cartStream =
        _db.collection(cartPath).doc(uid).collection('items').snapshots();

    final streamToPublish = cartStream.map(
      (snapshot) {
        final cartItemsMap = snapshot.docs;

        final cartItemList = cartItemsMap.map(
          (item) {
            return CartModel.fromJson(
              item,
            );
          },
        ).toList();

        return cartItemList;
      },
    );

    return streamToPublish;
  }

  Future<dynamic> addItemToCart(
      uid, itemId, name, description, quantity, price, imageUrl) async {
    CartModel cartModel = CartModel(
        name: name,
        description: description,
        quantity: 1,
        price: price,
        imageUrl: imageUrl);
    try {
      // Update quantity if item exists in cart
      final doc = await _db
          .collection(cartPath)
          .doc(uid)
          .collection('items')
          .doc(itemId)
          .get();

      if (doc.exists) {
        int currentQuantity = doc.data()!['quantity'] as int;

        final docRef =
            _db.collection(cartPath).doc(uid).collection('items').doc(itemId);

        docRef.update({'quantity': currentQuantity + 1});

        return true;
      } else {
        // Add new item to cart if it doesn't exist
        await _db
            .collection(cartPath)
            .doc(uid)
            .collection('items')
            .doc(itemId)
            .set(cartModel.toJson());
      }

      return true;
    } catch (e) {
      return (e.toString());
    }
  }

  Future<dynamic> removeItemFromCart(uid, itemId) async {
    final docRef =
        _db.collection(cartPath).doc(uid).collection('items').doc(itemId);
    try {
      await docRef.delete();

      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
