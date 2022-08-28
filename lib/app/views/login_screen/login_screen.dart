import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Body(toggleView: widget.toggleView),
    );
  }
}
