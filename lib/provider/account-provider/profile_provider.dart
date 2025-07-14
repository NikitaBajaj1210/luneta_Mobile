import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:io';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';

class ProfileProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool hasSubmitted = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode nickNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();

  String? nameError;
  String? nickNameError;
  String? emailError;
  String? phoneError;
  String? dateError;
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');
  String addDate = 'Date of Birth';
  String addDateApi = '';
  String selectedGender = 'Gender';
  bool isShowDateError = false; // Keep for manual check, but we'll also use dateError
  String? genderError;
  File? profileImage;

  ProfileProvider() {
    nameController.addListener(() {
      if (hasSubmitted) {
        validateFieldIfFocused('name', nameController.text);
      }
      notifyListeners();
    });
    nickNameController.addListener(() {
      if (hasSubmitted) {
        validateFieldIfFocused('nickname', nickNameController.text);
      }
      notifyListeners();
    });
    emailController.addListener(() {
      if (hasSubmitted) {
        validateFieldIfFocused('email', emailController.text);
      }
      notifyListeners();
    });
    phoneController.addListener(() {
      if (hasSubmitted) {
        validateFieldIfFocused('phone', phoneController.text);
      }
      notifyListeners();
    });
  }

  String? validateFieldSilently(String fieldName, String value) {
    String? error;
    switch (fieldName) {
      case 'name':
        error = validateName(value.trim());
        break;
      case 'nickname':
        error = validateName(value.trim());
        break;
      case 'email':
        error = validateEmail(value.trim());
        break;
      case 'phone':
        error = validateMobile(value.trim());
        break;
      case 'date':
        error = (value.isEmpty || value == 'Date of Birth') ? 'Date of birth is required' : null;
        break;
      default:
        error = null;
    }
    return error;
  }

  String? validateFieldIfFocused(String fieldName, String value, {bool notify = true}) {
    String? error;
    if (!hasSubmitted) return null;

    switch (fieldName) {
      case 'name':
        error = validateName(value.trim());
        nameError = error;
        break;
      case 'nickname':
        error = validateName(value.trim());
        nickNameError = error;
        break;
      case 'email':
        error = validateEmail(value.trim());
        emailError = error;
        break;
      case 'phone':
        error = validateMobile(value.trim());
        phoneError = error;
        break;
      case 'date':
        error = (value.isEmpty || value == 'Date of Birth') ? 'Date of birth is required' : null;
        dateError = error;
        break;
      default:
        error = null;
    }
    if (notify) {
      notifyListeners();
    }
    return error;
  }

  void validatePhone({bool notify = true}) {
    if (!hasSubmitted) return;
    phoneError = validateMobile(phoneController.text.trim());
    if (notify) {
      notifyListeners();
    }
  }

  String? validateGender(String value, {bool notify = true}) {
    if (!hasSubmitted) return null;
    genderError = value == 'Gender' ? 'Please select a gender' : null;
    if (notify) {
      notifyListeners();
    }
    return genderError;
  }

  void validateAllFields(BuildContext context) {
    hasSubmitted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      validateFieldIfFocused('name', nameController.text);
      validateFieldIfFocused('nickname', nickNameController.text);
      validateFieldIfFocused('email', emailController.text);
      validateFieldIfFocused('phone', phoneController.text);
      validateFieldIfFocused('date', addDate);
      validateGender(selectedGender);
      notifyListeners();
    });
  }

  bool validateFields() {
    return validateFieldSilently('name', nameController.text) == null &&
        validateFieldSilently('nickname', nickNameController.text) == null &&
        validateFieldSilently('email', emailController.text) == null &&
        validateFieldSilently('phone', phoneController.text) == null &&
        validateFieldSilently('date', addDate) == null &&
        (selectedGender != 'Gender');
  }

  void markFieldAsSubmitted(String fieldName) {
    if (!hasSubmitted) return;
    notifyListeners();
  }

  Color getFieldBorderColor(FocusNode focusNode, String fieldName) {
    return focusNode.hasFocus ? AppColors.buttonColor : Colors.transparent;
  }

  Color getFieldTextColor(String fieldName, {bool hasValue = false}) {
    return hasValue ? AppColors.Color_212121 : AppColors.Color_9E9E9E;
  }

  Color getFieldIconColor(FocusNode focusNode, String fieldName, {bool hasValue = false}) {
    return focusNode.hasFocus || hasValue ? AppColors.Color_212121 : AppColors.Color_9E9E9E;
  }

  void resetForm() {
    nameController.clear();
    nickNameController.clear();
    emailController.clear();
    phoneController.clear();
    addDate = 'Date of Birth';
    addDateApi = '';
    selectedGender = 'Gender';
    nameError = null;
    nickNameError = null;
    emailError = null;
    phoneError = null;
    dateError = null;
    genderError = null;
    isShowDateError = false;
    autoValidateMode = AutovalidateMode.disabled;
    hasSubmitted = false;
    profileImage = null;
    notifyListeners();
  }

  void showImageSourceBottomSheet(BuildContext context) {
    // Placeholder for image selection logic
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    nickNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}