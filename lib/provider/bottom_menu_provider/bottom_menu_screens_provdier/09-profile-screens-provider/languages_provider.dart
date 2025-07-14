import 'package:flutter/material.dart';

class LanguagesProvider extends ChangeNotifier {
  /// **Selected Language**
  String _selectedLanguage = "English (US)";
  List<String> _languages = [
    "English (US)",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Hindi",
    "Arabic",
    "Portuguese"
  ];

  String get selectedLanguage => _selectedLanguage;
  List<String> get languages => _languages;

  void setLanguage(String newValue) {
    _selectedLanguage = newValue;
    notifyListeners();
  }

  /// **Selected Proficiency**
  String _selectedProficiency = "Native or Bilingual Proficiency";
  List<String> _proficiencies = [
    "Elementary Proficiency",
    "Limited Working Proficiency",
    "Professional Working Proficiency",
    "Full Professional Proficiency",
    "Native or Bilingual Proficiency"
  ];

  String get selectedProficiency => _selectedProficiency;
  List<String> get proficiencies => _proficiencies;

  void setProficiency(String newValue) {
    _selectedProficiency = newValue;
    notifyListeners();
  }

  void resetForm() {
    _selectedLanguage = "English (US)";
    _selectedProficiency = "Native or Bilingual Proficiency";
    notifyListeners();
  }

  void initializeWithData({
    required String language,
    required String proficiency,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize selections
    if (_languages.contains(language)) {
      _selectedLanguage = language;
    }
    if (_proficiencies.contains(proficiency)) {
      _selectedProficiency = proficiency;
    }

    notifyListeners();
  }
}
