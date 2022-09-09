import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/models/payment_model.dart';
import 'package:flutter_mvvm_project/app/models/purchased_model.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:uuid/uuid.dart';

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

    // complete payment and update the balance
    try {
      // clear the cart
      final collection = _db.collection(cartPath).doc(uid).collection('items');

      final snapshots = await collection.get();
      const uuid = Uuid();

      final cartItems = <String, dynamic>{};

      for (var doc in snapshots.docs) {
        cartItems[uuid.v1()] = doc.data();
        await doc.reference.delete();
      }

      await _db.collection(paymentsPath).doc(uid).collection('history').add({
        'items': cartItems,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      // Update balance
      await _db.collection(usersPath).doc(uid).update({'balance': newBalance});

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getPaymentHistoryForUser(uid) async {
    final List<PaymentModel> paymentModelList = [];
    try {
      final paymentHistoryItems = await _db
          .collection(paymentsPath)
          .doc(uid)
          .collection('history')
          .orderBy('timestamp', descending: true)
          .get();

      for (final doc in paymentHistoryItems.docs) {
        final List<PurchasedModel> purchaseItemList = [];

        for (final item in doc.data()['items'].values) {
          final purchaseItem = PurchasedModel.fromJson(item);
          purchaseItemList.add(purchaseItem);
        }

        paymentModelList.add(
          PaymentModel(
            paymentItemsList: purchaseItemList.reversed.toList(),
          ),
        );
      }

      return paymentModelList;
    } catch (e) {
      return null;
    }
  }
}
