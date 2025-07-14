import 'package:flutter/material.dart';

class ExpectedSalaryProvider extends ChangeNotifier {
  TextEditingController minSalaryController = TextEditingController();
  TextEditingController maxSalaryController = TextEditingController();

  List<String> currencies = ["USD", "EUR", "GBP", "INR"];
  String selectedCurrency = "USD";

  List<String> frequencies = ["per hour", "per day", "per month", "per year"];
  String selectedFrequency = "per month";

  // Focus Nodes
  FocusNode minSalaryFocusNode = FocusNode();
  FocusNode maxSalaryFocusNode = FocusNode();

  // Setters and Getters
  void setCurrency(String newCurrency) {
    selectedCurrency = newCurrency;
    notifyListeners();
  }

  void setFrequency(String newFrequency) {
    selectedFrequency = newFrequency;
    notifyListeners();
  }

  @override
  void dispose() {
    minSalaryFocusNode.dispose();
    maxSalaryFocusNode.dispose();
    super.dispose();
  }
}
