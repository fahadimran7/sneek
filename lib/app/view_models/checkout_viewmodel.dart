import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'package:flutter_mvvm_project/app/services/toast/toast_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../services/service_locator.dart';
import 'package:http/http.dart' as http;

class CheckoutViewModel extends BaseViewModel {
  final ToastService _toastService = locator<ToastService>();
  final PaymentService _paymentService = locator<PaymentService>();

  Future<dynamic> completePayment(num totalAmount) async {
    setLoading(true);
    final res = await _paymentService.completePayment(totalAmount);

    if (res is! bool) {
      setError(res);
      setLoading(false);
    } else {
      setError('');
      setLoading(false);
    }
  }

  Future<dynamic> initPaymentSheet(context,
      {required String email, required int amount}) async {
    try {
      setLoading(true);
      // 1. create payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-fir-mvvm-project.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      setLoading(false);

      return true;
    } catch (e) {
      if (e is StripeException) {
        setLoading(false);
        showToast(
          '${e.error.localizedMessage}',
        );
      } else {
        setLoading(false);
        showToast(
          'Error: $e',
        );
      }
    }
  }

  showToast(message) {
    _toastService.showToast(message);
  }
}
