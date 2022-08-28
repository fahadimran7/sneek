import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/form_input_field.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/views/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../components/white_space.dart';
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
      } else {
        setState(() {
          loading = false;
        });

        if (!mounted) return;

        // Todo: Use named routes
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
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
          const WhiteSpace(
            size: 'xs',
          ),
          FormInputField(
            controller: passwordController,
            label: 'Password',
            validator: Validators.validatePassword,
            obscureText: false,
          ),
          const WhiteSpace(
            size: 'md',
          ),
          FormBusyButton(
              title: 'Login',
              onSubmitAction: () => onSubmitAction(authService),
              loading: loading),
          const WhiteSpace(),
          TextButton(
            onPressed: widget.toggleView,
            child: const Text('Don\'t have an account? Register Now'),
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
