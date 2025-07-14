import 'package:flutter/material.dart';

class SeminarsTrainingsProvider extends ChangeNotifier {
  /// **Topic**
  final TextEditingController _topicController = TextEditingController();
  final FocusNode _topicFocusNode = FocusNode();

  /// **Organizer**
  final TextEditingController _organizerController = TextEditingController();
  final FocusNode _organizerFocusNode = FocusNode();

  /// **Description**
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  /// **Date Selection**
  DateTime? _fromDate;
  DateTime? _toDate;

  /// **Current (Toggle)**
  bool _currentlyOngoing = false;

  /// **📌 Getters**
  TextEditingController get topicController => _topicController;
  FocusNode get topicFocusNode => _topicFocusNode;

  TextEditingController get organizerController => _organizerController;
  FocusNode get organizerFocusNode => _organizerFocusNode;

  TextEditingController get descriptionController => _descriptionController;
  FocusNode get descriptionFocusNode => _descriptionFocusNode;

  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  bool get currentlyOngoing => _currentlyOngoing;

  /// **📌 Setter for `currentlyOngoing`**
  set currentlyOngoing(bool value) {
    _currentlyOngoing = value;
    if (value) {
      _toDate = null; // Disable "To" date when "Current" is ON
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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      if (isFromDate) {
        setFromDate(picked);
      } else if (!_currentlyOngoing) {
        setToDate(picked);
      }
    }
  }

  /// **📌 Dispose Controllers & FocusNodes**
  @override
  void dispose() {
    _topicController.dispose();
    _topicFocusNode.dispose();
    _organizerController.dispose();
    _organizerFocusNode.dispose();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void resetForm() {
    _topicController.clear();
    _organizerController.clear();
    _descriptionController.clear();
    _fromDate = null;
    _toDate = null;
    _currentlyOngoing = false;
    notifyListeners();
  }

  void initializeWithData({
    required String topic,
    required String organizer,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyOngoing,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    _topicController.text = topic;
    _organizerController.text = organizer;
    if (description != null) _descriptionController.text = description;

    // Initialize dates
    _fromDate = startDate;
    _toDate = endDate;
    _currentlyOngoing = isCurrentlyOngoing ?? false;

    notifyListeners();
  }
}
