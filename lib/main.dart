import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/helpers/constants.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/services/cart/cart_service.dart';
import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'package:flutter_mvvm_project/app/services/service_locator.dart';
import 'package:flutter_mvvm_project/app/services/toast/toast_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:flutter_mvvm_project/app/view_models/home_viewmodel.dart';
import 'package:flutter_mvvm_project/app/view_models/login_viewmodel.dart';
import 'package:flutter_mvvm_project/app/view_models/profile_viewmodel.dart';
import 'package:flutter_mvvm_project/app/view_models/register_viewmodel.dart';
import 'package:flutter_mvvm_project/app/views/on_boarding/on_boarding_screen.dart';
import 'package:flutter_mvvm_project/app/views/home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app/routes/router.dart' as router;

import 'app/view_models/product_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(),
        ),
        Provider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
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
        onGenerateRoute: router.generateRoute,
        initialRoute: homeViewRoute,
        theme: ThemeData(
          primarySwatch: primaryBlack,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
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
