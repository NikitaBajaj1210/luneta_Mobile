import 'package:flutter/material.dart';

class ProjectsProfileScreenProvider with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController projectUrlController = TextEditingController();
  
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode roleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode projectUrlFocusNode = FocusNode();
  
  String? selectedAssociation;
  List<String> associationOptions = [
    'Company A',
    'Company B',
    'Company C',
    'Company D',
  ];

  DateTime? fromDate;
  DateTime? toDate;
  bool currentlyWorking = false;

  final List<Map<String, String>> projects = [];
  bool isProjectsSectionCompleted = false;

  void toggleCurrentlyWorking(bool value) {
    currentlyWorking = value;
    if (currentlyWorking) {
      toDate = null;
    }
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6B7280),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isFromDate) {
        fromDate = picked;
        if (toDate != null && toDate!.isBefore(fromDate!)) {
          toDate = null;
        }
      } else {
        if (fromDate != null && !picked.isBefore(fromDate!)) {
          toDate = picked;
        }
      }
      notifyListeners();
    }
  }

  void clearForm() {
    titleController.clear();
    roleController.clear();
    descriptionController.clear();
    projectUrlController.clear();
    selectedAssociation = null;
    fromDate = null;
    toDate = null;
    currentlyWorking = false;
    notifyListeners();
  }

  void setSelectedAssociation(String? value) {
    selectedAssociation = value;
    notifyListeners();
  }

  void addProject({
    required String title,
    required String role,
    required String startDate,
    required String endDate,
  }) {
    projects.add({
      'title': title,
      'role': role,
      'startDate': startDate,
      'endDate': endDate,
    });
    isProjectsSectionCompleted = true;
    notifyListeners();
  }

  void setSectionStatus(String section, bool status) {
    if (section == 'Projects') {
      isProjectsSectionCompleted = status;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    roleController.dispose();
    descriptionController.dispose();
    projectUrlController.dispose();
    titleFocusNode.dispose();
    roleFocusNode.dispose();
    descriptionFocusNode.dispose();
    projectUrlFocusNode.dispose();
    super.dispose();
  }

  void resetForm() {
    titleController.clear();
    roleController.clear();
    descriptionController.clear();
    projectUrlController.clear();
    selectedAssociation = null;
    fromDate = null;
    toDate = null;
    currentlyWorking = false;
    notifyListeners();
  }

  void initializeWithData({
    required String title,
    String? role,
    String? description,
    String? projectUrl,
    String? association,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentProject,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    titleController.text = title;
    if (role != null) roleController.text = role;
    if (description != null) descriptionController.text = description;
    if (projectUrl != null) projectUrlController.text = projectUrl;
    if (association != null && associationOptions.contains(association)) {
      selectedAssociation = association;
    }

    // Initialize dates
    fromDate = startDate;
    toDate = endDate;
    currentlyWorking = isCurrentProject ?? false;

    notifyListeners();
  }
}
