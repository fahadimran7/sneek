import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:provider/provider.dart';
import '../../../components/white_space.dart';

class VirtualCard extends StatelessWidget {
  const VirtualCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();
    final authService = context.read<AuthenticationService>();
    final uid = authService.loggedInUser()!.uid;

    return FutureBuilder(
      future: userService.getUserBalance(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Standard Chartered',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const WhiteSpace(
                  size: 'md',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      '**** **** **** 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const WhiteSpace(size: 'md'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${snapshot.data}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '12/26',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
