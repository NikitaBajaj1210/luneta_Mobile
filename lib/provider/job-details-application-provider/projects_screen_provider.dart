import 'package:flutter/material.dart';

class ProjectsScreenProvider extends ChangeNotifier {
  /// **Project Name**
  TextEditingController projectNameController = TextEditingController();
  FocusNode projectNameFocusNode = FocusNode();

  /// **Role**
  TextEditingController roleController = TextEditingController();
  FocusNode roleFocusNode = FocusNode();

  /// **Description**
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  /// **Project URL**
  TextEditingController projectUrlController = TextEditingController();
  FocusNode projectUrlFocusNode = FocusNode();

  /// **Associated With (Dropdown)**
  String selectedAssociation = "Associated with";
  List<String> associations = ["Associated with", "Company A", "Company B", "Freelance"];

  void setAssociation(String newValue) {
    selectedAssociation = newValue;
    notifyListeners();
  }

  /// **Date Selection**
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> pickDate(BuildContext context, bool isFromDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      if (isFromDate) {
        fromDate = picked;
      } else {
        toDate = picked;
      }
      notifyListeners();
    }
  }

  /// **Current (Toggle)**
  bool currentlyWorking = false;
  void toggleCurrentlyWorking(bool value) {
    currentlyWorking = value;
    if (value) {
      toDate = null; // Disable "To" date if "Current" is toggled ON
    }
    notifyListeners();
  }
}
