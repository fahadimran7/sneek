import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/routes/screen_arguments.dart';
import 'package:flutter_mvvm_project/app/views/cart_screen/cart_screen.dart';
import 'package:flutter_mvvm_project/app/views/checkout_screen/checkout_screen.dart';
import 'package:flutter_mvvm_project/app/views/home_screen/home_screen.dart';
import 'package:flutter_mvvm_project/app/views/login_screen/login_screen.dart';
import 'package:flutter_mvvm_project/app/views/on_boarding/on_boarding_screen.dart';
import 'package:flutter_mvvm_project/app/views/payment_history_screen/payment_history_screen.dart';
import 'package:flutter_mvvm_project/app/views/profile_screen/profile_screen.dart';
import 'package:flutter_mvvm_project/app/views/register_screen/register_screen.dart';
import 'package:flutter_mvvm_project/app/views/undefined_screen/undefined_screen.dart';
import 'package:flutter_mvvm_project/app/views/wrapper/authenticate.dart';
import 'package:flutter_mvvm_project/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return MaterialPageRoute(builder: (_) => const Layout());
    case productViewRoute:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case loginViewRoute:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case registerViewRoute:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case cartViewRoute:
      return MaterialPageRoute(builder: (_) => const CartScreen());
    case purchaseHistoryViewRoute:
      return MaterialPageRoute(builder: (_) => const PaymentHistory());
    case profileViewRoute:
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    case authenticateViewRoute:
      return MaterialPageRoute(builder: (_) => const Authenticate());
    case checkoutViewRoute:
      var args = settings.arguments as ScreenArguments;
      return MaterialPageRoute(
        builder: (_) => CheckoutScreen(
          items: args.items,
          totalPrice: args.totalPrice,
        ),
      );
    case onBoardingViewRoute:
      return MaterialPageRoute(builder: (_) => const OnBoarding());
    default:
      return MaterialPageRoute(
          builder: (_) => UndefinedScreen(name: settings.name!));
  }
}
