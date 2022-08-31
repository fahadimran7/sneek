import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/views/checkout_screen/components/virtual_card.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.name,
      required this.email,
      required this.balance})
      : super(key: key);
  final String name;
  final String email;
  final String balance;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;

  // Helpers
  onSubmitAction(authService) async {
    setState(() {
      loading = true;
    });

    final res = await authService.logOut();

    if (res is bool) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      Navigator.pushNamed(context, onBoardingViewRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const VirtualCard(title: 'Your Balance'),
          const WhiteSpace(size: 'md'),
          _buildDetailsRow('Name', widget.name),
          const WhiteSpace(size: 'sm'),
          _buildDetailsRow('Email', widget.email),
          const WhiteSpace(size: 'sm'),
          _buildDetailsRow('Card', 'Standard Chartered'),
          const Spacer(),
          FormBusyButton(
            onSubmitAction: () => onSubmitAction(authService),
            loading: loading,
            title: 'Log out',
          )
        ],
      ),
    );
  }
}

_buildDetailsRow(title, value) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
            ),
          )
        ],
      )
    ],
  );
}

onSubmitHandler() {}
