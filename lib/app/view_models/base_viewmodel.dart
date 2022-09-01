import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _loading = false;
  String _error = '';

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setError(String msg) {
    _error = msg;
  }

  get loading => _loading;
  get error => _error;
}
