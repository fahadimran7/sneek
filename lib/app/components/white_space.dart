import 'package:flutter/material.dart';

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({Key? key, this.size}) : super(key: key);
  final String? size;

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case 'xs':
        return const SizedBox(
          height: 14,
        );
      case 'sm':
        return const SizedBox(
          height: 24,
        );
      case 'md':
        return const SizedBox(
          height: 34,
        );
      case 'lg':
        return const SizedBox(
          height: 44,
        );
      case 'xl':
        return const SizedBox(
          height: 54,
        );
      default:
        return const SizedBox(
          height: 5,
        );
    }
  }
}
