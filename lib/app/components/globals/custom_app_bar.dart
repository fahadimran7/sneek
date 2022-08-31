import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.enableActions,
  }) : super(key: key);
  final String title;
  final bool enableActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: enableActions
          ? <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, cartViewRoute);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              )
            ]
          : [],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
