import 'package:flutter/material.dart';

class VolunteeringProvider extends ChangeNotifier {
  /// **Title**
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();

  /// **Organization**
  TextEditingController organizationController = TextEditingController();
  FocusNode organizationFocusNode = FocusNode();
  TextEditingController linkController = TextEditingController();
  FocusNode linkFocusNode = FocusNode();

  /// **Role (Optional)**
  TextEditingController roleController = TextEditingController();
  FocusNode roleFocusNode = FocusNode();

  /// **Description**
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  /// **Organization Website (Optional)**
  TextEditingController websiteController = TextEditingController();
  FocusNode websiteFocusNode = FocusNode();

  /// **Date Selection**
  DateTime? fromDate;
  DateTime? toDate;

  /// Track which volunteering entry is being edited
  int? editingIndex;

  Future<void> pickDate(BuildContext context, bool isFromDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(1900),
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

  void resetForm() {
    titleController.clear();
    organizationController.clear();
    roleController.clear();
    descriptionController.clear();
    websiteController.clear();
    linkController.clear();
    fromDate = null;
    toDate = null;
    currentlyWorking = false;
    editingIndex = null;
    notifyListeners();
  }

  void initializeWithData({
    required String title,
    required String organization,
    String? role,
    String? description,
    String? website,
    String? link,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    titleController.text = title;
    organizationController.text = organization;
    if (role != null) roleController.text = role;
    if (description != null) descriptionController.text = description;
    if (website != null) websiteController.text = website;
    if (link != null) linkController.text = link;

    // Initialize dates
    fromDate = startDate;
    toDate = endDate;
    currentlyWorking = isCurrentlyWorking ?? false;

    // Set editing index
    editingIndex = index;

    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose all controllers
    titleController.dispose();
    organizationController.dispose();
    roleController.dispose();
    descriptionController.dispose();
    websiteController.dispose();
    linkController.dispose();

    // Dispose all focus nodes
    titleFocusNode.dispose();
    organizationFocusNode.dispose();
    roleFocusNode.dispose();
    descriptionFocusNode.dispose();
    websiteFocusNode.dispose();
    linkFocusNode.dispose();

    super.dispose();
  }
}
