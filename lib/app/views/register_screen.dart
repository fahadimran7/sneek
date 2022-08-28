import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/user_service.dart';
import 'package:provider/provider.dart';
import '../helpers/validators.dart';
import '../services/authentication_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    final userService = context.watch<UserService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Your Name',
                      ),
                    ),
                    validator: ((value) => Validators.validateName(value)),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Email',
                      ),
                    ),
                    validator: ((value) => Validators.validateEmail(value)),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Password',
                      ),
                    ),
                    obscureText: true,
                    validator: ((value) => Validators.validatePassword(value)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        final user = await authService.registerNewUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (user == null) {
                          setState(() {
                            loading = false;
                            error =
                                'Unable to register with given credentails!';
                          });
                        } else {
                          // Add user to firestore
                          final savedUser = await userService.createNewUser(
                            email: emailController.text,
                            name: nameController.text,
                            uid: user.uid,
                          );

                          if (savedUser == null) {
                            setState(() {
                              loading = false;
                              error = 'User profile not created!';
                            });
                          }
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: widget.toggleView,
                    child: const Text('Login'),
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
    );
  }
}
