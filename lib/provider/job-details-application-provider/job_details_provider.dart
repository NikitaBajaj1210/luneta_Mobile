import 'package:flutter/material.dart';
class JobDetailsProvider extends ChangeNotifier {
  // Other Job Details Variables
  String _jobTitle = '';
  String _companyName = '';
  String _location = "California, United States";
  String _salaryRange = '';
  List<String> _tags = ["Full Time", "Onsite"];
  String _postDate = "10 days ago";
  String _endDate = "31 Dec";
  bool _isSaved = false;

  // Tabs
  List<String> _tabs = ["Job Description", "Minimum Qualifications", "Perks", "Required Skills"];
  int _selectedTabIndex = 0;

  // Static List for Required Skills
  final List<String> _requiredSkills = [
    "Creative Thinking",
    "UI/UX Design",
    "Figma",
    "Graphic Design",
    "Web Design",
    "Layout"
  ];

  // Getters
  String get jobTitle => _jobTitle;
  String get companyName => _companyName;
  String get location => _location;
  String get salaryRange => _salaryRange;
  List<String> get tags => _tags;
  String get postDate => _postDate;
  String get endDate => _endDate;
  bool get isSaved => _isSaved;

  set jobTitle(String value) {
    _jobTitle = value;
    notifyListeners();
  }
  set companyName(String value) {
    _companyName = value;
    notifyListeners();
  }
  set location(String value) {
    _location = value;
    notifyListeners();
  }
  set salaryRange(String value) {
    _salaryRange = value;
    notifyListeners();
  }
  set tags(List<String> value) {
    _tags = value;
    notifyListeners();
  }
  set postDate(String value) {
    _postDate = value;
    notifyListeners();
  }
  set endDate(String value) {
    _endDate = value;
    notifyListeners();
  }

  List<String> get tabs => _tabs;
  int get selectedTabIndex => _selectedTabIndex;

  List<String> get requiredSkills => _requiredSkills;

  // Setter for selected tab index
  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // Toggle Save Status
  void toggleSaveStatus() {
    _isSaved = !_isSaved;
    notifyListeners();
  }

  String jobLevel = "Associate / Supervisor";
  String jobCategory = "IT and Software";
  String education = "Bachelor's Degree";
  String experience = "1 - 3 Years";
  String vacancy = "2 opening";
  String website = "www.google.com";


  List<Map<String, String>> shareOptions = [
    {"icon": "assets/images/What'sAppIcon.png", "label": "WhatsApp"},
    {"icon": "assets/images/TwitterIcon.png", "label": "Twitter"},
    {"icon": "assets/images/fbIcon.png", "label": "Facebook"},
    {"icon": "assets/images/instaIcon.png", "label": "Instagram"},
    {"icon": "assets/images/yahooIcon.png", "label": "Yahoo"},
    {"icon": "assets/images/TickTokIcon.png", "label": "TikTok"},
    {"icon": "assets/images/InBoxMessageIcon.png", "label": "Chat"},
    {"icon": "assets/images/MessengerIcon.png", "label": "WeChat"},
  ];

}
