import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  static const userPath = 'users/';

  dynamic createNewUser(
      {required String email,
      required String name,
      required String uid}) async {
    try {
      final userData = {'name': name, 'email': email};

      await _db.collection(userPath).doc(uid).set(userData);

      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot<Object?>> findUserById({required String uid}) async {
    return await _db.collection(userPath).doc(uid).get();
  }
}
