import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/views/login_screen/components/login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, bottom: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          WhiteSpace(
            size: 'xs',
          ),
          Text(
            'Login to your account',
            style: TextStyle(fontSize: 28),
          ),
          WhiteSpace(),
          Text(
            'Sign in with your email and password',
            style: TextStyle(color: Colors.black54),
          ),
          WhiteSpace(size: 'xl'),
          LoginForm(),
        ],
      ),
    );
  }
}
