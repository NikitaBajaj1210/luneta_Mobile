import 'package:flutter/material.dart';
class NotificationProvider with ChangeNotifier {
  List<String> _tabs = ["General", "Applications"];
  List<String> get tabs => _tabs;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // Dummy Data for General Notifications
  final List<Map<String, dynamic>> _generalNotifications = [
    {
      "title": "Security Update!",
      "description":
      "Now Luneta has a Two-Factor Authentication. Try it now to make your account more secure.",
      "time": "Dec 20, 2023 | 20:49 PM",
      "isNew": true,
    },
    {
      "title": "Password Updated",
      "description":
      "You have updated your password. Contact the Help Center if you feel you are not doing it.",
      "time": "Dec 19, 2023 | 18:35 PM",
      "isNew": true,
    },
    {
      "title": "Luneta Has Updated!",
      "description":
      "You can now apply for multiple jobs at once. You can also cancel your applications.",
      "time": "Dec 18, 2023 | 10:52 AM",
      "isNew": false,
    },
    {
      "title": "New Updates Available!",
      "description":
      "Update Luneta now to get access to the latest features and ease of applying for jobs.",
      "time": "Dec 18, 2023 | 15:38 PM",
      "isNew": false,
    },
    {
      "title": "Account Setup Successful!",
      "description":
      "Your account creation is successful, you can now apply jobs with our services.",
      "time": "Dec 18, 2023 | 14:27 PM",
      "isNew": false,
    },
  ];
  List<Map<String, dynamic>> get generalNotifications => _generalNotifications;

  // Dummy Data for Applications Notifications
  final List<Map<String, String>> _applicationNotifications = [
    {"position": "2nd Officer", "company": "Customer Inc.", "status": "Pending"},
    {
      "position": "3rd Officer",
      "company": "Company Name",
      "status": "Accepted"
    },
  ];
  List<Map<String, String>> get applicationNotifications =>
      _applicationNotifications;
}
