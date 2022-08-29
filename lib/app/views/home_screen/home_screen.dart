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
    final authService = context.watch<AuthenticationService>();
    final userService = context.watch<UserService>();
    return SafeArea(
      child: FutureBuilder<DocumentSnapshot>(
        future: userService.findUserById(
          uid: authService.loggedInUser()!.uid,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Text('Something went wrong!'),
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Scaffold(
              body: Text('Document does not exist!'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Sneek',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                iconTheme: const IconThemeData(color: Colors.black),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                  )
                ],
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              drawer: CustomDrawer(
                data: data,
                authService: authService,
              ),
              body: const ProductsScreen(),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
