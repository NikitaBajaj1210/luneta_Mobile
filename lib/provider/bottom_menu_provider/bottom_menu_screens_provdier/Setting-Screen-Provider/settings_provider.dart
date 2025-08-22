import 'package:flutter/material.dart';

import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../route/route_constants.dart';

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

  Future<bool?> logoutAPI(BuildContext context) async {
    try {
      // Make API call to get user's complete profile
      final response = await NetworkService().getResponse(
        logoutUrl,
        false, // showLoading
        context, // context
            () => {}, // callback
      );

      print("Logout API CALL Response$response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Clear stored login data
        await NetworkHelper.clearUserData();

        print("Logout - Cleared stored login data");

        // Navigate to login screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          login,
              (route) => false, // Remove all previous routes
        );
        // Check if the response contains profile data
      }

      // Default to false if API call fails or data is missing
      return null;
    } catch (e) {
      print("Logout - Logout completion check error: $e");
      // Default to false on error
      return null;
    }
  }

}
