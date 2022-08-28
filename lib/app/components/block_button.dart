import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  const BlockButton({Key? key, required this.onPressAction}) : super(key: key);
  final void Function()? onPressAction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressAction,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
