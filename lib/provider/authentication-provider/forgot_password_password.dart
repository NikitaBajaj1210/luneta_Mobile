import 'package:flutter/material.dart';

class ForgotPasswordProvider with ChangeNotifier {

  int selectedRoleIndex = -1;

  int _selectedCountryIndex = -1;

  int get selectedCountryIndex => _selectedCountryIndex;

  set selectedCountryIndex(int index) {
    if(selectedCountryIndex != index){
      _selectedCountryIndex = index;
      notifyListeners();
    }

  }

  void updateSelectedRole(int index) {
    if(selectedRoleIndex != index){
      selectedRoleIndex = index;
      notifyListeners();
    }

  }

  final List<Map<String, String>> roles = [
    {
      'title': 'via SMS:',
      'subtitle': '+63 111 ******99',
      'icon': 'assets/images/Chat.png', // Example icon path
    },
    {
      'title': 'via Email:',
      'subtitle': 'jua***ruz@gmail.com',
      'icon': 'assets/images/MessageIcon.png', // Example icon path
    },
  ];


  }
