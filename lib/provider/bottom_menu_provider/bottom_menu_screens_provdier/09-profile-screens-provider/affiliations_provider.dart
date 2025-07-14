import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AffiliationsProvider extends ChangeNotifier {
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // FocusNodes for text fields
  final FocusNode _organizationFocusNode = FocusNode();
  final FocusNode _roleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  DateTime? _fromDate;
  DateTime? _toDate;
  bool _isCurrent = false;

  // Getters
  TextEditingController get organizationController => _organizationController;
  TextEditingController get roleController => _roleController;
  TextEditingController get descriptionController => _descriptionController;
  
  FocusNode get organizationFocusNode => _organizationFocusNode;
  FocusNode get roleFocusNode => _roleFocusNode;
  FocusNode get descriptionFocusNode => _descriptionFocusNode;

  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  bool get isCurrent => _isCurrent;

  set isCurrent(bool value) {
    _isCurrent = value;
    if (value) {
      _toDate = null;
    }
    notifyListeners();
  }

  void setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

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
      } else if (!_isCurrent) {
        setToDate(picked);
      }
    }
  }

  void resetForm() {
    _organizationController.clear();
    _roleController.clear();
    _descriptionController.clear();
    _fromDate = null;
    _toDate = null;
    _isCurrent = false;
    notifyListeners();
  }

  void initializeWithData(Map<String, dynamic> affiliation) {
    print(affiliation);
    _organizationController.text = affiliation["organization"] ?? '';
    _roleController.text = affiliation["role"] ?? '';
    _descriptionController.text = affiliation["description"] ?? '';

    // Parse display date
    if (affiliation["displayDate"] != null) {
      try {
        List<String> parts = affiliation["displayDate"].split(' · ');
        if (parts.isNotEmpty) {
          List<String> dates = parts[0].split(' - ');
          if (dates.length == 2) {
            _fromDate = DateFormat('MMM yyyy').parse(dates[0].trim());
            if (dates[1].trim() == 'Present') {
              _isCurrent = true;
              _toDate = null;
            } else {
              _toDate = DateFormat('MMM yyyy').parse(dates[1].trim());
              _isCurrent = false;
            }
          }
        }
      } catch (e) {
        print('Error parsing dates: $e');
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _organizationController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    _organizationFocusNode.dispose();
    _roleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
