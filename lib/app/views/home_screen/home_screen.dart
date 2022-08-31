import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/app_error.dart';
import 'package:flutter_mvvm_project/app/components/app_loading.dart';
import 'package:flutter_mvvm_project/app/components/app_no_records.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/views/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: userService.findUserById(
          uid: authService.loggedInUser()!.uid,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          }

          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ProductsScreen(data: data);
          } else if (snapshot.hasError) {
            return const AppError();
          }

          return const AppNoRecords(message: 'Record does not exist');
        },
      ),
    );
  }
}
