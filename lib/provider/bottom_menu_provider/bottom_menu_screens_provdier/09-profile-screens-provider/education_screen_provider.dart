import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EducationScreenProvider extends ChangeNotifier {
  // Course field
  TextEditingController courseController = TextEditingController();
  FocusNode courseFocusNode = FocusNode();

  // School field
  TextEditingController schoolController = TextEditingController();
  FocusNode schoolFocusNode = FocusNode();

  // GPA field
  TextEditingController gpaController = TextEditingController();
  FocusNode gpaFocusNode = FocusNode();

  // Description field
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  String selectedEmploymentType = "Full Time";
  List<String> employmentTypes = ["Full Time", "Part Time", "Freelance", "Internship"];

  String selectedJobLevel = "Associate / Supervisor";
  List<String> jobLevels = ["Entry Level", "Associate / Supervisor", "Manager", "Senior Manager", "Director"];

  String selectedJobFunction = "IT and Software";
  List<String> jobFunctions = ["IT and Software", "Marketing", "Finance", "Engineering", "Healthcare"];

  String selectedCurrency = "USD";
  List<String> currencies = ["USD", "EUR", "GBP", "INR"];

  String selectedDegree = "Bachelor's Degree";
  List<String> degrees = [
    "High School",
    "Associate's Degree",
    "Bachelor's Degree",
    "Master's Degree",
    "Doctorate",
    "Vocational",
    "Other"
  ];

  String selectedScale = "4.0";
  List<String> scale = ["1.0", "2.0", "3.0", "4.0"];

  DateTime? fromDate;
  DateTime? toDate;
  bool currentlyWorking = false;
  File? selectedFile;
  String? fileName;
  String fileSize= "0";
  bool isUploading = false; // Track upload state

  void setEmploymentType(String newValue) {
    selectedEmploymentType = newValue;
    notifyListeners();
  }

  void setJobLevel(String newValue) {
    selectedJobLevel = newValue;
    notifyListeners();
  }

  void setJobFunction(String newValue) {
    selectedJobFunction = newValue;
    notifyListeners();
  }

  void setCurrency(String newValue) {
    selectedCurrency = newValue;
    notifyListeners();
  }

  void setDegree(String newValue) {
    selectedDegree = newValue;
    notifyListeners();
  }

  void setScale(String newValue) {
    selectedScale = newValue;
    notifyListeners();
  }

  void toggleCurrentlyWorking(bool value) {
    currentlyWorking = value;
    if (value) {
      toDate = null; // Disable "To" date
    }
    notifyListeners();
  }

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
      } else if (!currentlyWorking) {
        toDate = picked;
      }
      notifyListeners();
    }
  }

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      selectedFile = File(result.files.single.path!);
      fileName = result.files.single.name;
      fileSize = "${(result.files.single.size / 1024).toStringAsFixed(2)} KB"; // Calculate file size
      isUploading = true; // Set uploading state
      notifyListeners();

      // Simulate upload delay
      await Future.delayed(Duration(seconds: 2));

      isUploading = false; // Upload completed
      notifyListeners();
    }
  }

  void removeFile() {
    selectedFile = null;
    fileName = null;
    fileSize = "0";
    notifyListeners();
  }

  // Track which education entry is being edited
  int? editingIndex;

  void resetForm() {
    courseController.clear();
    schoolController.clear();
    gpaController.clear();
    descriptionController.clear();
    selectedDegree = "Bachelor's Degree";
    selectedScale = "4.0";
    fromDate = null;
    toDate = null;
    currentlyWorking = false;
    selectedFile = null;
    fileName = null;
    fileSize = "0";
    editingIndex = null;
    notifyListeners();
  }

  void initializeWithData({
    required String school,
    required String course,
    String? gpa,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyEnrolled,
    String? degree,
    String? scale,
    int? index,
  }) {
    // Reset form first
    resetForm();

    // Initialize form fields
    schoolController.text = school;
    courseController.text = course;
    if (gpa != null) gpaController.text = gpa;
    if (description != null) descriptionController.text = description;
    if (degree != null && degrees.contains(degree)) selectedDegree = degree;
    if (scale != null && this.scale.contains(scale)) selectedScale = scale;

    // Initialize dates
    fromDate = startDate;
    toDate = endDate;
    currentlyWorking = isCurrentlyEnrolled ?? false;

    // Set editing index
    editingIndex = index;

    notifyListeners();
  }
}
