import 'package:flutter/material.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/home_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/profile_screen_bottom_menu.dart';

class BottomMenuProvider with ChangeNotifier {
  // Private field for selected index
  int _selectedIndex = 0;

  // List of tab names
  final List<String> _tabNames = ["Home", "Saved Jobs", "Application", "Message", "Profile"];

  // Getter for tabNames
  List<String> get tabNames => _tabNames;

  // Getter for selectedIndex
  int get selectedIndex => _selectedIndex;

  // Setter for selectedIndex
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Update selected index
  void updateSelectedIndex(int index) {
    selectedIndex = index; // Using the setter
  }

  // Get the selected screen widget based on selectedIndex
  Widget getSelectedScreen(BottomMenuProvider provider) {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return HomeScreen();
      case 2:
        return HomeScreen();
      case 3:
        return HomeScreen();
      case 4:
        return ProfileScreenBottomMenu();
      default:
        return HomeScreen();
    }
  }


  // Maps for selected and unselected icons
  final Map<int, String> _selectedIcons = {
    0: 'assets/images/HomeActive.png',
    1: 'assets/images/saveActive.png',
    2: 'assets/images/WorkActive.png',
    3: 'assets/images/ChatActive.png',
    4: 'assets/images/profileActive.png',
  };

  final Map<int, String> _unselectedIcons = {
    0: 'assets/images/homeInactive.png',
    1: 'assets/images/saveInactive.png',
    2: 'assets/images/begInactive.png',
    3: 'assets/images/ChatInactive.png',
    4: 'assets/images/profileInactive.png',
  };

  // Getters for selectedIcons and unselectedIcons
  Map<int, String> get selectedIcons => _selectedIcons;

  Map<int, String> get unselectedIcons => _unselectedIcons;

  // Get the selected icon path for the current index
  String getSelectedIconPath(int index) {
    return _selectedIcons[index] ?? '';
  }

  // Get the unselected icon path for the current index
  String getUnselectedIconPath(int index) {
    return _unselectedIcons[index] ?? '';
  }
}
