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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              style: BorderStyle.solid,
            ),
          ),
          errorStyle: TextStyle(color: Colors.red.shade400),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 1),
          ),
          fillColor: const Color.fromARGB(255, 243, 243, 243),
          filled: true,
          labelText: label),
      obscureText: obscureText,
      validator: ((value) => validator(value)),
    );
  }
}
