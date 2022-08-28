import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                children: [
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

                        final res =
                            await authService.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (res is! bool) {
                          setState(() {
                            loading = false;
                            error = res;
                          });
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: widget.toggleView,
                    child: const Text('Register'),
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
