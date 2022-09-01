import 'package:flutter_mvvm_project/app/models/payment_model.dart';
import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

class PaymentHistoryViewModel extends BaseViewModel {
  final PaymentService _paymentService = locator<PaymentService>();

  Stream<Future<List<PaymentModel>>> getPaymentHistoryStream(uid) {
    return _paymentService.getPaymentHistoryForUser(uid);
  }
}
