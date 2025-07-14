import 'package:flutter/material.dart';

class JobSeekingStatusProvider extends ChangeNotifier {
  // Default selected status index
  int _selectedStatusIndex = 1; // "Passively looking for jobs" is the default option

  int get selectedStatusIndex => _selectedStatusIndex;

  set selectedStatusIndex(int newStatusIndex) {
    _selectedStatusIndex = newStatusIndex;
    notifyListeners();
  }
}
