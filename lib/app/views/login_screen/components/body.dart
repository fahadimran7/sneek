import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/views/login_screen/components/login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key, this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return LoginForm(
      toggleView: widget.toggleView,
    );
  }
}
