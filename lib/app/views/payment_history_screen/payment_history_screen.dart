import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/globals/app_error.dart';
import 'package:flutter_mvvm_project/app/components/globals/app_loading.dart';
import 'package:flutter_mvvm_project/app/components/globals/app_no_records.dart';
import 'package:flutter_mvvm_project/app/models/payment_model.dart';
import 'package:flutter_mvvm_project/app/view_models/payment_history_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../components/globals/custom_app_bar.dart';
import 'components/body.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentHistoryViewModel = context.watch<PaymentHistoryViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Purchase History',
        enableActions: false,
      ),
      body: StreamBuilder(
        stream: paymentHistoryViewModel
            .getPaymentHistoryStream(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          }

          if (snapshot.hasData) {
            return FutureBuilder(
              future: snapshot.data as Future<List<PaymentModel>>,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AppLoading();
                } else if ((snapshot.data as List<PaymentModel>).isNotEmpty) {
                  return SingleChildScrollView(
                    child:
                        Body(paymentItem: snapshot.data as List<PaymentModel>),
                  );
                }

                return const AppNoRecords(
                    message: 'No purchase history items to show');
              },
            );
          } else if (snapshot.hasError) {
            return const AppError();
          }

          return const AppNoRecords(message: 'No records to show');
        },
      ),
    );
  }
}
