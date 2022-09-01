import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/globals/app_loading.dart';
import 'package:flutter_mvvm_project/app/models/user_model.dart';
import 'package:flutter_mvvm_project/app/view_models/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../components/globals/custom_app_bar.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Your Profile', enableActions: true),
      body: StreamBuilder(
        stream: profileViewModel
            .getUserInfoStream(profileViewModel.getLoggedInUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          } else {
            final user = snapshot.data as UserModel;

            return Body(
              name: user.name,
              email: user.email,
              balance: user.balance.toString(),
            );
          }
        },
      ),
    );
  }
}
