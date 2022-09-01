import 'package:flutter_mvvm_project/app/services/payment/payment_service.dart';
import 'package:flutter_mvvm_project/app/services/toast/toast_service.dart';
import 'package:flutter_mvvm_project/app/view_models/base_viewmodel.dart';
import '../services/service_locator.dart';

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

  showToast(message) {
    _toastService.showToast(message);
  }
}
