import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/helpers/constants.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/services/toast/toast_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/product_view_model.dart';
import 'package:flutter_mvvm_project/app/views/on_boarding/on_boarding_screen.dart';
import 'package:flutter_mvvm_project/app/views/home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthenticationService(),
        ),
        Provider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(),
        ),
        Provider(
          create: (_) => CartService(),
        ),
        Provider(
          create: (_) => ToastService(),
        ),
        Provider(
          create: (_) => PaymentService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryBlack,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const HomeScreen();
    }

    return const OnBoarding();
  }
}
