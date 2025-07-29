import 'package:flutter/material.dart';
import '../../const/color.dart';

class SignUpProvider with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      selectedCareerType != null &&
      _acceptPrivacyPolicy;

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
}