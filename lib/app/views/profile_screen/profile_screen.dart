import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/models/user_model.dart';
import 'package:flutter_mvvm_project/app/services/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/database_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService = context.watch<DatabaseService>();
    final authService = context.watch<AuthenticationService>();

    return StreamBuilder(
      stream: databaseService.getUserInfo(authService.loggedInUser()!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Text('${(snapshot.data as UserModel).name}');
      },
    );
  }
}
