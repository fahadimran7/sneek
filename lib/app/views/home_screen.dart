import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as: ${authService.loggedInUser()}'),
            ElevatedButton(
                onPressed: () => authService.logOut(),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
