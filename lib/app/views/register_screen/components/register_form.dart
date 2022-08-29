import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/form_input_field.dart';
import 'package:flutter_mvvm_project/app/helpers/validators.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:provider/provider.dart';
import '../../../components/white_space.dart';
import '../../../services/auth/authentication_service.dart';
import '../../home_screen/home_screen.dart';

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

  // Register Action
  onSubmitAction(authService, userService) async {
    // Form validates successfully
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      // Firebase Auth create user
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
        // Add user document to Firestore
        final savedUser = await userService.addUserToFirestore(
          email: emailController.text,
          name: nameController.text,
          balance: 100,
          uid: user.uid,
        );

        // Document save error
        if (savedUser == null) {
          setState(() {
            loading = false;
            error = 'User profile not created!';
          });
        } else {
          // All OK redirect to Home Page
          setState(() {
            loading = false;
          });

          if (!mounted) return;

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
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();
    final userService = context.watch<UserService>();

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
              onSubmitAction: () => onSubmitAction(authService, userService),
              loading: loading),
          const WhiteSpace(),
          TextButton(
            onPressed: widget.toggleView,
            child: const Text('Already have an account? Login'),
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
