import 'package:flutter/material.dart';
import 'package:luneta/const/color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HelpCenterProvider with ChangeNotifier {
  // Existing data
  List<Map<String, dynamic>> _faqItems = [
    {"question": "What is Jobee?", "answer": "Lorem ipsum dolor sit amet...", "expanded": "false"},
    {"question": "How to apply a job?", "answer": "Sed do eiusmod tempor incididunt...", "expanded": "false"},
    {"question": "How do I complete my profile?", "answer": "Quis nostrud exercitation ullamco laboris nisi ut aliquip...", "expanded": "false"},
    {"question": "How do I can delete my account?", "answer": "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur...", "expanded": "false"},
    {"question": "How do I exit the app?", "answer": "Excepteur sint occaecat cupidatat non proident...", "expanded": "false"},
  ];

  List<Map<String, dynamic>> get faqItems => _faqItems;

  // Search-related data
  String _searchQuery = "";
  List<Map<String, dynamic>> _searchResults = [];

  String get searchQuery => _searchQuery;

  List<Map<String, dynamic>> get searchResults => _searchResults;

  // Method to update the search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _updateSearchResults();
    notifyListeners();
  }

  // Method to filter the search results
  void _updateSearchResults() {
    if (_searchQuery.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _faqItems
          .where((faqItem) =>
          faqItem["question"]!.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  // FAQ expansion logic
  void setFaqExpanded(int index, bool isExpanded) {
    _faqItems[index]["expanded"] = isExpanded ? "true" : "false";
    notifyListeners();
  }

  // Tabs logic
  List<String> _tabs = ["FAQ", "Contact us"];
  List<String> get tabs => _tabs;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // Dummy data for recent jobs
  List<String> _recentJobs = ["General", "Account", "Service", "Applications"];
  List<String> get recentJobs => _recentJobs;

  int _selectedJobIndex = -1;
  int get selectedJobIndex => _selectedJobIndex;

  void updateSelectedJob(int index) {
    _selectedJobIndex = index;
    notifyListeners();
  }

  // Search Focus Node for the search field
  final FocusNode _searchFocusNode = FocusNode();
  FocusNode get searchFocusNode => _searchFocusNode;

  // Search Controller for the search field
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  // Contact Us data
  final List<Map<String, dynamic>> _contactUsList = [
    {
      "icon": Image.asset(
        "assets/images/CustomerService.png",
        color: AppColors.buttonColor,
        width: 3.h, // Adjust the width to the desired size
        height: 3.h, // Adjust the height as well
      ),
      "name": "Customer Service"
    },
    {
      "icon": Image.asset(
        "assets/images/whatsappIcon.png",
        color: AppColors.buttonColor,
        width: 3.h, // Adjust the width to the desired size
        height: 3.h, // Adjust the height as well
      ),
      "name": "WhatsApp"
    },
    {
      "icon": Icon(Icons.language, color: AppColors.buttonColor),
      "name": "Website"
    },
    {
      "icon": Icon(Icons.facebook, color: AppColors.buttonColor),
      "name": "Facebook"
    },
    {
      "icon": Image.asset(
        "assets/images/bird.png",
        color: AppColors.buttonColor,
        width: 3.h, // Adjust the width to the desired size
        height: 3.h, // Adjust the height as well
      ),
      "name": "Twitter"
    },
    {
      "icon": Image.asset(
        "assets/images/InstagramIcon.png",
        color: AppColors.buttonColor,
        width: 3.h, // Adjust the width to the desired size
        height: 3.h, // Adjust the height as well
      ),
      "name": "Instagram"
    },
  ];


  List<Map<String, dynamic>> get contactUsList => _contactUsList;
}
