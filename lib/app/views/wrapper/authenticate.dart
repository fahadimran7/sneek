import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/views/login_screen/login_screen.dart';
import 'package:flutter_mvvm_project/app/views/register_screen/register_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogInScreen = true;

  @override
  Widget build(BuildContext context) {
    if (showLogInScreen) return const LoginScreen();

    return const RegisterScreen();
  }
}
