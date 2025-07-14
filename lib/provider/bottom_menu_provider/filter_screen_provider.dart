import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterScreenProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  /// **Tracks multiple expanded dropdowns**
  Set<int> expandedIndexes = {};

  /// **Toggle Dropdown (Now allows multiple open dropdowns)**
  void toggleExpandedIndex(int index) {
    if (expandedIndexes.contains(index)) {
      expandedIndexes.remove(index); // Collapse if already open
    } else {
      expandedIndexes.add(index); // Expand if closed
    }
    notifyListeners();
  }

  List<String> _tabs = ["Location & Salary", "Work Type", "Job Level"];
  List<String> get tabs => _tabs;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  /// **Salary Range Slider State**
  RangeValues _salaryRange = const RangeValues(20, 80);
  RangeValues get salaryRange => _salaryRange;

  /// **List of Filter Options**
  List<String> _filterOptions = [
    "Location & Salary",
    "Work Type",
    "Job Level",
    "Employment Type",
    "Experience",
    "Education",
    "Job Function",
  ];
  List<String> get filterOptions => _filterOptions;

  /// **Set Active Tab**
  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  /// **Update Salary Range**
  void updateSalaryRange(RangeValues values) {
    _salaryRange = values;
    notifyListeners();
  }

  double lowerValue = 30;
  double upperValue = 420;

  String _selectedMonth = 'per month';
  String get selectedMonth => _selectedMonth;

  set selectedMonth(String value) {
    _selectedMonth = value;
    notifyListeners();
  }

  int? selectedCountryIndex = -1;

  final List<String> countries = [
    'Onsite (Work from Office)',
    'Remote (Work from Home)',
  ];

  List<String> get filteredCountries {
    return countries
        .where((country) =>
        country.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  void updateSelectedCountry(int? index) {
    selectedCountryIndex = index;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchController.text = query;
    notifyListeners();
  }

  /// **Job Level Dropdown**
  List<String> jobLevels = [
    "Internship / OJT",
    "Entry Level / Junior, Apprentice",
    "Associate / Supervisor",
    "Mid-Senior Level / Manager",
    "Director / Executive",
  ];
  List<int> selectedJobLevels = [];

  void toggleJobLevelSelection(int index) {
    if (selectedJobLevels.contains(index)) {
      selectedJobLevels.remove(index);
    } else {
      selectedJobLevels.add(index);
    }
    notifyListeners();
  }

  /// **Dropdown Data**
  List<String> employmentTypes = ["Full Time", "Part Time", "Freelance", "Contractual"];
  List<String> experienceLevels = ["No Experience", "1 - 5 Years", "6 - 10 Years", "More than 10 Years"];
  List<String> educationLevels = ["Less Than High School", "High School", "Associate’s Degree", "Bachelor’s Degree", "Master’s Degree", "Doctoral / Professional Degree"];
  List<String> jobFunctions = [
    "Accounting and Finance",
    "Architecture and Construction",
    "Arts and Sports",
    "Customer Service",
    "Education and Training",
    "Health and Medicine",
    "Information Technology",
    "Legal",
    "Marketing and Sales",
    "Supply Chain",
    "Writing and Content"
  ];

  /// **Single Selection for Employment & Experience (Radio)**
  int? selectedRadioOption;

  void updateSelectedRadio(int index) {
    selectedRadioOption = index;
    notifyListeners();
  }

  /// **Multiple Selection for Education & Job Function (Checkbox)**
  List<int> selectedCheckboxOptions = [];

  void toggleCheckboxSelection(int index) {
    if (selectedCheckboxOptions.contains(index)) {
      selectedCheckboxOptions.remove(index);
    } else {
      selectedCheckboxOptions.add(index);
    }
    notifyListeners();
  }
}
