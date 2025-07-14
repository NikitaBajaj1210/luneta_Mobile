import 'package:flutter/material.dart';

class CreatePinProvider with ChangeNotifier {
  String _pin = '';

  String get pin => _pin;

  set pin(String value) {
    _pin = value;
    notifyListeners();
  }

  String _enteredPin = "";

  String get enteredPin => _enteredPin;

  void setEnteredPin(String pin) {
    _enteredPin = pin;
    notifyListeners();
  }
}