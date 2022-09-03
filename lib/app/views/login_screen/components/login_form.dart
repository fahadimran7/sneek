import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_input_field.dart';
import 'package:flutter_mvvm_project/app/components/forms/google_login_button.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/view_models/login_viewmodel.dart';
import 'package:flutter_mvvm_project/app/views/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../components/globals/white_space.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Login Action
  onSubmitAction(loginViewModel) async {
    if (_formKey.currentState!.validate()) {
      await loginViewModel.signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      if (loginViewModel.error != '') return;

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

  onGoogleLogin(loginViewModel) async {
    await loginViewModel.loginWithGoogle();

    if (loginViewModel.error != '') return;

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

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();

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
            obscureText: true,
          ),
          const WhiteSpace(
            size: 'md',
          ),
          FormBusyButton(
            title: 'Login',
            onSubmitAction: () => onSubmitAction(loginViewModel),
            loading: loginViewModel.loading,
          ),
          const WhiteSpace(
            size: 'xs',
          ),
          const Text(
            'OR',
            style: TextStyle(color: Colors.black54),
          ),
          const WhiteSpace(
            size: 'xs',
          ),
          GoogleLoginButton(
              onSubmitAction: () => onGoogleLogin(loginViewModel),
              loading: loginViewModel.googleLoading,
              title: 'Continue with Google'),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, registerViewRoute);
            },
            child: const Text('Don\'t have an account? Register Now'),
          ),
          Text(
            loginViewModel.error,
            style: const TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
