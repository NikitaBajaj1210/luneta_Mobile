import 'package:flutter/material.dart';
import 'dart:convert';
import '../../const/color.dart';
import '../../network/network_helper.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';

class CreatePasswordProvider with ChangeNotifier {
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

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

  // Password reset API call
  Future<void> resetPasswordApi(BuildContext context, String token, String email, String userId, {bool isFromForgotPassword = false}) async {
    try {
      print("CreatePasswordProvider - resetPasswordApi called");
      print("CreatePasswordProvider - token: $token");
      print("CreatePasswordProvider - email: $email");
      print("CreatePasswordProvider - isFromForgotPassword: $isFromForgotPassword");
      
      // Create request body
      Map<String, dynamic> requestBody = {
        "newPassword": passwordController.text.trim(),
        "token": token,
      };

      String body = jsonEncode(requestBody);
      print("CreatePasswordProvider - Request body: $body");

      Map<String, dynamic> response = await NetworkService().postResponse(
        resetUrl,
        body,
        true, // showLoading
        context,
        () => notifyListeners(),
      );

      print("CreatePasswordProvider - Reset password response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        ShowToast("Success", response['message'] ?? "Password reset successfully!");
        
        print("CreatePasswordProvider - Password reset successful, navigating to login");
        
        // Navigate to login screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          login,
          (route) => false, // Remove all previous routes
        );
      } else {
        // Handle error response
        String errorMessage = response['message'] ?? "Failed to reset password";
        ShowToast("Error", errorMessage);
        print("CreatePasswordProvider - Password reset failed: $errorMessage");
      }
    } catch (e) {
      print("CreatePasswordProvider - Reset password error: $e");
      ShowToast("Error", "something went wrong. Please try again.");
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
