import 'package:flutter/material.dart';
import 'package:luneta/Utils/helper.dart';

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
      print("Logout - Starting logout process");
      
      // Make API call to get user's complete profile
      final response = await NetworkService().getResponse(
        logoutUrl,
        false, // showLoading
        context, // context
            notifyListeners, // callback
      );

      print("Logout API CALL Response$response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Clear stored login data
        await NetworkHelper.clearUserData();

        print("Logout - Cleared stored login data");

        // Small delay to ensure context stabilizes
        await Future.delayed(Duration(milliseconds: 100));

        // Use global navigator to avoid context issues after async operations
        try {
          print("Logout - Attempting navigation (context.mounted: ${context.mounted})");
          
          // First try with the passed context
          if (context.mounted) {
            print("Logout - Using mounted context for navigation");
            Navigator.of(context).pushNamedAndRemoveUntil(
              login,
              (Route<dynamic> route) => false,
            );
            print("Logout - Navigation completed with context");
          } else {
            // Fallback to global navigator key
            print("Logout - Context not mounted, trying global navigator");
            if (Helper.navigatorKey.currentState != null) {
              Helper.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                login,
                (Route<dynamic> route) => false,
              );
              print("Logout - Navigation completed with global navigator");
            } else {
              print("Logout - Global navigator is also null");
              // Force stop loading if we can't navigate
              try {
                stopLoading(context);
              } catch (e) {
                print("Logout - Could not stop loading: $e");
              }
            }
          }
        } catch (e) {
          print("Logout - Navigation error: $e");
          // Try to stop loading on navigation error
          try {
            if (context.mounted) stopLoading(context);
          } catch (loadingError) {
            print("Logout - Could not stop loading: $loadingError");
          }
        }

        return true;
      } else {
        print("Logout - API call failed with status: ${response['statusCode']}");
        // Stop loading on API failure
        if (context.mounted) stopLoading(context);
        return false;
      }
    } catch (e) {
      print("Logout - Logout completion check error: $e");
      // Stop loading on error
      if (context.mounted) stopLoading(context);
      return false;
    }
  }

}
