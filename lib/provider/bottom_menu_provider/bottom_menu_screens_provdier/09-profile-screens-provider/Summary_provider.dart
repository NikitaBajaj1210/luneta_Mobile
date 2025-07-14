import 'package:flutter/material.dart';

class SummaryProvider extends ChangeNotifier {
  TextEditingController summaryController = TextEditingController();
  FocusNode summaryFocusNode = FocusNode();
  int maxCharacters = 500;

  SummaryProvider() {
    summaryController.text = "Hello, I'm Andrew. I am a designer with more than 5 years experience. "
        "My main fields are UI/UX Design, Illustration and Graphic Design. "
        "You can check the portfolio on my profile.";
  }

  void updateSummary(String newText) {
    if (newText.length <= maxCharacters) {
      summaryController.text = newText;
      notifyListeners();
    }
  }
}
