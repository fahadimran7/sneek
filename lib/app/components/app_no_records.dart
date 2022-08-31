import 'package:flutter/material.dart';

class AppNoRecords extends StatelessWidget {
  const AppNoRecords({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
