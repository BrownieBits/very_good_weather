import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _mdn = '';

  String get mdn => _mdn;

  void updateMDN(String newMDN) {
    _mdn = newMDN;
    notifyListeners();
  }
}
