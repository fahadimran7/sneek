import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/views/wrapper/authenticate.dart';

class PaymentService {
  final _db = FirebaseFirestore.instance;
  final userService = UserService();
  final authService = AuthenticationService();

  static const usersPath = 'users/';
  static const cartPath = 'cart/';

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
      await _db.collection(usersPath).doc(uid).update({'balance': newBalance});

      // clear the cart
      final collection = _db.collection(cartPath).doc(uid).collection('items');

      final snapshots = await collection.get();

      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }

      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
