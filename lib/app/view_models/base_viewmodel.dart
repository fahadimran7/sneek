import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _loading = false;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  get loading => _loading;
}
