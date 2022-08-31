import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/buttons/block_button.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 40,
        ),
        const WhiteSpace(),
        const Center(
          child: Text(
            'Success',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: BlockButton(
            onPressAction: () {
              Navigator.pushNamed(context, productViewRoute);
            },
            title: 'Browse Products',
          ),
        )
      ],
    );
  }
}
