import 'package:flutter/material.dart';

import '../../const/color.dart';
class CreatePasswordProvider with ChangeNotifier {
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  CreatePasswordProvider() {
    _initListeners();
  }

  void _initListeners() {
    passwordController.addListener(() => notifyListeners());
    confirmPasswordController.addListener(() => notifyListeners());
    passwordFocusNode.addListener(() => notifyListeners());
    confirmPasswordFocusNode.addListener(() => notifyListeners());
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  // Reset form
  void resetForm() {
    passwordController.clear();
    confirmPasswordController.clear();
    autoValidateMode = AutovalidateMode.disabled;
    notifyListeners();
  }

  // Get field icon color based on focus and content
  Color getFieldIconColor(FocusNode focusNode, TextEditingController controller) {
    if (focusNode.hasFocus) {
      return AppColors.buttonColor; // While typing
    } else if (controller.text.isNotEmpty) {
      return AppColors.Color_212121; // When done typing
    } else {
      return AppColors.Color_BDBDBD; // Empty field & not focused
    }
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }
}
