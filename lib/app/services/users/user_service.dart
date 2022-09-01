import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  static const usersPath = 'users/';

  Future<dynamic> addUserToFirestore(
      {required String email,
      required String name,
      required num balance,
      required String uid}) async {
    try {
      final userData = UserModel(name: name, email: email, balance: balance);
      await _db.collection(usersPath).doc(uid).set(userData.toJson());
      return true;
    } catch (e) {
      return e.toString();
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

  Future<num> getUserBalance(uid) async {
    final user = await _db.collection(usersPath).doc(uid).get();

    return user.data()!['balance'];
  }
}
