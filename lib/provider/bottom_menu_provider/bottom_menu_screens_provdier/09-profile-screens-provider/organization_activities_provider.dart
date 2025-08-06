import 'package:flutter/material.dart';

class OrganizationActivitiesProvider extends ChangeNotifier {
  /// **Organization**
  final TextEditingController _organizationController = TextEditingController();
  final FocusNode _organizationFocusNode = FocusNode();

  /// **Role**
  final TextEditingController _roleController = TextEditingController();
  final FocusNode _roleFocusNode = FocusNode();

  /// **Description**
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  /// **Date Selection**
  DateTime? _fromDate;
  DateTime? _toDate;

  /// **Still a Member (Checkbox)**
  bool _stillMember = false;

  /// **📌 Getters**
  TextEditingController get organizationController => _organizationController;
  FocusNode get organizationFocusNode => _organizationFocusNode;

  TextEditingController get roleController => _roleController;
  FocusNode get roleFocusNode => _roleFocusNode;

  TextEditingController get descriptionController => _descriptionController;
  FocusNode get descriptionFocusNode => _descriptionFocusNode;

  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  bool get stillMember => _stillMember;

  /// **📌 Setter for `stillMember`**
  set stillMember(bool value) {
    _stillMember = value;
    if (value) {
      _toDate = null; // Disable "To" date if "Still a member" is checked
    }
    notifyListeners();
  }

  /// **📌 Setters for Dates**
  void setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

  /// **📌 Date Picker Function**
  Future<void> pickDate(BuildContext context, bool isFromDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate ?? DateTime.now() : _toDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      if (isFromDate) {
        setFromDate(picked);
      } else if (!_stillMember) {
        setToDate(picked);
      }
    }
  }

  /// **📌 Dispose Controllers & FocusNodes**
  @override
  void dispose() {
    _organizationController.dispose();
    _organizationFocusNode.dispose();
    _roleController.dispose();
    _roleFocusNode.dispose();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void resetForm() {
    _organizationController.clear();
    _roleController.clear();
    _descriptionController.clear();
    _fromDate = null;
    _toDate = null;
    _stillMember = false;
    notifyListeners();
  }

  void initializeWithData({
    required String organization,
    required String role,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isStillMember,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    _organizationController.text = organization;
    _roleController.text = role;
    if (description != null) _descriptionController.text = description;

    // Initialize dates
    _fromDate = startDate;
    _toDate = endDate;
    _stillMember = isStillMember ?? false;

    notifyListeners();
  }
}
