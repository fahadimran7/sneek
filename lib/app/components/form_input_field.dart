import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.validator,
      required this.obscureText})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final Function validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          label,
        ),
      ),
      obscureText: obscureText,
      validator: ((value) => validator(value)),
    );
  }
}
