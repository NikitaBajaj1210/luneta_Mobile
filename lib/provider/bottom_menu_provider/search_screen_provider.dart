import 'package:flutter/cupertino.dart';

class SearchScreenProvider with ChangeNotifier {
  FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  int _visibleRecommendationCount = 10;
  bool isAscending = true; // Track sorting order
  String _selectedSortOption = "Most Relevant"; // Default sort option

  List<Map<String, dynamic>> _filteredJobs = [];
  List<Map<String, dynamic>> _recommendations = [
    {
      'jobTitle': 'Chief Officer',
      'companyName': 'Starbulk',
      'companyLogo': 'assets/images/companyLogo.png',
      'jobType': 'Container',
      'salaryRange': 'Salary Negotiable',
      'duration': '8 months',
      'requirements': 'EU Passport',
      'isSaved': false,
    },
    {
      'jobTitle': '3rd Officer',
      'companyName': 'Costamare',
      'companyLogo': 'assets/images/companyLogo.png',
      'jobType': 'Container',
      'salaryRange': 'Salary Negotiable',
      'duration': 'Part Time',
      'requirements': null,
      'isSaved': false,
    },
    {
      'jobTitle': '2nd Officer',
      'companyName': 'Costamare',
      'companyLogo': 'assets/images/companyLogo.png',
      'jobType': 'Container',
      'salaryRange': '\$8,000 - \$10,000 /month',
      'duration': 'Freelance',
      'requirements': 'Remote',
      'isSaved': false,
    },
  ];

  SearchScreenProvider() {
    _filteredJobs = List.from(_recommendations);
  }

  List<Map<String, dynamic>> get visibleRecommendations {
    return _filteredJobs.take(_visibleRecommendationCount).toList();
  }

  String get selectedSortOption => _selectedSortOption;

  /// **Sort the jobs based on selected option**
  void sortJobs(String option) {
    _selectedSortOption = option;

    switch (option) {
      case "Alphabetical (A to Z)":
        _filteredJobs.sort((a, b) => a['jobTitle'].compareTo(b['jobTitle']));
        break;
      case "Most Relevant":
        _filteredJobs = List.from(_recommendations);
        break;
      case "Highest Salary":
        _filteredJobs.sort((a, b) => _extractSalary(b['salaryRange']).compareTo(_extractSalary(a['salaryRange'])));
        break;
      case "Newly Posted":
        _filteredJobs.shuffle(); // Simulate new postings
        break;
      case "Ending Soon":
        _filteredJobs.shuffle(); // Simulate job postings ending soon
        break;
    }

    notifyListeners();
  }

  /// **Extract salary for sorting**
  int _extractSalary(String salary) {
    final regex = RegExp(r'\d+');
    final matches = regex.allMatches(salary);
    return matches.isNotEmpty ? int.parse(matches.first.group(0)!) : 0;
  }

  void filterJobs(String query) {
    if (query.isEmpty) {
      _filteredJobs = List.from(_recommendations);
    } else {
      _filteredJobs = _recommendations
          .where((job) =>
      job['jobTitle'].toLowerCase().contains(query.toLowerCase()) ||
          job['companyName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleSaveStatus(int index) {
    if (index >= 0 && index < _filteredJobs.length) {
      _filteredJobs[index]['isSaved'] = !_filteredJobs[index]['isSaved'];
      notifyListeners();
    }
  }

  List<String> sortOptions = [
    "Alphabetical (A to Z)",
    "Most Relevant",
    "Highest Salary",
    "Newly Posted",
    "Ending Soon"
  ];

}
