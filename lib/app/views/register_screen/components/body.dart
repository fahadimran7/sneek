import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/views/register_screen/components/register_form.dart';

import '../../../components/white_space.dart';

class Body extends StatefulWidget {
  const Body({Key? key, this.toggleView}) : super(key: key);
  final void Function()? toggleView;

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
        children: [
          const WhiteSpace(
            size: 'xs',
          ),
          const Text(
            'Create a new account',
            style: TextStyle(fontSize: 28),
          ),
          const WhiteSpace(),
          const Text(
            'Get started with an email and password',
            style: TextStyle(color: Colors.black54),
          ),
          const WhiteSpace(size: 'xl'),
          RegisterForm(
            toggleView: widget.toggleView,
          ),
        ],
      ),
    );
  }
}
