import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  FocusNode searchFocusNode = FocusNode();
  // Private fields
  final TextEditingController _searchController = TextEditingController();
  String _userName = "Juan Dela Cruz"; // Default user name
  List<Map<String, dynamic>> _recommendations = [
    {
      'jobTitle': '2nd Officer',
      'companyName': 'Costamare',
      'companyLogo': 'assets/images/companyLogo.png',
      'jobType': 'Container',
      'salaryRange': 'Competitive Salary \$',
      'duration': '6 months',
      'requirements': 'EU Passport',
      'isSaved': false,
    },
    {
      'jobTitle': 'Captain',
      'companyName': 'Maran Gas',
      'companyLogo': 'assets/images/companyLogo.png',
      'jobType': 'Tanker',
      'salaryRange': 'Competitive Salary \$',
      'duration': '12 months',
      'requirements': 'EU Passport',
      'isSaved': false,
    },
  ];
  int _visibleRecommendationCount = 2; // Initially show 2 recommendations

  // Getters
  TextEditingController get searchController => _searchController;
  String get userName => _userName;
  List<Map<String, dynamic>> get recommendations => _recommendations;
  List<Map<String, dynamic>> get visibleRecommendations {
    return _recommendations.take(_visibleRecommendationCount).toList();
  }

  // Setters
  set userName(String name) {
    _userName = name;
    notifyListeners();
  }

  set recommendations(List<Map<String, dynamic>> newRecommendations) {
    _recommendations = newRecommendations;
    notifyListeners();
  }

  // Toggle Save/Unsave Status
  void toggleSaveStatus(int index) {
    if (index >= 0 && index < _recommendations.length) {
      _recommendations[index]['isSaved'] = !_recommendations[index]['isSaved'];
      notifyListeners();
    }
  }

  // Add a recommendation to the list
  void addRecommendation(Map<String, dynamic> recommendation) {
    _recommendations.add(recommendation);
    notifyListeners();
  }

  // Remove a recommendation from the list
  void removeRecommendation(int index) {
    if (index >= 0 && index < _recommendations.length) {
      _recommendations.removeAt(index);
      notifyListeners();
    }
  }

  // Method to increase visible recommendations
  void increaseVisibleRecommendations() {
    _visibleRecommendationCount += 2; // Show 2 more recommendations
    notifyListeners();
  }


  final List<String> _recentJobs = [
    "All",
    "Chief Officer",
    "2nd Officer",
    "3rd Officer",
    "Engineer",
  ];

  int _selectedJobIndex = 0;

  List<String> get recentJobs => _recentJobs;
  int get selectedJobIndex => _selectedJobIndex;
  void updateSelectedJob(int index) {
    _selectedJobIndex = index;
    notifyListeners();
  }
}
