import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/views/cart_screen/cart_screen.dart';
import 'package:flutter_mvvm_project/app/views/products_screen/products_screen.dart';
import 'package:provider/provider.dart';
import '../../components/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final userService = context.read<UserService>();
    return FutureBuilder<DocumentSnapshot>(
      future: userService.findUserById(
        uid: authService.loggedInUser()!.uid,
      ),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Something went wrong!')),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('Document does not exist!')),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ProductsScreen(data: data);
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
