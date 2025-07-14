import 'package:flutter/material.dart';

class ChooseRankProvider with ChangeNotifier {
  int? _selectedRankIndex;

  final List<String> _ranks = [
    'Master',
    'Chief Officer',
    '2nd Officer',
    '3rd Officer',
    'Chief Engineer',
    '2nd Engineer',
    '3rd Engineer',
  ];

  // Getter for ranks list
  List<String> get ranks => _ranks;

  // Getter for selectedRankIndex
  int? get selectedIndex => _selectedRankIndex;

  // Method to set or toggle selected rank
  void setSelectedRankIndex({required int index}) {
    if (_selectedRankIndex == index) {
      _selectedRankIndex = null; // Unselect if the same item is tapped
    } else {
      _selectedRankIndex = index; // Select the new item
    }
    notifyListeners();
  }

  bool get isRankSelected => _selectedRankIndex != null;
}