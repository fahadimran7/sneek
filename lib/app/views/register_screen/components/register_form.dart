import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/form_input_field.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../../services/authentication_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, this.toggleView}) : super(key: key);
  final void Function()? toggleView;

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

  // Login Action
  onSubmitAction(authService, databaseService) async {
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
          error = 'Unable to register with given credentails!';
        });
      } else {
        // Add user to firestore
        final savedUser = await databaseService.addUserToFirestore(
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
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    final databaseService = context.watch<DatabaseService>();

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
            obscureText: true,
          ),
          FormBusyButton(
              title: 'Register',
              onSubmitAction: () =>
                  onSubmitAction(authService, databaseService),
              loading: loading),
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
    );
  }
}
