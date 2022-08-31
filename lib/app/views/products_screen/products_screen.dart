import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/auth/authentication_service.dart';
import 'package:provider/provider.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_drawer.dart';
import '../cart_screen/cart_screen.dart';
import 'components/body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SNEEK',
        enableActions: true,
      ),
      drawer: CustomDrawer(
        data: widget.data,
        authService: authService,
      ),
      body: const Body(),
    );
  }
}
