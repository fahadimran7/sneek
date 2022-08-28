import 'package:flutter/material.dart';
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
        title: const Text('Register'),
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
                            await authService.registerWithEmailAndPassword(
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
