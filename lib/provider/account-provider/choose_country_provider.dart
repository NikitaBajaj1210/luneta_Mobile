import 'package:flutter/material.dart';

class ChooseCountryProvider with ChangeNotifier {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  int? _selectedCountryIndex = -1;
  int? _selectedRoleIndex = -1;

  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua & Deps',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
  ];

  final List<Map<String, String>> roles = [
    {
      'title': 'Shipping Company',
      'subtitle': 'We are hiring skilled seafarers',
      'icon': 'assets/images/bagIcon.png',
    },
    {
      'title': 'I am a Seafarer',
      'subtitle': 'I am looking for job opportunities',
      'icon': 'assets/images/ProfileIcon.png',
    },
  ];

  ChooseCountryProvider() {
    searchFocusNode.addListener(() {
      notifyListeners();
    });
  }

  // Getter and Setter for selectedCountryIndex
  int? get selectedCountryIndex => _selectedCountryIndex;
  set selectedCountryIndex(int? index) {
    _selectedCountryIndex = index;
    notifyListeners();
  }

  void updateSelectedCountry(int? index) {
    selectedCountryIndex = index;
    notifyListeners();
  }

  // Getter and Setter for selectedRoleIndex
  int? get selectedRoleIndex => _selectedRoleIndex;
  set selectedRoleIndex(int? index) {
    _selectedRoleIndex = index;
    notifyListeners();
  }

  // Update search query
  void updateSearchQuery(String query) {
    searchController.text = query;
    notifyListeners();
  }

  // Filtered list based on search query
  List<String> get filteredCountries {
    return countries
        .where((country) => country.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  bool get isContinueEnabled {
    return selectedCountryIndex != -1;
  }

  bool get isRoleSelected {
    return selectedRoleIndex != -1;
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
}