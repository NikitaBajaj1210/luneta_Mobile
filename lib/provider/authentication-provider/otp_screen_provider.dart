import 'package:flutter/material.dart';

class OtpScreenProvider with ChangeNotifier {
  String _pin = '';

  String get pin => _pin;

  set pin(String value) {
    _pin = value;
    notifyListeners();
  }
}