import 'package:flutter/material.dart';

class CertificationProvider extends ChangeNotifier {
  /// **Title**
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();

  /// **Publishing Organization**
  TextEditingController organizationController = TextEditingController();
  FocusNode organizationFocusNode = FocusNode();

  /// **Credential ID**
  TextEditingController credentialIdController = TextEditingController();
  FocusNode credentialIdFocusNode = FocusNode();

  /// **Credential URL**
  TextEditingController credentialUrlController = TextEditingController();
  FocusNode credentialUrlFocusNode = FocusNode();

  /// **Date Selection**
  DateTime? issueDate;
  DateTime? expirationDate;

  /// **Toggle Expiration Date Checkbox**
  bool _noExpiry = false;

  /// **Getter for No Expiry**
  bool get noExpiry => _noExpiry;

  /// **Setter for No Expiry (Toggles Checkbox State)**
  void toggleNoExpiry() {
    _noExpiry = !_noExpiry;
    if (_noExpiry) {
      expirationDate = null;  // Clear expiration date when setting no expiry
    }
    notifyListeners();
  }

  /// **Date Picker Function**
  Future<void> pickDate(BuildContext context, bool isIssueDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isIssueDate 
          ? (issueDate ?? DateTime.now())
          : (expirationDate ?? issueDate?.add(Duration(days: 1)) ?? DateTime.now().add(Duration(days: 1))),
      firstDate: isIssueDate ? DateTime(1900) : (issueDate?.add(Duration(days: 1)) ?? DateTime(1900)),
      lastDate: isIssueDate ? DateTime.now() : DateTime(2100),
    );

    if (picked != null) {
      if (isIssueDate) {
        issueDate = picked;
        // If issue date is after expiration date, clear expiration date
        if (expirationDate != null && picked.isAfter(expirationDate!)) {
          expirationDate = null;
        }
      } else if (issueDate != null) {  // Only set expiration if we have issue date
        expirationDate = picked;
        _noExpiry = false;  // Uncheck no expiry when setting expiration date
      }
      notifyListeners();
    }
  }

  // Track which certification entry is being edited
  int? editingIndex;

  void resetForm() {
    titleController.clear();
    organizationController.clear();
    credentialIdController.clear();
    credentialUrlController.clear();
    issueDate = null;
    expirationDate = null;
    _noExpiry = false;
    editingIndex = null;
    notifyListeners();
  }

  void initializeWithData({
    required String title,
    required String organization,
    DateTime? issueDate,
    DateTime? expirationDate,
    bool? noExpiry,
    String? credentialId,
    String? credentialUrl,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    titleController.text = title;
    organizationController.text = organization;
    if (credentialId != null) credentialIdController.text = credentialId;
    if (credentialUrl != null) credentialUrlController.text = credentialUrl;

    // Initialize dates
    this.issueDate = issueDate;
    this.expirationDate = expirationDate;
    _noExpiry = noExpiry ?? false;

    // Set editing index
    editingIndex = index;

    notifyListeners();
  }
}
