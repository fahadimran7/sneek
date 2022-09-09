import 'package:flutter_mvvm_project/app/models/purchased_model.dart';

class PaymentModel {
  List<PurchasedModel> paymentItemsList = [];

  PaymentModel({required this.paymentItemsList});
}
