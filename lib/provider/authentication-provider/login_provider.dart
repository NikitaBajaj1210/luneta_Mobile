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

  loginApi(BuildContext context, bool showLoader) async {
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
         Navigator.of(context).pushNamed(otpScreen, arguments: {
           'email': responseModel.data!.user!.email.toString(),
           'isFromLogin': true,
         });

        // Handle successful login her
    }}
  }

}