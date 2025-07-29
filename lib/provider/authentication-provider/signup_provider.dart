import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../network/network_helper.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/auth_model/register_model.dart';
import '../../Utils/helper.dart';
import '../../Utils/validation.dart';
import '../../route/route_constants.dart';

class SignUpProvider with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool _hasValidated = false;
  String? selectedCareerType;
  bool _acceptJobAlerts = false;
  bool _acceptNewsletters = false;
  bool _acceptPrivacyPolicy = false;

  bool get hasValidated => _hasValidated;

  set hasValidated(bool value) {
    _hasValidated = value;
    notifyListeners();
  }

  bool get isFormValid =>
      firstNameController.text.trim().isNotEmpty &&
      lastNameController.text.trim().isNotEmpty &&
      emailController.text.trim().isNotEmpty &&
      passwordController.text.isNotEmpty &&
      selectedCareerType != null &&
      _acceptPrivacyPolicy &&
      validateFirstName(firstNameController.text) == null &&
      validateLastName(lastNameController.text) == null &&
      validateEmail(emailController.text) == null &&
      validateSignupPassword(passwordController.text) == null;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Color getFieldIconColor(FocusNode focusNode, TextEditingController controller) {
    if (focusNode.hasFocus) {
      return AppColors.buttonColor;
    } else if (controller.text.isNotEmpty) {
      return AppColors.Color_212121;
    } else {
      return AppColors.Color_BDBDBD;
    }
  }

  // Getters for checkbox states
  bool get acceptJobAlerts => _acceptJobAlerts;
  bool get acceptNewsletters => _acceptNewsletters;
  bool get acceptPrivacyPolicy => _acceptPrivacyPolicy;

  // Setters for checkbox states
  set acceptJobAlerts(bool value) {
    _acceptJobAlerts = value;
    notifyListeners();
  }

  set acceptNewsletters(bool value) {
    _acceptNewsletters = value;
    notifyListeners();
  }

  set acceptPrivacyPolicy(bool value) {
    _acceptPrivacyPolicy = value;
    notifyListeners();
  }

  void setCareerType(String? value) {
    selectedCareerType = value;
    notifyListeners();
  }

  void initListeners() {
    firstNameController.addListener(() => notifyListeners());
    lastNameController.addListener(() => notifyListeners());
    emailController.addListener(() => notifyListeners());
    passwordController.addListener(() => notifyListeners());
    firstNameFocusNode.addListener(() => notifyListeners());
    lastNameFocusNode.addListener(() => notifyListeners());
    emailFocusNode.addListener(() => notifyListeners());
    passwordFocusNode.addListener(() => notifyListeners());
  }

  SignUpProvider() {
    initListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedCareerType = null;
    _acceptJobAlerts = false;
    _acceptNewsletters = false;
    _acceptPrivacyPolicy = false;
    _hasValidated = false;
    notifyListeners();
  }

  Future<void> registerApi(BuildContext context, bool showLoading) async {
    try {
      // Prepare request body according to API specification
      Map<String, dynamic> requestBody = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "role": "seafarer", // Default role as per API
        "career_type": selectedCareerType ?? "Office", // Default to Office if not selected
        "isJobAlerts": _acceptJobAlerts,
        "isNewsLetters": _acceptNewsletters,
        "isPrivacyPolicy": _acceptPrivacyPolicy,
        "fcmToken": "" // Empty for now, can be updated later
      };

      print("Registration Request Body: $requestBody");

      Map<String, dynamic> response = await NetworkService().postResponse(
        signupUrl,
        jsonEncode(requestBody),
        showLoading,
        context,
        () => notifyListeners(),
      );

      print("Registration Response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Registration successful
        RegisterModel registerModel = RegisterModel.fromJson(response);
        
        // Show success message
        ShowToast("Success", registerModel.message ?? "Registration successful");
        
        // Navigate to profile screen or next step
        if (context.mounted) {
          Navigator.of(context).pushNamed(login);
          resetForm();
        }
      }
    } catch (e) {
      print("Registration Error: $e");
      ShowToast("Error", "Something went wrong during registration");
    }
  }
}