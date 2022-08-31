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
      List<Widget> listOfRows = [];

      final paymentsList = (item).paymentItemsList;

      listOfRows = [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ITEMS',
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              'x${calculateItemCount(paymentsList).toString()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const WhiteSpace(size: 'sm')
      ];

      for (var details in paymentsList) {
        listOfRows.add(
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${details.name} (x${details.quantity})',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${details.price.toString()}',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const WhiteSpace(
                size: 'xs',
              )
            ],
          ),
        );
      }

      listOfRows.add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\$${calculateTotalPrice(paymentsList).toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const WhiteSpace(size: 'sm'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Succeeded',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                )
              ],
            )
          ],
        ),
      );

      listOfCards.add(
        Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(children: listOfRows),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: listOfCards),
    );
  }
}

calculateTotalPrice(paymentsList) {
  num totalPrice = 0;

  for (var item in paymentsList) {
    totalPrice += (item.price * item.quantity);
  }

  return totalPrice;
}

calculateItemCount(paymentsList) {
  num itemCount = 0;

  for (var item in paymentsList) {
    itemCount += item.quantity;
  }

  return itemCount;
}
