import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  double _profileCompletion = 95.0;
  bool _isDarkMode = false;
  String _language = "English (US)";
  bool _notificationsEnabled = true;

  double get profileCompletion => _profileCompletion;
  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;

  void setProfileCompletion(double value) {
    _profileCompletion = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }
}
