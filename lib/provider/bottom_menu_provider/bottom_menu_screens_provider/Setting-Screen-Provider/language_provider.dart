import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  // Default selected language
  String _suggestedLanguage = 'English (US)';
  String _selectedLanguage = 'Mandarin';

  // Getters and Setters
  String get suggestedLanguage => _suggestedLanguage;
  set setSuggestedLanguage(String value) {
    _suggestedLanguage = value;
    notifyListeners();
  }

  String get selectedLanguage => _selectedLanguage;
  set setSelectedLanguage(String value) {
    _selectedLanguage = value;
    notifyListeners();
  }
}
