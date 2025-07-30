import 'package:flutter/material.dart';
import 'dart:convert';
import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/auth_model/send_otp_model.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';
import '../../network/network_helper.dart';

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

  Future<void> sendOtpApi(BuildContext context, bool showLoading) async {
      // Create request body
      Map<String, dynamic> requestBody = {
        "email": emailController.text.trim(),
      };

      String body = jsonEncode(requestBody);

      Map<String, dynamic> response = await NetworkService().postResponse(
        sendOtpUrl,
        body,
        showLoading,
        context,
        () => notifyListeners(),
      );

      print("Send OTP Response: $response");

      if (response['statusCode'] == 200) {
        SendOtpResponse otpResponse = SendOtpResponse.fromJson(response);
        
        if (otpResponse.data == true) {
          ShowToast("Success", otpResponse.message ?? "OTP sent successfully!");
          
          // Navigate to OTP screen with email
          Navigator.of(context).pushNamed(otpScreen, arguments: {
            'email': emailController.text.trim(),
            'isFromLogin': false, // Indicate it's from forgot password
            'isFromForgotPassword': true, // Specific flag for forgot password
          });
        }
      }

  }

  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
