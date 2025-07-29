import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:io';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../network/network_helper.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/seafarer_profile_model.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';

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

  String _formatPhoneNumber() {
    if (phoneNumber.phoneNumber != null && phoneNumber.phoneNumber!.isNotEmpty) {
      // Get the country code based on isoCode
      String countryCode = '';
      switch (phoneNumber.isoCode) {
        case 'IN': countryCode = '+91'; break;
        case 'US': countryCode = '+1'; break;
        case 'GB': countryCode = '+44'; break;
        case 'FR': countryCode = '+33'; break;
        case 'DE': countryCode = '+49'; break;
        default: countryCode = '+1'; // Default to US
      }
      return '$countryCode ${phoneNumber.phoneNumber}';
    }
    // If no phone number is set, return empty string instead of controller text
    return '';
  }

  String _formatDateForAPI() {
    if (addDateApi.isNotEmpty) {
      try {
        // Parse the date from addDateApi format (YYYY-MM-DD)
        List<String> dateParts = addDateApi.split('-');
        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);
          
          // Create DateTime and format as ISO 8601 with proper padding
          DateTime date = DateTime(year, month, day);
          String formattedDate = '${date.year.toString().padLeft(4, '0')}-'
              '${date.month.toString().padLeft(2, '0')}-'
              '${date.day.toString().padLeft(2, '0')}';
          return formattedDate;
        }
      } catch (e) {
        print('Error formatting date: $e');
      }
    }
    // Return current date if no date is set
    DateTime now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  // Future<void> fetchSeafarerProfile(BuildContext context, bool showLoading) async {
  //   try {
  //     Map<String, dynamic> response = await NetworkService().getResponse(
  //       seafarerProfileBasicInfo,
  //       showLoading,
  //       context,
  //       () => notifyListeners(),
  //     );
  //
  //     print("Fetch Seafarer Profile Response: $response");
  //
  //     if (response['statusCode'] == 200) {
  //       SeafarerProfileResponse profileResponse = SeafarerProfileResponse.fromJson(response);
  //       SeafarerProfileData? profileData = profileResponse.data;
  //
  //       if (profileData != null) {
  //         // Populate form with existing data
  //         nameController.text = profileData.firstName ?? '';
  //         nickNameController.text = profileData.lastName ?? '';
  //         emailController.text = profileData.contactEmail ?? '';
  //
  //         if (profileData.dateOfBirth != null) {
  //           addDateApi = profileData.dateOfBirth!;
  //           // Convert API date format to display format
  //           List<String> dateParts = profileData.dateOfBirth!.split('-');
  //           if (dateParts.length == 3) {
  //             addDate = '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
  //           }
  //         }
  //
  //         if (profileData.mobilePhone != null) {
  //           // Parse the phone number properly
  //           String phoneText = profileData.mobilePhone!;
  //           String countryCode = 'US'; // Default
  //           String phoneNumberOnly = phoneText;
  //
  //           // Extract country code and phone number
  //           if (phoneText.startsWith('+91')) {
  //             countryCode = 'IN';
  //             phoneNumberOnly = phoneText.substring(3);
  //           } else if (phoneText.startsWith('+1')) {
  //             countryCode = 'US';
  //             phoneNumberOnly = phoneText.substring(2);
  //           } else if (phoneText.startsWith('+')) {
  //             // For other country codes, extract the code
  //             int plusIndex = phoneText.indexOf('+');
  //             int spaceIndex = phoneText.indexOf(' ');
  //             if (spaceIndex > plusIndex) {
  //               String code = phoneText.substring(plusIndex + 1, spaceIndex);
  //               phoneNumberOnly = phoneText.substring(spaceIndex + 1);
  //               // Map common country codes
  //               switch (code) {
  //                 case '44': countryCode = 'GB'; break;
  //                 case '33': countryCode = 'FR'; break;
  //                 case '49': countryCode = 'DE'; break;
  //                 default: countryCode = 'US';
  //               }
  //             }
  //           }
  //
  //           phoneNumber = PhoneNumber(
  //             phoneNumber: phoneNumberOnly,
  //             isoCode: countryCode,
  //           );
  //           phoneController.text = phoneNumberOnly;
  //         }
  //
  //         if (profileData.sex != null) {
  //           selectedGender = profileData.sex!;
  //         }
  //
  //         notifyListeners();
  //       }
  //     }
  //   } catch (e) {
  //     print("Fetch Seafarer Profile Error: $e");
  //   }
  // }

  Future<void> updateSeafarerProfile(BuildContext context, bool showLoading) async {
    try {
      // Prepare request body according to API specification
      Map<String, dynamic> requestBody = {
        "userId": "1313bb60-0cd4-4586-bae8-773ca4e17cbc", // This should come from user session
        "currentCountry": "India", // This should come from country selection
        "firstName": nameController.text.trim(),
        "lastName": nickNameController.text.trim(),
        "dateOfBirth": _formatDateForAPI(),
        "contactEmail": emailController.text.trim(),
        "mobilePhone": _formatPhoneNumber(),
        "sex": selectedGender == 'Gender' ? null : selectedGender,
      };

      print("Seafarer Profile Request Body: $requestBody");

      Map<String, dynamic> response = await NetworkService().postResponse(
        seafarerProfileBasicInfo,
        jsonEncode(requestBody),
        showLoading,
        context,
        () => notifyListeners(),
      );

      print("Seafarer Profile Response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Profile update successful
        SeafarerProfileResponse profileResponse = SeafarerProfileResponse.fromJson(response);
        
        // Show success message
        ShowToast("Success", profileResponse.message ?? "Profile updated successfully");
        
        // Navigate to next screen
        if (context.mounted) {
          Navigator.of(context).pushNamed(createPin);
          resetForm();
        }
      }
    } catch (e) {
      print("Seafarer Profile Update Error: $e");
      ShowToast("Error", "Something went wrong during profile update");
    }
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