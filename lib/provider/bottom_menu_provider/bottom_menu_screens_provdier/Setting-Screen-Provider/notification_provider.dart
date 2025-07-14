import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  // Boolean values for each notification setting
  bool _generalNotification = true;
  bool _sound = true;
  bool _vibrate = false;
  bool _jobRecommendation = true;
  bool _jobInvitation = true;
  bool _profileViews = false;
  bool _appUpdates = true;
  bool _newServices = false;
  bool _newTips = false;

  // Getters and Setters for each notification setting
  bool get generalNotification => _generalNotification;
  set setGeneralNotification(bool value) {
    _generalNotification = value;
    notifyListeners();
  }

  bool get sound => _sound;
  set setSound(bool value) {
    _sound = value;
    notifyListeners();
  }

  bool get vibrate => _vibrate;
  set setVibrate(bool value) {
    _vibrate = value;
    notifyListeners();
  }

  bool get jobRecommendation => _jobRecommendation;
  set setJobRecommendation(bool value) {
    _jobRecommendation = value;
    notifyListeners();
  }

  bool get jobInvitation => _jobInvitation;
  set setJobInvitation(bool value) {
    _jobInvitation = value;
    notifyListeners();
  }

  bool get profileViews => _profileViews;
  set setProfileViews(bool value) {
    _profileViews = value;
    notifyListeners();
  }

  bool get appUpdates => _appUpdates;
  set setAppUpdates(bool value) {
    _appUpdates = value;
    notifyListeners();
  }

  bool get newServices => _newServices;
  set setNewServices(bool value) {
    _newServices = value;
    notifyListeners();
  }

  bool get newTips => _newTips;
  set setNewTips(bool value) {
    _newTips = value;
    notifyListeners();
  }
}
