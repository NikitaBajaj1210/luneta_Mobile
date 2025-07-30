import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luneta/provider/authentication-provider/create_password_provider.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
class CreatePasswordScreen extends StatefulWidget {
  final String? token;
  final String? email;
  final String? userId;
  final bool? isFromForgotPassword;
  
  const CreatePasswordScreen({
    super.key,
    this.token,
    this.email,
    this.userId,
    this.isFromForgotPassword,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _isFromForgotPassword = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    // Use constructor parameters instead of navigation arguments
    _isFromForgotPassword = widget.isFromForgotPassword ?? false;
    print("CreatePasswordScreen - From Forgot Password: $_isFromForgotPassword");
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<CreatePasswordProvider>(context, listen: false);
      provider.autoValidateMode = AutovalidateMode.disabled;
      
      // Print the received parameters for debugging
      print("CreatePasswordScreen - Token: ${widget.token}");
      print("CreatePasswordScreen - Email: ${widget.email}");
      print("CreatePasswordScreen - UserId: ${widget.userId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreatePasswordProvider(),
      child: Consumer<CreatePasswordProvider>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColors.bottomNavBorderColor,
                  ),
                ),
                child: customButton(
                  voidCallback: () async {
                    model.autoValidateMode = AutovalidateMode.always;
                    if (formKey.currentState!.validate()) {
                      // Call the password reset API
                      await model.resetPasswordApi(
                        context,
                        widget.token ?? '',
                        widget.email ?? '',
                        widget.userId ?? '',
                        isFromForgotPassword: _isFromForgotPassword,
                      );
                      model.autoValidateMode = AutovalidateMode.disabled;
                    }
                  },
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: formKey.currentState?.validate() ?? false
                      ? AppColors.buttonColor
                      : AppColors.Color_BDBDBD,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: formKey.currentState?.validate() ?? false
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,),
                  child: Form(
                    key: formKey,
                    autovalidateMode: model.autoValidateMode,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      backButtonWithTitle(
                        title: "Create New Password",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 5.h),
                      Image.asset(
                        "assets/images/CreatePasswordBg.png", // Update the path to your logo
                        height: 30.h, // Adjust logo size
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Create Your New Password",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyMedium,
                          fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 3.h),
                      customTextField(
                        context: context,
                        focusNode: model.passwordFocusNode,
                        controller: model.passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: model.obscurePassword,
                        voidCallback: validateSignupPassword,
                        fillColor: model.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          // Handle password field submitted if needed
                        },
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        iconSize: AppFontSize.fontSize20,
                        backgroundColor: model.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: model.getFieldIconColor(
                              model.passwordFocusNode,
                              model.passwordController),
                        ),
                        onPrefixIconPressed: () {
                          // Handle prefix icon press if needed
                        },
                        suffixIcon: Icon(
                          model.obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: model.passwordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.passwordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onSuffixIconPressed: () {
                          model.togglePasswordVisibility();
                        },
                      ),
            
                      SizedBox(height: 2.h),
                      customTextField(
                        context: context,
                        focusNode: model.confirmPasswordFocusNode,
                        controller: model.confirmPasswordController,
                        hintText: 'Confirm Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: model.obscureConfirmPassword,
                        voidCallback :(value)=>validateConfirmPassword(value, model.passwordController.text),
                        fillColor: model.confirmPasswordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          // Handle confirm password field submitted if needed
                        },
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        iconSize: AppFontSize.fontSize20,
                        backgroundColor: model.confirmPasswordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: model.confirmPasswordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.confirmPasswordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onPrefixIconPressed: () {
                          // Handle prefix icon press if needed
                        },
                        suffixIcon: Icon(
                          model.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: model.confirmPasswordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.confirmPasswordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onSuffixIconPressed: () {
                          model.toggleConfirmPasswordVisibility();
                        },
                      ),
            
            
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
