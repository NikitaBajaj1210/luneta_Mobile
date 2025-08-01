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
import '../../models/rank_model.dart';
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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode nickNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode rankFocusNode = FocusNode();

  String? nameError;
  String? nickNameError;
  String? emailError;
  String? phoneError;
  String? dateError;
  String? genderError;
  String? rankError;
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');
  String addDate = 'Date of Birth';
  String addDateApi = '';
  String selectedGender = 'Gender';
  String selectedCountry = 'India';
  String selectedCountryCode = 'IN';
  bool isShowDateError = false;
  File? profileImage;
  List<Data> _ranks = [];

  // Getters and Setters for controllers
  TextEditingController get nameController => _nameController;
  set nameController(TextEditingController controller) {
    _nameController = controller;
    notifyListeners();
  }

  TextEditingController get nickNameController => _nickNameController;
  set nickNameController(TextEditingController controller) {
    _nickNameController = controller;
    notifyListeners();
  }

  TextEditingController get emailController => _emailController;
  set emailController(TextEditingController controller) {
    _emailController = controller;
    notifyListeners();
  }

  TextEditingController get phoneController => _phoneController;
  set phoneController(TextEditingController controller) {
    _phoneController = controller;
    notifyListeners();
  }

  // Getter for ranks list
  List<Data> get ranks => _ranks;

  // Setter for ranks list
  set ranks(List<Data>? newRanks) {
    _ranks = newRanks ?? [];
    notifyListeners();
  }

  ProfileProvider() {
    // Load email from NetworkHelper when provider is created
    _loadEmailFromNetworkHelper();
    
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

  // Method to load email from NetworkHelper
  void _loadEmailFromNetworkHelper() {
    if (NetworkHelper.loggedInUserEmail.isNotEmpty) {
      emailController.text = NetworkHelper.loggedInUserEmail;
      print("ProfileProvider - Email loaded from NetworkHelper: ${NetworkHelper.loggedInUserEmail}");
    } else {
      print("ProfileProvider - No email found in NetworkHelper");
    }
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
        if (value.isEmpty || value == 'Date of Birth') {
          error = 'Date of birth is required';
        } else {
          error = validateAgeRequirement(value);
        }
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

  String? validateAgeRequirement(String dateString) {
    try {
      List<String> dateParts = dateString.split('/');
      if (dateParts.length == 3) {
        int month = int.parse(dateParts[0]);
        int day = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);

        DateTime birthDate = DateTime(year, month, day);
        DateTime today = DateTime.now();

        int age = today.year - birthDate.year;
        if (today.month < birthDate.month ||
            (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }

        if (age < 18) {
          return 'You must be at least 18 years old to register';
        }

        return null;
      }
    } catch (e) {
      return 'Invalid date format';
    }
    return 'Invalid date format';
  }

  DateTime getMaxAllowedDate() {
    DateTime now = DateTime.now();
    return DateTime(now.year - 18, now.month, now.day);
  }

  DateTime getDefaultDateForPicker() {
    return getMaxAllowedDate();
  }

  void setDefaultDateIfNeeded() {
    if (addDate == 'Date of Birth' || addDate.isEmpty) {
      DateTime defaultDate = getMaxAllowedDate();
      addDate = '${defaultDate.day}/${defaultDate.month}/${defaultDate.year}';
      addDateApi = '${defaultDate.year}-${defaultDate.month.toString().padLeft(2, '0')}-${defaultDate.day.toString().padLeft(2, '0')}';
      notifyListeners();
    }
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
        if (value.isEmpty || value == 'Date of Birth') {
          error = 'Date of birth is required';
        } else {
          error = validateAgeRequirement(value);
        }
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
    phoneError = validateMobile(_phoneController.text.trim());
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
      validateFieldIfFocused('name', _nameController.text);
      validateFieldIfFocused('nickname', _nickNameController.text);
      validateFieldIfFocused('phone', _phoneController.text);
      validateFieldIfFocused('date', addDate);
      validateGender(selectedGender);
      notifyListeners();
    });
  }

  bool validateFields() {
    return validateFieldSilently('name', _nameController.text) == null &&
        validateFieldSilently('nickname', _nickNameController.text) == null &&
        validateFieldSilently('phone', _phoneController.text) == null &&
        validateFieldSilently('date', addDate) == null &&
        selectedGender != 'Gender';
  }

  void markFieldAsSubmitted(String fieldName) {
    if (!hasSubmitted) return;
    notifyListeners();
  }

  void handleTextChange(String fieldName, String value) {
    if (hasSubmitted && value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
    }
    notifyListeners();
  }

  void handlePhoneChange(PhoneNumber newNumber, String phoneText) {
    phoneNumber = newNumber;
    if (hasSubmitted && phoneText.isNotEmpty) {
      validateFieldIfFocused('phone', phoneText);
    }
    notifyListeners();
  }

  void handleFocusChange(String fieldName, bool hasFocus, String value) {
    if (!hasFocus && hasSubmitted && value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
    }
    notifyListeners();
  }

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

  void handleFieldSubmission(String fieldName, String value) {
    if (value.isNotEmpty) {
      validateFieldIfFocused(fieldName, value);
      markFieldAsSubmitted(fieldName);
    }
  }

  void safeValidateAllFields(BuildContext context) {
    hasSubmitted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      validateFieldIfFocused('name', _nameController.text);
      validateFieldIfFocused('nickname', _nickNameController.text);
      validateFieldIfFocused('email', _emailController.text);
      validateFieldIfFocused('phone', _phoneController.text);
      validateFieldIfFocused('date', addDate);
      validateGender(selectedGender);
      notifyListeners();
    });
  }

  void safeValidatePhone({bool notify = true}) {
    if (!hasSubmitted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneError = validateMobile(_phoneController.text.trim());
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
    _nameController.clear();
    _nickNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    addDate = 'Date of Birth';
    addDateApi = '';
    selectedGender = 'Gender';
    selectedCountry = 'India';
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


  Future<void> showImageSourceBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  pickProfileImage(ImageSource.gallery, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  pickProfileImage(ImageSource.camera, context);
                  Navigator.of(context).pop();
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
      File imageFile = File(pickedFile.path);
      int originalLength = await imageFile.length();

      if (originalLength <= 20971520) {
        XFile? compressedFile = await compressFile(imageFile);
        if (compressedFile != null) {
          profileImage = File(compressedFile.path);
          notifyListeners();
        }
      } else {
        showToast('File size must be less than 20 MB');
      }
    }
  }

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
      NetworkHelper.debugTokenStatus();
      await NetworkHelper.forceSyncUserData();

      var dio = Dio();
      var headers = {
        'Authorization': 'Bearer ${NetworkHelper.token}',
        'Accept': 'application/json',
      };

      var formData = FormData.fromMap({
        "userId": NetworkHelper.loggedInUserId,
        "currentCountry": ChooseCountryProvider.globalSelectedCountry ?? "India",
        "firstName": _nameController.text.trim(),
        "lastName": _nickNameController.text.trim(),
        "dateOfBirth": _formatDateForAPI(),
        "contactEmail": _emailController.text.trim(),
        "rankId": ChooseRankProvider.globalSelectedRankId ?? '',
        "mobilePhone": _formatPhoneNumber(),
        "sex": selectedGender == 'Gender' ? '' : selectedGender,
      });

      if (profileImage != null) {
        String? mimeType = lookupMimeType(profileImage!.path);
        if (mimeType == null || !mimeType.startsWith('image/')) {
          if (context.mounted) {
            stopLoading(context);
            ShowToast("Error", "Invalid file type. Please select a valid image file.");
          }
          return;
        }

        formData.files.add(
          MapEntry(
            'profilePhoto',
            await MultipartFile.fromFile(
              profileImage!.path,
              filename: profileImage!.path.split('/').last,
              contentType: MediaType.parse(mimeType),
            ),
          ),
        );
      }
      var response = await dio.post(
        seafarerProfileBasicInfo,
        data: formData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
      );
      if (context.mounted) stopLoading(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          ShowToast("Success", response.data['message'] ?? "Saved successfully");
          if (context.mounted) stopLoading(context);
          ChooseCountryProvider.clearGlobalSelectedCountry();
          Navigator.of(context).pushNamed(bottomMenu);
          resetForm();
        }
      } else {
        if (context.mounted) {
          if (context.mounted) stopLoading(context);
          ShowToast("Error", response.data['message'] ?? "Something went wrong");
        }
      }
    } on DioException catch (e) {
      if (context.mounted) {
        if (context.mounted) stopLoading(context);

        if (e.response?.statusCode == 401) {
          ShowToast("Error", "Session expired. Please log in again.");
          var loginProvider = Provider.of<LoginProvider>(context, listen: false);
          await loginProvider.clearStoredLoginData();
          NetworkHelper().removeToken(context);
          Navigator.of(context).pushReplacementNamed(login);
        } else if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          ShowToast("Error", e.response?.data['message'] ?? "Something went wrong");
        } else {
          ShowToast("Error", "Something went wrong");
        }
      }
    } catch (e) {
      print("Seafarer Profile Update Error: $e");
      if (context.mounted) {
        if (context.mounted) stopLoading(context);
        ShowToast("Error", "Something went wrong");
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    nameFocusNode.dispose();
    nickNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dateFocusNode.dispose();
    genderFocusNode.dispose();
    rankFocusNode.dispose();
    super.dispose();
  }
}