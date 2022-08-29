import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/white_space.dart';
import '../services/auth/authentication_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.data,
    required this.authService,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final AuthenticationService authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      data['email'],
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Purchase History'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Your Profile'),
            onTap: () {},
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () => authService.logOut(),
              child: const Text('Log out'),
            ),
          ),
          const WhiteSpace(
            size: 'xs',
          )
        ],
      ),
    );
  }
}
