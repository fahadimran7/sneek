import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/white_space.dart';
import '../../../models/payment_model.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.paymentItem}) : super(key: key);
  final List<PaymentModel> paymentItem;

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfCards = [];

    for (var item in paymentItem) {
      final paymentsList = item.paymentItemsList;

      // Add Header Row
      List<Widget> listOfRows = [
        _buildDetailsRowWithSpace(
          name: 'ITEMS',
          value: _calculateItemCount(paymentsList),
          isHeader: true,
        )
      ];

      // Create item detail rows
      for (var details in paymentsList) {
        listOfRows.add(
          _buildDetailsRowWithSpace(
            name: details.name,
            quantity: details.quantity,
            value: details.price,
          ),
        );
      }

      // Create trailing row
      listOfRows.add(
        _buildDetailsRowWithSpace(
          name: 'Total',
          value: _calculateTotalPrice(paymentsList),
          isTrailing: true,
        ),
      );

      // Add Rows inside Card
      listOfCards.add(
        Column(
          children: [
            Card(
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(children: listOfRows),
              ),
            ),
            const WhiteSpace(
              size: 'xs',
            ),
          ],
        ),
      );
    }

    // Display list of cards
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: listOfCards),
    );
  }
}

// Helpers
_calculateTotalPrice(paymentsList) {
  num totalPrice = 0;

  for (var item in paymentsList) {
    totalPrice += (item.price * item.quantity);
  }

  return totalPrice;
}

_calculateItemCount(paymentsList) {
  num itemCount = 0;

  for (var item in paymentsList) {
    itemCount += item.quantity;
  }

  return itemCount;
}

Widget _buildDetailsRowWithSpace(
    {required name, required value, isHeader, isTrailing, quantity}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$name ${quantity != null ? '(x$quantity)' : ''}',
            style: isHeader != null && isHeader
                ? const TextStyle(fontSize: 16, color: Colors.black54)
                : const TextStyle(fontSize: 16),
          ),
          isHeader != null && isHeader
              ? Text('x${value.toString()}')
              : Text(
                  '\$${value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                )
        ],
      ),
      const WhiteSpace(
        size: 'xs',
      ),
      if (isTrailing != null && isTrailing)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Successful',
              style: TextStyle(color: Colors.green),
            )
          ],
        )
    ],
  );
}
