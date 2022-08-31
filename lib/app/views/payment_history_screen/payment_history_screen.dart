import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/custom_app_bar.dart';
import 'package:flutter_mvvm_project/app/models/payment_model.dart';
import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'components/body.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PaymentService()
          .getPaymentHistoryForUser(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return FutureBuilder(
            future: snapshot.data as Future<List<PaymentModel>>,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if ((snapshot.data as List<PaymentModel>).isNotEmpty) {
                return Scaffold(
                  appBar: const CustomAppBar(
                      title: 'Purchase History', enableActions: false),
                  body: SingleChildScrollView(
                      child: Body(
                          paymentItem: snapshot.data as List<PaymentModel>)),
                );
              }

              return const Scaffold(
                appBar: CustomAppBar(
                  title: 'Purchase History',
                  enableActions: false,
                ),
                body: Center(
                  child: Text('No purchase history items to show'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          const SafeArea(
            child: Scaffold(
              body: Text('Something went wrong!'),
            ),
          );
        }

        return const Center(
          child: SafeArea(
            child: Scaffold(
              body: Text('No records to show!'),
            ),
          ),
        );
      },
    );
  }
}
