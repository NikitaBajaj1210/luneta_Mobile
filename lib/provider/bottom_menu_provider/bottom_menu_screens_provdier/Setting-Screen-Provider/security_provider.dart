import 'package:flutter/material.dart';

class SecurityProvider with ChangeNotifier {
  // Boolean values for each setting
  bool _rememberMe = false;
  bool _biometricID = false;
  bool _faceID = false;
  bool _googleAuthenticator = false;

  // Getters and Setters for each setting
  bool get rememberMe => _rememberMe;
  set setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  bool get biometricID => _biometricID;
  set setBiometricID(bool value) {
    _biometricID = value;
    notifyListeners();
  }

  bool get faceID => _faceID;
  set setFaceID(bool value) {
    _faceID = value;
    notifyListeners();
  }

  bool get googleAuthenticator => _googleAuthenticator;
  set setGoogleAuthenticator(bool value) {
    _googleAuthenticator = value;
    notifyListeners();
  }
}
