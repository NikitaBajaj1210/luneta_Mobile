import 'package:flutter/material.dart';
import '../../Utils/validation.dart';
import '../../const/color.dart';

class ForgotPasswordProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool hasValidated = false;

  bool get isFormValid {
    return emailController.text.trim().isNotEmpty && 
           validateEmail(emailController.text) == null;
  }

  Color getFieldIconColor(FocusNode focusNode, TextEditingController controller) {
    if (focusNode.hasFocus) {
      return AppColors.buttonColor;
    } else if (controller.text.isNotEmpty) {
      return AppColors.Color_212121;
    } else {
      return AppColors.Color_9E9E9E;
    }
  }

  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
