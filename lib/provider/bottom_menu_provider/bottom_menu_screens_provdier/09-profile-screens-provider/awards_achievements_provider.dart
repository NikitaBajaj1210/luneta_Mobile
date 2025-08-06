import 'package:flutter/material.dart';

class AwardsAchievementsProvider extends ChangeNotifier {
  /// **Title**
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();

  /// **Issuer**
  TextEditingController issuerController = TextEditingController();
  FocusNode issuerFocusNode = FocusNode();

  /// **Description**
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  /// **Date Awarded**
  DateTime? dateAwarded;

  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateAwarded ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateAwarded = picked;
      notifyListeners();
    }
  }

  void resetForm() {
    titleController.clear();
    issuerController.clear();
    descriptionController.clear();
    dateAwarded = null;
    notifyListeners();
  }

  void initializeWithData({
    required String title,
    required String issuer,
    String? description,
    DateTime? dateAwarded,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    titleController.text = title;
    issuerController.text = issuer;
    if (description != null) descriptionController.text = description;

    // Initialize date
    this.dateAwarded = dateAwarded;

    notifyListeners();
  }
}
