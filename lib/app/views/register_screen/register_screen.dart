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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Body(toggleView: widget.toggleView),
          ),
        ),
      ),
    );
  }
}
