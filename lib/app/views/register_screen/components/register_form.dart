import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_input_field.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/view_models/register_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../components/globals/white_space.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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

  // Register Action
  onSubmitAction(registerViewModel) async {
    // Form validates successfully
    if (_formKey.currentState!.validate()) {
      // Firebase Auth create user
      await registerViewModel.signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        balance: 100,
      );

      if (registerViewModel.error != '') return;

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
          context, homeViewRoute, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = context.watch<RegisterViewModel>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormInputField(
            controller: nameController,
            label: 'Your Name',
            validator: Validators.validateName,
            obscureText: false,
          ),
          const WhiteSpace(
            size: 'xs',
          ),
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
            title: 'Register',
            onSubmitAction: () => onSubmitAction(registerViewModel),
            loading: registerViewModel.loading,
          ),
          const WhiteSpace(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, loginViewRoute);
            },
            child: const Text('Already have an account? Login'),
          ),
          Text(
            registerViewModel.error,
            style: const TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
