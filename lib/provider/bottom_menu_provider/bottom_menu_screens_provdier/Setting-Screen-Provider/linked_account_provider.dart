import 'package:flutter/material.dart';

class LinkedAccountProvider with ChangeNotifier {
  bool _googleLinked = false;
  bool _appleLinked = false;
  bool _facebookLinked = false;
  bool _twitterLinked = false;
  bool _linkedinLinked = false;

  bool get googleLinked => _googleLinked;
  bool get appleLinked => _appleLinked;
  bool get facebookLinked => _facebookLinked;
  bool get twitterLinked => _twitterLinked;
  bool get linkedinLinked => _linkedinLinked;

  set googleLinked(bool value) {
    _googleLinked = value;
    notifyListeners();
  }

  set appleLinked(bool value) {
    _appleLinked = value;
    notifyListeners();
  }

  set facebookLinked(bool value) {
    _facebookLinked = value;
    notifyListeners();
  }

  set twitterLinked(bool value) {
    _twitterLinked = value;
    notifyListeners();
  }

  set linkedinLinked(bool value) {
    _linkedinLinked = value;
    notifyListeners();
  }
}
