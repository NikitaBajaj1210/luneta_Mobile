import 'package:flutter/material.dart';
import 'dart:convert';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/auth_model/verify_otp_model.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';
import '../../network/network_helper.dart';

class OtpScreenProvider with ChangeNotifier {
  String _pin = '';

  String get pin => _pin;

  set pin(String value) {
    _pin = value;
    notifyListeners();
  }

  Future<void> verifyOtpApi(BuildContext context, String email, String otp, bool showLoading) async {
    try {
      // Create request body
      Map<String, dynamic> requestBody = {
        "email": email,
        "otp": otp,
      };

      String body = jsonEncode(requestBody);

      Map<String, dynamic> response = await NetworkService().postResponse(
        verifyOtpUrl,
        body,
        showLoading,
        context,
        () => notifyListeners(),
      );

      print("Verify OTP Response: $response");

      if (response['statusCode'] == 200) {
        VerifyOtpResponse otpResponse = VerifyOtpResponse.fromJson(response);
        
        if (otpResponse.user != null) {
          ShowToast("Success", otpResponse.message ?? "OTP verified successfully!");
          
          // Store user token if available
          String? userToken;
          if (otpResponse.user!.token != null) {
            userToken = otpResponse.user!.token;
            print("User Token: $userToken");
          }
          
          // Navigate to create password screen with token
          Navigator.of(context).pushNamed(createPassword, arguments: {
            'token': userToken,
            'email': email,
            'userId': otpResponse.user!.id,
          });
        } else {
          ShowToast("Error", "Failed to verify OTP");
        }
      } else {
        // Handle error response
        String errorMessage = response['message'] ?? "Failed to verify OTP";
        ShowToast("Error", errorMessage);
      }
    } catch (e) {
      print("Verify OTP Error: $e");
      ShowToast("Error", "Something went wrong. Please try again.");
    }
  }
}