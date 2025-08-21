import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';
import '../../models/auth_model/verify_otp_model.dart';
import '../../Utils/helper.dart';
import '../../route/route_constants.dart';
import '../../network/network_helper.dart';
import '../bottom_menu_provider/bottom_menu_provider.dart';

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
  Future<void> _storeUserData(String userId, String email, String token,String fullName,String profilePath,String firstName, String lastName) async {
    try {
      print("OTP Provider - _storeUserData called with:");
      print("OTP Provider - userId: $userId");
      print("OTP Provider - email: $email");
      print("OTP Provider - token: ${token.isNotEmpty ? '[EXISTS]' : '[EMPTY]'}");
      
      // Store in NetworkHelper for direct access
      await NetworkHelper.storeUserData(
        userId: userId,
        email: email,
        token: token,
        profilePicURL: profilePath, // Will be updated when profile is loaded
        fullName: fullName, // Will be updated when profile is loaded
        refreshToken: null, // Will be updated when available
        firstName: firstName,
        lastName: lastName
      );
      
      // Also store in SharedPreferences for persistence
      // var prefs = await SharedPreferences.getInstance();
      // await prefs.setString('userid', userId);
      // await prefs.setString('email', email);
      // await prefs.setString('token', token);
      // await prefs.setBool('isLoggedIn', true);
      // await prefs.setString('profilePicURL', profilePath);
      // await prefs.setString('fullName', fullName);


      print("OTP Provider - User data stored in both NetworkHelper and SharedPreferences");
      print("OTP Provider - NetworkHelper.loggedInUserId: ${NetworkHelper.loggedInUserId}");
      print("OTP Provider - NetworkHelper.token: ${NetworkHelper.token.isNotEmpty ? '[EXISTS]' : '[EMPTY]'}");
      print("OTP Provider - NetworkHelper.isLoggedIn: ${NetworkHelper.isLoggedIn}");
    } catch (e) {
      print("Error storing user data: $e");
    }
    notifyListeners();
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
            
            // Always store user data in NetworkHelper for session management
            print("OTP Provider - Storing user data in NetworkHelper");
            NetworkHelper.loggedInUserId = otpResponse.user!.id??'';
            NetworkHelper.loggedInUserEmail = email;
            NetworkHelper.token = userToken??'';
            await _storeUserData(
              otpResponse.user!.id ?? '',
              otpResponse.user!.email ?? '',
              userToken ?? '',
              ((otpResponse.user!.seafarerProfile!.firstName ?? '')+" "+(otpResponse.user!.seafarerProfile!.lastName ?? '')),
              otpResponse.user!.seafarerProfile!.profilePhoto ?? '',
                otpResponse.user!.seafarerProfile!.firstName!,
                (otpResponse.user!.seafarerProfile!.lastName ?? '')

            );
            
            // If Remember Me is checked, also store in SharedPreferences for persistence
            if (rememberMe) {
              print("OTP Provider - Remember Me checked, storing in SharedPreferences");
              var prefs = await SharedPreferences.getInstance();
              await prefs.setBool('rememberMe', true);
              await prefs.setString('password', ''); // Password should be stored during login
            }
            
            print("OTP Provider - Navigating to home screen");
            if(otpResponse.user!.seafarerProfile!.isCompletedMobile==false){
              Navigator.of(context).pushNamedAndRemoveUntil(
                chooseCountry,
                    (route) => false, // Remove all previous routes
              );
            }else{
                Provider.of<BottomMenuProvider>(
                    context,
                    listen: false).updateSelectedIndex(0);
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
            ShowToast("Error", "invalid response format");
          }
        }
      } else {
        // Handle error response
        String errorMessage = response['message'] ?? "Failed to verify OTP";
        ShowToast("Error", errorMessage);
      }
    } catch (e) {
      print("Verify OTP Error: $e");
      ShowToast("Error", "something went wrong. Please try again.");
    }
    notifyListeners();
  }
}