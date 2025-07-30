import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/auth_model/verify_otp_model.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';
import '../../network/network_helper.dart';

class OtpScreenProvider with ChangeNotifier {
  String _pin = '';
  bool _rememberMe = false;

  String get pin => _pin;
  bool get rememberMe => _rememberMe;

  set pin(String value) {
    _pin = value;
    notifyListeners();
  }

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  // Method to store user data in SharedPreferences
  Future<void> _storeUserData(String userId, String email, String token) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', userId);
      await prefs.setString('email', email);
      await prefs.setString('token', token);
      // Password is already stored during login process
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('rememberMe', true);
      
      print("User data stored in SharedPreferences");
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  Future<void> verifyOtpApi(BuildContext context, String email, String otp, bool showLoading, {bool isFromLogin = false, bool rememberMe = false}) async {
    try {
      print("OTP Provider - isFromLogin: $isFromLogin, rememberMe: $rememberMe");
      
      // Create request body
      Map<String, dynamic> requestBody = {
        "email": email,
        "otp": otp,
      };

      String body = jsonEncode(requestBody);

      // Use different API endpoints based on flow
      String apiUrl = isFromLogin ? verifyOtpUrl : verifyOtpForgotUrl;
      print("OTP Provider - Using API URL: $apiUrl");

      Map<String, dynamic> response = await NetworkService().postResponse(
        apiUrl,
        body,
        showLoading,
        context,
        () => notifyListeners(),
      );

      print("Verify OTP Response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        if (isFromLogin) {
          // Handle login flow response
          VerifyOtpResponse otpResponse = VerifyOtpResponse.fromJson(response);
          
          if (otpResponse.user != null) {
            ShowToast("Success", otpResponse.message ?? "OTP verified successfully!");
            
            // Store user token if available (now from user object)
            String? userToken;
            if (otpResponse.user!.token != null) {
              userToken = otpResponse.user!.token;
              print("User Token: $userToken");
            }
            
            print("OTP Provider - Coming from login, rememberMe: $rememberMe");
            // Coming from login - always go to home screen
            if (rememberMe) {
              print("OTP Provider - Storing user data for Remember Me");
              // Store user data in SharedPreferences for Remember Me
              await _storeUserData(
                otpResponse.user!.id ?? '',
                otpResponse.user!.email ?? '',
                userToken ?? '',
              );
            }
            
            print("OTP Provider - Navigating to home screen");
            // Navigate to home screen (bottom menu)
            if(otpResponse.user!.seafarerProfile!.isCompletedMobile==false){
              Navigator.of(context).pushNamedAndRemoveUntil(
                chooseCountry,
                    (route) => false, // Remove all previous routes
              );
            }else{
              Navigator.of(context).pushNamedAndRemoveUntil(
                bottomMenu,
                    (route) => false, // Remove all previous routes
              );
            }

          }
        } else {
          // Handle forgot password flow response
          print("OTP Provider - Processing forgot password response");
          
          // Use the new model for forgot password response
          VerifyOtpForgotResponse forgotResponse = VerifyOtpForgotResponse.fromJson(response);
          
          if (forgotResponse.data != null) {
            String? resetToken = forgotResponse.data!.resetToken;
            String? userId = forgotResponse.data!.id;
            
            print("OTP Provider - Reset Token: $resetToken");
            print("OTP Provider - User ID: $userId");
            
            ShowToast("Success", forgotResponse.message ?? "OTP verified successfully. You may now reset your password.");
            
            print("OTP Provider - Coming from forgot password, navigating to create password");
            // Coming from forgot password - go to create password screen
            Navigator.of(context).pushNamed(createPassword, arguments: {
              'token': resetToken, // Use resetToken for forgot password
              'email': email,
              'userId': userId,
              'isFromForgotPassword': true, // Pass forgot password flag
            });
          } else {
            ShowToast("Error", "Invalid response format");
          }
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