import 'package:flutter/material.dart';
import 'package:luneta/provider/authentication-provider/forgot_password_provider.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
import '../../Utils/validation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, forgotPasswordProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: customButton(
                  voidCallback: forgotPasswordProvider.isFormValid
                      ? () {
                          forgotPasswordProvider.hasValidated = true;
                          if (forgotPasswordProvider.formKey.currentState!.validate()) {
                            forgotPasswordProvider.sendOtpApi(context, true);
                          } else {
                            forgotPasswordProvider.autovalidateMode = AutovalidateMode.onUserInteraction;
                          }
                        }
                      : null,
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: forgotPasswordProvider.isFormValid
                      ? AppColors.buttonColor
                      : AppColors.Color_BDBDBD,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: forgotPasswordProvider.isFormValid,
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w,).copyWith(bottom: 0.h,top: 1.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: forgotPasswordProvider.formKey,
                    autovalidateMode: forgotPasswordProvider.autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        backButtonWithTitle(
                          title: "Forgot Password",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 2.h),
                        Image.asset(
                          "assets/images/SheildImg.png",
                          height: 30.h,
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Enter your email address to reset your password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Color_212121,
                              fontFamily: AppColors.fontFamilyMedium,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        customTextField(
                          context: context,
                          focusNode: forgotPasswordProvider.emailFocusNode,
                          controller: forgotPasswordProvider.emailController,
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
                          voidCallback: validateEmail,
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: forgotPasswordProvider.emailFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA,
                          borderColor: forgotPasswordProvider.emailFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : AppColors.Color_212121,
                          textColor: AppColors.Color_212121,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          prefixIcon: Image.asset(
                            "assets/images/Message.png",
                            width: 2.h,
                            height: 2.h,
                            color: forgotPasswordProvider.getFieldIconColor(
                                forgotPasswordProvider.emailFocusNode,
                                forgotPasswordProvider.emailController),
                          ),
                          fillColor: forgotPasswordProvider.emailFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          autovalidateMode: forgotPasswordProvider.hasValidated
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
