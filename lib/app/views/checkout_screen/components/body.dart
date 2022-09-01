import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/buttons/payment_button.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/view_models/checkout_viewmodel.dart';
import 'package:flutter_mvvm_project/app/views/checkout_screen/components/virtual_card.dart';
import 'package:flutter_mvvm_project/app/views/success_screen/success_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.totalPrice, required this.items})
      : super(key: key);
  final num totalPrice;
  final int items;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = context.watch<CheckoutViewModel>();

    // Helpers
    onSubmitAction() async {
      await checkoutViewModel.completePayment(widget.totalPrice);

      if (checkoutViewModel.error != '') {
        checkoutViewModel.showToast(
          'Sorry your payment could not be completed',
        );

        return;
      } else {
        checkoutViewModel.showToast(
          'Payment completed successfully',
        );

        if (!mounted) return;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VirtualCard(title: 'Standarad Chartered'),
          const WhiteSpace(
            size: 'lg',
          ),
          const Text(
            'Cost Summary',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const WhiteSpace(
            size: 'sm',
          ),
          _buildItemsRow('Items', widget.items.toString()),
          const WhiteSpace(size: 'xs'),
          _buildAmountRow('Sub Total', widget.totalPrice.toStringAsFixed(2)),
          const WhiteSpace(size: 'xs'),
          _buildAmountRow('Shipping', '0.00'),
          const WhiteSpace(size: 'xs'),
          _buildAmountRow('Estimated Tax', '0.00'),
          const WhiteSpace(size: 'xs'),
          _buildAmountRow('Total', widget.totalPrice.toStringAsFixed(2)),
          const Spacer(),
          PaymentButton(
            loading: checkoutViewModel.loading,
            onSubmitAction: () => onSubmitAction(),
            title:
                'Complete Payment (\$${widget.totalPrice.toStringAsFixed(2)})',
          )
        ],
      ),
    );
  }
}

_buildItemsRow(String category, String items) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        category,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ),
      Text(
        'x$items',
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ),
    ],
  );
}

_buildAmountRow(String category, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        category,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ),
      Text(
        '\$$amount',
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ),
    ],
  );
}
