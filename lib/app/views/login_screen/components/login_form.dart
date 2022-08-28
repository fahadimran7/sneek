import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/form_input_field.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:provider/provider.dart';
import '../../../services/authentication_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, this.toggleView}) : super(key: key);
  final void Function()? toggleView;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

  // Login Action
  onSubmitAction(authService) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      final res = await authService.signInWithEmailAndPassword(
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
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormInputField(
            controller: emailController,
            label: 'Email',
            validator: Validators.validateEmail,
            obscureText: false,
          ),
          FormInputField(
            controller: passwordController,
            label: 'Password',
            validator: Validators.validatePassword,
            obscureText: false,
          ),
          FormBusyButton(
              title: 'Login',
              onSubmitAction: () => onSubmitAction(authService),
              loading: loading),
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
    );
  }
}
