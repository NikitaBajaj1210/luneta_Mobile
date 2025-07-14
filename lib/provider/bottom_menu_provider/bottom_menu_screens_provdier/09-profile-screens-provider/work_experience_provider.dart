import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class WorkExperienceProvider extends ChangeNotifier {
  TextEditingController jobTitleController = TextEditingController();
  FocusNode jobTitleFocusNode = FocusNode();

  TextEditingController companyController = TextEditingController();
  FocusNode companyFocusNode = FocusNode();

  TextEditingController salaryController = TextEditingController();
  FocusNode salaryFocusNode = FocusNode();

  TextEditingController locationController = TextEditingController(text: "California, United States");
  FocusNode locationFocusNode = FocusNode();

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

  String selectedFrequency = "per month";
  List<String> frequencies = ["per hour", "per day", "per month", "per year"];

  DateTime? fromDate;
  DateTime? toDate;
  bool currentlyWorking = false;
  File? selectedFile;
  String? fileName;
  String fileSize= "0";
  bool isUploading = false; // Track upload state

  int? editingIndex;
  bool get isEditing => editingIndex != null;

  bool _mounted = true;
  bool get mounted => _mounted;

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

  void setFrequency(String newValue) {
    selectedFrequency = newValue;
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
    try {
      isUploading = true;
      notifyListeners();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      // Check if the provider is still mounted before proceeding
      if (!mounted) return;

      if (result != null && result.files.isNotEmpty) {
        selectedFile = File(result.files.first.path!);
        fileName = result.files.first.name;
        fileSize = (result.files.first.size / 1024).toStringAsFixed(2) + " KB";
      }

      isUploading = false;
      if (mounted) notifyListeners();
    } catch (e) {
      print('Error picking PDF file: $e');
      isUploading = false;
      if (mounted) notifyListeners();
    }
  }

  void removeFile() {
    selectedFile = null;
    fileName = null;
    fileSize = "0";
    notifyListeners();
  }

  void resetForm() {
    jobTitleController.clear();
    companyController.clear();
    locationController.text = "California, United States";
    descriptionController.clear();
    salaryController.clear();
    selectedEmploymentType = "Full Time";
    selectedJobLevel = "Associate / Supervisor";
    selectedJobFunction = "IT and Software";
    selectedCurrency = "USD";
    selectedFrequency = "per month";
    fromDate = null;
    toDate = null;
    currentlyWorking = false;
    selectedFile = null;
    fileName = null;
    fileSize = "0";
    isUploading = false;
    editingIndex = null;
    notifyListeners();
  }

  void setFormData({
    required String title,
    required String company,
    String? location,
    String? description,
    String? employmentType,
    String? jobLevel,
    String? jobFunction,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    int? index,
  }) {
    jobTitleController.text = title;
    companyController.text = company;
    locationController.text = location ?? "California, United States";
    descriptionController.text = description ?? '';
    
    if (employmentType != null && employmentTypes.contains(employmentType)) {
      selectedEmploymentType = employmentType;
    }
    
    if (jobLevel != null && jobLevels.contains(jobLevel)) {
      selectedJobLevel = jobLevel;
    }
    
    if (jobFunction != null && jobFunctions.contains(jobFunction)) {
      selectedJobFunction = jobFunction;
    }
    
    fromDate = startDate;
    toDate = endDate;
    currentlyWorking = isCurrentlyWorking ?? false;
    editingIndex = index;
    
    notifyListeners();
  }

  void initializeWithData({
    required String title,
    required String company,
    String? location,
    String? description,
    String? employmentType,
    String? jobLevel,
    String? jobFunction,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    int? index,
  }) {
    resetForm();
    
    jobTitleController.text = title;
    companyController.text = company;
    locationController.text = location ?? "California, United States";
    descriptionController.text = description ?? '';
    
    if (employmentType != null && employmentTypes.contains(employmentType)) {
      selectedEmploymentType = employmentType;
    }
    
    if (jobLevel != null && jobLevels.contains(jobLevel)) {
      selectedJobLevel = jobLevel;
    }
    
    if (jobFunction != null && jobFunctions.contains(jobFunction)) {
      selectedJobFunction = jobFunction;
    }
    
    fromDate = startDate;
    toDate = endDate;
    currentlyWorking = isCurrentlyWorking ?? false;
    editingIndex = index;
    
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    jobTitleController.dispose();
    companyController.dispose();
    salaryController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    jobTitleFocusNode.dispose();
    companyFocusNode.dispose();
    salaryFocusNode.dispose();
    locationFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}
