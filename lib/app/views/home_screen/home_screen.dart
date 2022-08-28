import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/database_service.dart';
import 'package:flutter_mvvm_project/app/views/products_screen/products_screen.dart';
import 'package:flutter_mvvm_project/app/views/profile_screen/profile_screen.dart';
import 'package:flutter_mvvm_project/app/views/wrapper/authenticate.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    final databaseService = context.watch<DatabaseService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: databaseService.findUserById(
              uid: authService.loggedInUser()!.uid,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong!'),
                    ElevatedButton(
                      onPressed: () => authService.logOut(),
                      child: const Text('Log out'),
                    )
                  ],
                );
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Document does not exist"),
                    ElevatedButton(
                      onPressed: () => authService.logOut(),
                      child: const Text('Log out'),
                    )
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${data['name']}"),
                    ElevatedButton(
                      onPressed: () async {
                        await authService.logOut();

                        if (!mounted) return;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Authenticate(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text('Log out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Text('Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductsScreen(),
                          ),
                        );
                      },
                      child: Text('Products'),
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
