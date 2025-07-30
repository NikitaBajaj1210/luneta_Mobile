import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:luneta/provider/account-provider/choose_rank_provider.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/globalComponent.dart';
import '../../models/auth_model/login_model.dart';
import '../../models/country_model.dart';
import '../../network/network_helper.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/seafarer_profile_model.dart';
import '../../models/rank_model.dart'; // Import for GetAllRankModel and Data
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../authentication-provider/login_provider.dart';
import 'choose_country_provider.dart';


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
  FocusNode rankFocusNode = FocusNode(); // Added for rank dropdown

  String? nameError;
  String? nickNameError;
  String? emailError;
  String? phoneError;
  String? dateError;
  String? genderError;
  String? rankError; // Added for rank validation
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');
  String addDate = 'Date of Birth';
  String addDateApi = '';
  String selectedGender = 'Gender';
  String selectedCountry = 'India'; // Default country, will be updated from Country Screen
  String selectedCountryCode = 'IN'; // Default country code
  bool isShowDateError = false;
  File? profileImage;
  List<Data> _ranks = []; // Added ranks list

  // Getter for ranks list
  List<Data> get ranks => _ranks;

  // Setter for ranks list
  set ranks(List<Data>? newRanks) {
    _ranks = newRanks ?? [];
    notifyListeners();
  }

  ProfileProvider() {
    // Remove controller listeners to prevent keyboard conflicts
    // nameController.addListener(() {
    //   if (hasSubmitted) {
    //     validateFieldIfFocused('name', nameController.text);
    //   }
    //   notifyListeners();
    // });
    // nickNameController.addListener(() {
    //   if (hasSubmitted) {
    //     validateFieldIfFocused('nickname', nickNameController.text);
    //   }
    //   notifyListeners();
    // });
    // emailController.addListener(() {
    //   if (hasSubmitted) {
    //     validateFieldIfFocused('email', emailController.text);
    //   }
    //   notifyListeners();
    // });
    // phoneController.addListener(() {
    //   if (hasSubmitted) {
    //     validateFieldIfFocused('phone', phoneController.text);
    //   }
    //   notifyListeners();
    // });
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
        error = (value.isEmpty || value == 'Date of Birth')
            ? 'Date of birth is required'
            : null;
        break;
      case 'rank':
        error =
        (value.isEmpty || value == 'Select Rank') ? 'Rank is required' : null;
        break;
      default:
        error = null;
    }
    return error;
  }

  String? validateFieldIfFocused(String fieldName, String value,
      {bool notify = true}) {
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
        error = (value.isEmpty || value == 'Date of Birth')
            ? 'Date of birth is required'
            : null;
        dateError = error;
        break;
      case 'rank':
        error =
        (value.isEmpty || value == 'Select Rank') ? 'Rank is required' : null;
        rankError = error;
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
        selectedGender != 'Gender';
  }

  void markFieldAsSubmitted(String fieldName) {
    if (!hasSubmitted) return;
    notifyListeners();
  }

  // Add a safe method to handle text changes
  void handleTextChange(String fieldName, String value) {
    // Only validate if form has been submitted and value is not empty
    if (hasSubmitted && value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
    }
    // Always notify listeners to update UI
    notifyListeners();
  }

  // Add a safe method to handle phone number changes
  void handlePhoneChange(PhoneNumber newNumber, String phoneText) {
    phoneNumber = newNumber;
    if (hasSubmitted && phoneText.isNotEmpty) {
      validateFieldIfFocused('phone', phoneText);
    }
    notifyListeners();
  }

  // Add a safe method to handle focus changes
  void handleFocusChange(String fieldName, bool hasFocus, String value) {
    // Only validate when losing focus and form has been submitted
    if (!hasFocus && hasSubmitted && value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
    }
    notifyListeners();
  }

  // Add a method to safely unfocus all fields
  void unfocusAllFields() {
    nameFocusNode.unfocus();
    nickNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phoneFocusNode.unfocus();
    dateFocusNode.unfocus();
    genderFocusNode.unfocus();
    if (rankFocusNode != null) {
      rankFocusNode.unfocus();
    }
  }

  // Add methods to set country from Country Screen
  void setSelectedCountry(String countryName, String countryCode) {
    selectedCountry = countryName;
    selectedCountryCode = countryCode;
    notifyListeners();
  }

  void setSelectedCountryFromModel(CountryModel country) {
    selectedCountry = country.name ?? 'India';
    selectedCountryCode = country.code ?? 'IN';
    notifyListeners();
  }

  // Add a safe method to handle field submission
  void handleFieldSubmission(String fieldName, String value) {
    if (value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
      markFieldAsSubmitted(fieldName);
    }
  }

  // Add a safe method to handle validation without keyboard conflicts
  void safeValidateAllFields(BuildContext context) {
    hasSubmitted = true;
    // Use a post-frame callback to ensure UI is stable
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

  // Add a safe method to handle phone validation
  void safeValidatePhone({bool notify = true}) {
    if (!hasSubmitted) return;
    // Use a post-frame callback to ensure UI is stable
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneError = validateMobile(phoneController.text.trim());
      if (notify) {
        notifyListeners();
      }
    });
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
    selectedCountry = 'India'; // Reset to default country
    nameError = null;
    nickNameError = null;
    emailError = null;
    phoneError = null;
    dateError = null;
    genderError = null;
    rankError = null;
    isShowDateError = false;
    autoValidateMode = AutovalidateMode.disabled;
    hasSubmitted = false;
    profileImage = null;
    notifyListeners();
  }

  void showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 30.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Container(
                width: 10.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 3.h),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickProfileImage(ImageSource.camera, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickProfileImage(ImageSource.gallery, context); // Fixed to use gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickProfileImage(ImageSource source, BuildContext context) async {
    await checkPermission(context);
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Future<void> fetchRanks(BuildContext context) async {
  //   try {
  //     var response = await NetworkService().getResponse(
  //       getAllRank,
  //       true,
  //       context,
  //           () => notifyListeners(),
  //     );
  //     print("Fetch Ranks Response: $response");
  //     if (response.isNotEmpty) {
  //       final rankData = GetAllRankModel.fromJson(response);
  //       if (rankData.statusCode == 200) {
  //         ranks = rankData.data; // Use setter to update ranks
  //       } else {
  //         ranks = [];
  //         print("Error: Status code ${rankData.statusCode}, Message: ${rankData.message}");
  //         if (context.mounted) {
  //           ShowToast("Error", rankData.message ?? "Failed to load ranks");
  //         }
  //       }
  //     } else {
  //       ranks = [];
  //       print("Error: Empty response from server");
  //       if (context.mounted) {
  //         ShowToast("Error", "No ranks data received");
  //       }
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     ranks = [];
  //     print("Fetch Ranks Error: $e");
  //     if (context.mounted) {
  //       ShowToast("Error", "Failed to load ranks: $e");
  //     }
  //     notifyListeners();
  //   }
  // }

  String _formatPhoneNumber() {
    if (phoneNumber.phoneNumber != null && phoneNumber.phoneNumber!.isNotEmpty) {
      String countryCode = '';
      switch (phoneNumber.isoCode) {
        case 'IN':
          countryCode = '+91';
          break;
        case 'US':
          countryCode = '+1';
          break;
        case 'GB':
          countryCode = '+44';
          break;
        case 'FR':
          countryCode = '+33';
          break;
        case 'DE':
          countryCode = '+49';
          break;
        default:
          countryCode = '+1';
      }
      return '$countryCode ${phoneNumber.phoneNumber}';
    }
    return '';
  }

  String _formatDateForAPI() {
    if (addDateApi.isNotEmpty) {
      try {
        List<String> dateParts = addDateApi.split('-');
        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);
          DateTime date = DateTime(year, month, day);
          return '${date.year.toString().padLeft(4, '0')}-'
              '${date.month.toString().padLeft(2, '0')}-'
              '${date.day.toString().padLeft(2, '0')}';
        }
      } catch (e) {
        print('Error formatting date: $e');
      }
    }
    DateTime now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> updateSeafarerProfile(BuildContext context) async {
    if (context.mounted) startLoading(context);
    
    try {
      // Debug token status
      NetworkHelper.debugTokenStatus();
      
      // Force sync data from SharedPreferences first
      await NetworkHelper.forceSyncUserData();
      
      // Validate session before making API call
      bool isSessionValid = await NetworkHelper.validateSession();
      if (!isSessionValid) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "Session expired. Please log in again.");
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            login,
            (route) => false, // Remove all previous routes
          );
        }
        return;
      }

      // Get user data from NetworkHelper
      String? userId = NetworkHelper.loggedInUserId;
      String? token = NetworkHelper.token;
      
      print("ProfileProvider - UserID from NetworkHelper: $userId");
      print("ProfileProvider - Token from NetworkHelper: $token");

      // Validate token and user ID
      if (token == null || token.isEmpty) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "Session expired. Please log in again.");
        if (context.mounted) NetworkHelper().removeToken(context);
        return;
      }

      if (userId == null || userId.isEmpty) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "User ID not found. Please log in again.");
        return;
      }

      // Create Dio instance
      var dio = Dio();
      
      // Set headers
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Language': 'en'
      };

      // Prepare form data
      var formData = FormData.fromMap({
        "userId": userId, // Use actual user ID from NetworkHelper
        "currentCountry": ChooseCountryProvider.globalSelectedCountry ?? "India", // Use global country data directly
        "firstName": nameController.text.trim(),
        "lastName": nickNameController.text.trim(),
        "dateOfBirth": _formatDateForAPI(),
        "contactEmail": emailController.text.trim(),
        "rankId": ChooseRankProvider.globalSelectedRankId ?? '',
        "mobilePhone": _formatPhoneNumber(),
        "sex": selectedGender == 'Gender' ? '' : selectedGender,
      });

      // Add profile image if selected
      if (profileImage != null) {
        // Determine MIME type
        String? mimeType = lookupMimeType(profileImage!.path);
        if (mimeType == null || !mimeType.startsWith('image/')) {
          if (context.mounted) {
            stopLoading(context);
            ShowToast("Error", "Invalid file type. Please select an image file.");
          }
          print("Invalid MIME type: $mimeType for path: ${profileImage!.path}");
          return;
        }

        String fileName = profileImage!.path.split('/').last;
        formData.files.add(
          MapEntry(
            'profilePhoto',
            await MultipartFile.fromFile(
              profileImage!.path,
              filename: profileImage!.path.split('/').last,
              contentType: MediaType.parse(mimeType), // Use MediaType from http_parser
            ),
          ),
        );
      }

      print("Seafarer Profile Dio Request URL: $seafarerProfileBasicInfo");
      print("Seafarer Profile Dio Request Headers: $headers");
      print("Seafarer Profile Dio Request Fields: ${formData.fields}");
      print("Seafarer Profile Dio Request Files: ${formData.files.map((file) => file.value.filename).toList()}");

      // Make the API call using Dio
      var response = await dio.post(
        seafarerProfileBasicInfo,
        data: formData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
      );
      if (context.mounted) stopLoading(context);

      print("Seafarer Profile Dio Response Status: ${response.statusCode}");
      print("Seafarer Profile Dio Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Profile update successful
        if (context.mounted) {
          ShowToast("Success", response.data['message'] ?? "Profile updated successfully");
          if (context.mounted) stopLoading(context);
          
          // Clear global country data after successful submission
          ChooseCountryProvider.clearGlobalSelectedCountry();
          
          // Navigate to next screen
          Navigator.of(context).pushNamed(bottomMenu);
          resetForm();
        }
      } else {
        if (context.mounted) {
          if (context.mounted) stopLoading(context);
          ShowToast("Error", response.data['message'] ?? "Failed to update profile");
        }
      }
    } on DioException catch (e) {
      print("Seafarer Profile Dio Error: ${e.message}");
      print("Seafarer Profile Dio Error Type: ${e.type}");
      print("Seafarer Profile Dio Error Response: ${e.response?.data}");
      
      if (context.mounted) {
        if (context.mounted) stopLoading(context);
        
        if (e.response?.statusCode == 401) {
          ShowToast("Error", "Session expired. Please log in again.");
          var loginProvider = Provider.of<LoginProvider>(context, listen: false);
          await loginProvider.clearStoredLoginData();
          NetworkHelper().removeToken(context);
          Navigator.of(context).pushReplacementNamed(login);

        } else if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          ShowToast("Error", e.response?.data['message'] ?? "Bad request");
        } else {
          ShowToast("Error", "Something went wrong during profile update");
        }
      }
    } catch (e) {
      print("Seafarer Profile Update Error: $e");
      if (context.mounted) {
        if (context.mounted) stopLoading(context);
        ShowToast("Error", "Something went wrong during profile update");
      }
    }
    notifyListeners();
  }


  @override
  void dispose() {
    nameController.dispose();
    nickNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    nickNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dateFocusNode.dispose();
    genderFocusNode.dispose();
    rankFocusNode.dispose(); // Dispose rank focus node
    super.dispose();
  }
}