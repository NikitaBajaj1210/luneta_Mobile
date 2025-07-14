import 'package:flutter/material.dart';
import '../../const/color.dart';

class SignUpProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool _hasValidated = false;

  bool get hasValidated => _hasValidated;

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

  SignUpProvider() {
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

  void resetForm() {
    emailController.clear();
    passwordController.clear();
    _hasValidated = false;
    notifyListeners();
  }
}