import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm_project/app/models/product_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  static const usersPath = 'users/';
  static const productsPath = 'products/';

  Future<dynamic> addUserToFirestore(
      {required String email,
      required String name,
      required String uid}) async {
    try {
      final userData = {'name': name, 'email': email};

      await _db.collection(usersPath).doc(uid).set(userData);

      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot<Object?>> findUserById({required String uid}) async {
    return await _db.collection(usersPath).doc(uid).get();
  }

  Stream<UserModel> getUserInfo(uid) {
    final userStream = _db.collection(usersPath).doc(uid).snapshots();

    final streamToPublish = userStream.map((snapshot) {
      final user = UserModel.fromJson(snapshot.data());
      return user;
    });

    return streamToPublish;
  }

  Stream<List<ProductModel>> getProductsStream() {
    final productsStream = _db.collection(productsPath).snapshots();

    final streamToPublish = productsStream.map(
      (snapshot) {
        final productsMap = snapshot.docs;

        final productList = productsMap.map(
          (product) {
            return ProductModel.fromJson(
              product.data(),
            );
          },
        ).toList();

        return productList;
      },
    );

    return streamToPublish;
  }
}
