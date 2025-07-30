import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/helper.dart';
import '../../const/color.dart';
import '../../models/auth_model/login_model.dart';
import '../../network/app_url.dart';
import '../../network/network_services.dart';
import '../../network/network_helper.dart';

class LoginProvider with ChangeNotifier {

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled; // Initialize
  AutovalidateMode get autovalidateMode => _autovalidateMode;
  set autovalidateMode(AutovalidateMode mode) {
    _autovalidateMode = mode;
    notifyListeners();
  }

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

  // Method to store user data in SharedPreferences
  Future<void> _storeUserData(String userId, String email, String token, String password) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', userId);
      await prefs.setString('email', email);
      await prefs.setString('token', token);
      await prefs.setString('password', password); // Store password
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('rememberMe', true);
      print("User data stored in SharedPreferences");
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  // Method to clear stored login data
  Future<void> clearStoredLoginData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      bool rememberMe = prefs.getBool('rememberMe') ?? false;
      
      if (rememberMe) {
        // If Remember Me is checked, only clear sensitive data but keep email/password
        await prefs.remove('userid');
        await prefs.remove('token');
        await prefs.remove('isLoggedIn');
        // Keep email, password, and rememberMe flag
        print("Logout - Cleared sensitive data but kept email/password for Remember Me");
      } else {
        // If Remember Me is not checked, clear everything
        await prefs.remove('userid');
        await prefs.remove('email');
        await prefs.remove('password');
        await prefs.remove('token');
        await prefs.remove('isLoggedIn');
        await prefs.remove('rememberMe');
        print("Logout - Cleared all stored login data");
      }
    } catch (e) {
      print("Error clearing stored login data: $e");
    }
  }

  // Method to auto-fill login form with stored data
  Future<void> autoFillLoginForm() async {
    print("LoginProvider - autoFillLoginForm called");
    try {
      var prefs = await SharedPreferences.getInstance();
      bool rememberMe = prefs.getBool('rememberMe') ?? false;
      
      print("LoginProvider - rememberMe: $rememberMe");
      
      if (rememberMe) {
        // Auto-fill the form with stored data
        String? storedEmail = prefs.getString('email');
        String? storedPassword = prefs.getString('password');
        
        print("LoginProvider - storedEmail: $storedEmail");
        print("LoginProvider - storedPassword: ${storedPassword != null ? '[EXISTS]' : '[NULL]'}");
        
        if (storedEmail != null) {
          emailController.text = storedEmail;
          print("LoginProvider - Set email controller text: $storedEmail");
        }
        
        if (storedPassword != null) {
          passwordController.text = storedPassword;
          print("LoginProvider - Set password controller text: [HIDDEN]");
        }
        
        // Set remember me checkbox
        _isChecked = true;
        
        // Notify listeners after all changes
        notifyListeners();
        
        print("LoginProvider - Form filled with stored data and notified listeners");
      }
    } catch (e) {
      print("Auto Fill Error: $e");
    }
  }

  // Method to check if user is already logged in
  Future<bool> checkAutoLogin(BuildContext context) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      bool rememberMe = prefs.getBool('rememberMe') ?? false;
      
      print("Auto Login Check - isLoggedIn: $isLoggedIn, rememberMe: $rememberMe");
      
      if (isLoggedIn && rememberMe) {
        String? storedEmail = prefs.getString('email');
        String? storedPassword = prefs.getString('password');
        
        if (storedEmail != null && storedPassword != null) {
          emailController.text = storedEmail;
          passwordController.text = storedPassword;
          print("Auto Login - Filled email: $storedEmail");
          print("Auto Login - Filled password: [HIDDEN]");
        }
        
        _isChecked = true;
        notifyListeners();
        
        print("Auto Login - User is already logged in, navigating to home");
        
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            bottomMenu,
            (route) => false, // Remove all previous routes
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      print("Auto Login Error: $e");
      return false;
    }
  }

  void initListeners() {
    emailController.addListener(() => notifyListeners());
    passwordController.addListener(() => notifyListeners());
    emailFocusNode.addListener(() => notifyListeners());
    passwordFocusNode.addListener(() => notifyListeners());
  }

  LoginProvider() {
    print("LoginProvider - New instance created");
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

  loginApi(BuildContext context, bool showLoader) async {
    print("LoginProvider - loginApi called, isChecked: $isChecked");
    startLoading(context);
    var data = {
      "email": emailController.text,
      "password": passwordController.text
    };
    var body = jsonEncode(data);

    Map<dynamic, dynamic> response = await NetworkService().postResponse(loginUrl, body, showLoader, context, notifyListeners);
    
    if(response.isNotEmpty) {
      print("response------------>>>${response}");

      final responseModel = LoginModel.fromJson(
          response.cast<String, dynamic>());
      if (responseModel.data != null && responseModel.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        if (context.mounted) stopLoading(context);
        
        // Clear any existing stored data if Remember Me is not checked
        if (!isChecked) {
          await clearStoredLoginData();
          print("Login - Remember Me not checked, cleared stored data");
        } else {
          // Store password for Remember Me functionality
          var prefs = await SharedPreferences.getInstance();
          await prefs.setString('password', passwordController.text);
          print("Login - Remember Me checked, stored password");
        }
        
        print("Login Provider - isChecked value: $isChecked");
        print("Login Provider - Passing rememberMe: $isChecked to OTP screen");
        
        // Navigate to OTP screen with remember me state
        Navigator.of(context).pushNamed(otpScreen, arguments: {
          'email': responseModel.data!.user!.email.toString(),
          'isFromLogin': true,
          'rememberMe': isChecked, // Pass remember me state
        });

        // Handle successful login here
      }
    }
  }

}