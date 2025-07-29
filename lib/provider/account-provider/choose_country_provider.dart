import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/country_model.dart';

class ChooseCountryProvider with ChangeNotifier {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  String? _selectedCountryCode;
  int? _selectedRoleIndex = -1;
  
  List<CountryModel> _countries = [];
  bool _isLoading = true;

  List<CountryModel> get countries => _countries;
  bool get isLoading => _isLoading;

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
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final String response = await rootBundle.loadString('assets/data/countries.json');
      final List<dynamic> jsonData = json.decode(response);
      
      _countries = jsonData.map((json) => CountryModel.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading countries: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Getter and Setter for selectedCountryCode
  String? get selectedCountryCode => _selectedCountryCode;
  set selectedCountryCode(String? code) {
    _selectedCountryCode = code;
    notifyListeners();
  }

  void updateSelectedCountry(int? index) {
    if (index != null && index >= 0 && index < filteredCountries.length) {
      _selectedCountryCode = filteredCountries[index].code;
      notifyListeners();
    }
  }

  // Getter and Setter for selectedRoleIndex
  int? get selectedRoleIndex => _selectedRoleIndex;
  set selectedRoleIndex(int? index) {
    _selectedRoleIndex = index;
    notifyListeners();
  }

  // Update search query
  void updateSearchQuery(String query) {
    if (searchController.text != query) {
      searchController.text = query;
      notifyListeners();
    }
  }

  // Filtered list based on search query
  List<CountryModel> get filteredCountries {
    if (searchController.text.isEmpty) {
      return _countries;
    }
    return _countries
        .where((country) => country.name!.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  bool get isContinueEnabled {
    return _selectedCountryCode != null;
  }

  CountryModel? get selectedCountry {
    if (_selectedCountryCode != null) {
      return _countries.firstWhere(
        (country) => country.code == _selectedCountryCode,
        orElse: () => CountryModel(),
      );
    }
    return null;
  }

  int? get selectedCountryIndex {
    if (_selectedCountryCode != null) {
      final index = filteredCountries.indexWhere((country) => country.code == _selectedCountryCode);
      return index >= 0 ? index : null;
    }
    return null;
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