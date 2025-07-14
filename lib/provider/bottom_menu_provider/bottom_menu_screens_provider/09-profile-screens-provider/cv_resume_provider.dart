import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CVResumeProvider with ChangeNotifier {
  // File selection properties
  File? selectedFile;
  String? fileName;
  String fileSize = "0";
  bool isUploading = false; // Track upload state

  // Function to pick PDF file
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

  // Function to remove selected file
  void removeFile() {
    selectedFile = null;
    fileName = null;
    fileSize = "0";
    notifyListeners();
  }

  // Getter for file data
  String get fileInfo => "$fileName ($fileSize)";
}
