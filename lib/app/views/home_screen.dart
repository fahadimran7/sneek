import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/user_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    final userService = context.watch<UserService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: userService.findUserById(
              uid: authService.loggedInUser()!.uid,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong!');
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${data['name']}"),
                    ElevatedButton(
                      onPressed: () => authService.logOut(),
                      child: const Text('Log out'),
                    )
                  ],
                );
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
