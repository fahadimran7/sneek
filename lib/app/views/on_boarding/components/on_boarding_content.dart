import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/white_space.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(
          flex: 1,
        ),
        const Text(
          "SHOPIFY",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const WhiteSpace(),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black54),
        ),
        const Spacer(flex: 2),
        Image.asset(
          image!,
          height: 275,
          width: 305,
        ),
      ],
    );
  }
}
