import 'package:flutter/material.dart';
import 'components/body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Body(toggleView: widget.toggleView),
    );
  }
}
