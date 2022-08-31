import 'package:flutter/material.dart';

class AppNoRecords extends StatelessWidget {
  const AppNoRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No records to show!'),
    );
  }
}
