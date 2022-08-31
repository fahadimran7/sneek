import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/custom_app_bar.dart';
import 'package:flutter_mvvm_project/app/models/user_model.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:provider/provider.dart';
import '../cart_screen/cart_screen.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();
    final authService = context.read<AuthenticationService>();

    return StreamBuilder(
      stream: userService.getUserInfo(authService.loggedInUser()!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final user = snapshot.data as UserModel;

          return Scaffold(
            appBar:
                const CustomAppBar(title: 'Your Profile', enableActions: true),
            body: Body(
              name: user.name,
              email: user.email,
              balance: user.balance.toString(),
            ),
          );
        }
      },
    );
  }
}
