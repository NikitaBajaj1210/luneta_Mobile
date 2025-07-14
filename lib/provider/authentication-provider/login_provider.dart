import 'package:flutter/material.dart';
import '../../const/color.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool _isChecked = false;
  bool _hasValidated = false; // New flag to track validation attempt

  bool get isChecked => _isChecked;
  bool get hasValidated => _hasValidated;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  set hasValidated(bool value) {
    _hasValidated = value;
    notifyListeners();
  }

  bool get isFormValid =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

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

  void initListeners() {
    emailController.addListener(() => notifyListeners());
    passwordController.addListener(() => notifyListeners());
    emailFocusNode.addListener(() => notifyListeners());
    passwordFocusNode.addListener(() => notifyListeners());
  }

  LoginProvider() {
    initListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}