import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/view_models/profile_viewmodel.dart';
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
  onSubmitAction(profileViewModel) async {
    await profileViewModel.logOut();

    if (!mounted) return;
    Navigator.pushNamed(context, onBoardingViewRoute);
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();

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
            onSubmitAction: () => onSubmitAction(profileViewModel),
            loading: profileViewModel.loading,
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
