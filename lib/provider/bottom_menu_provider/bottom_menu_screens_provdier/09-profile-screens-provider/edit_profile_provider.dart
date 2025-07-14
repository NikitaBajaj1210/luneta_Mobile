import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditProvider with ChangeNotifier {
  File? _profileImage;
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode middleNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String _currentPosition = "UI/UX Designer at Paypal Inc.";

  File? get profileImage => _profileImage;
  String get currentPosition => _currentPosition;

  final List<String> _positions = [
    "UI/UX Designer at Paypal Inc.",
    "Software Engineer at Google",
    "Product Manager at Microsoft",
    "Data Scientist at Amazon"
  ];

  List<String> get positions => _positions;

  void pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setCurrentPosition(String position) {
    _currentPosition = position;
    notifyListeners();
  }
}
