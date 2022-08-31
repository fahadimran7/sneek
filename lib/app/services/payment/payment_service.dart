import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/models/payment_model.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';

import '../../models/cart_model.dart';

class PaymentService {
  final _db = FirebaseFirestore.instance;
  final userService = UserService();
  final authService = AuthenticationService();

  static const usersPath = 'users/';
  static const cartPath = 'cart/';
  static const paymentsPath = 'payments/';
  static const purchasedPath = 'purchased/';

  Future<dynamic> completePayment(num totalAmount) async {
    final uid = authService.loggedInUser()!.uid;

    // find the user balance
    num currentBalance = await userService.getUserBalance(uid);

    if (currentBalance < totalAmount) {
      return 'Insufficient balance';
    }

    num newBalance = currentBalance - totalAmount;
    newBalance = num.parse(newBalance.toStringAsFixed(2));
    final paymentsItemsRef = [];

    // complete payment and update the balance
    try {
      // add cart items to purchased items
      final purchasedItemsRef =
          _db.collection(purchasedPath).doc(uid).collection('items');

      // clear the cart
      final collection = _db.collection(cartPath).doc(uid).collection('items');

      final snapshots = await collection.get();

      for (var doc in snapshots.docs) {
        await purchasedItemsRef.doc(doc.id).set(doc.data());
        await doc.reference.delete();

        final purchasedSnapshots = await purchasedItemsRef.doc(doc.id).get();

        paymentsItemsRef.add(purchasedSnapshots.reference);
      }

      // add itemRef list to payments
      await _db.collection(paymentsPath).doc(uid).collection('history').add({
        'items': paymentsItemsRef,
        'timestamp': DateTime.now().microsecondsSinceEpoch
      });

      // Update balance
      await _db.collection(usersPath).doc(uid).update({'balance': newBalance});

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<Future<List<PaymentModel>>> getPaymentHistoryForUser(uid) {
    final List<PaymentModel> paymentModelList = [];

    final paymentStream = _db
        .collection(paymentsPath)
        .doc(uid)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .snapshots();

    final streamToPublish = paymentStream.map(
      (snapshot) async {
        final paymentItemsMap = snapshot.docs;

        for (var snapshot in paymentItemsMap) {
          final cartItemRefList = [];
          final List<CartModel> cartItemList = [];

          var itemMap = snapshot.data()['items'];
          for (var itemRef in itemMap) {
            final itemId = (await itemRef.get() as DocumentSnapshot).id;
            cartItemRefList.add(itemId);
          }

          for (var cartItemRef in cartItemRefList) {
            final cartItem = await _db
                .collection(purchasedPath)
                .doc(uid)
                .collection('items')
                .doc(cartItemRef)
                .get();

            cartItemList.add(
              CartModel.fromJson(
                cartItem,
              ),
            );
          }
          paymentModelList.add(PaymentModel(paymentItemsList: cartItemList));
        }

        return paymentModelList;
      },
    );

    return streamToPublish;
  }
}
