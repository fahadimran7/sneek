import 'package:flutter/material.dart';

class FormBusyButton extends StatelessWidget {
  const FormBusyButton(
      {Key? key,
      required this.onSubmitAction,
      required this.loading,
      required this.title})
      : super(key: key);

  final void Function()? onSubmitAction;
  final bool loading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmitAction,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: loading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
    );
  }
}
