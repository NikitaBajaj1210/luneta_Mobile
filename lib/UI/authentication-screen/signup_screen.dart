import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
import '../../provider/authentication-provider/signup_provider.dart';
import '../../route/route_constants.dart';
import '../../Utils/validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) {
          return Scaffold(
            backgroundColor: AppColors.Color_FFFFFF,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(top: 0),
                child: Form(
                  key: signUpProvider.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Back arrow button
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      // Logo
                      SizedBox(height: 5.h),
                      Image.asset("assets/images/LunetaLogo.png", height: 2.h),
                      // Title
                      SizedBox(height: 6.h),
                      Text(
                        "Create New Account",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize32,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppColors.fontFamilyBold,
                          color: AppColors.Color_212121,
                        ),
                      ),
                      // Email Field
                      SizedBox(height: 4.h),
                      customTextField(
                        context: context,
                        focusNode: signUpProvider.emailFocusNode,
                        controller: signUpProvider.emailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize14,
                        voidCallback: validateEmail,
                        backgroundColor: signUpProvider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        fillColor: signUpProvider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(signUpProvider.passwordFocusNode);
                        },
                        prefixIcon: Image.asset(
                          "assets/images/Message.png",
                          width: 2.h,
                          height: 2.h,
                          color: signUpProvider.getFieldIconColor(
                              signUpProvider.emailFocusNode,
                              signUpProvider.emailController),
                        ),
                        autovalidateMode: signUpProvider.hasValidated
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      ),
                      // Password Field
                      SizedBox(height: 2.h),
                      customTextField(
                        context: context,
                        focusNode: signUpProvider.passwordFocusNode,
                        controller: signUpProvider.passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: signUpProvider.obscurePassword,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize14,
                        voidCallback: validateSignupPassword,
                        backgroundColor: signUpProvider.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        fillColor: signUpProvider.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: signUpProvider.getFieldIconColor(
                              signUpProvider.passwordFocusNode,
                              signUpProvider.passwordController),
                        ),
                        suffixIcon: Icon(
                          signUpProvider.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: signUpProvider.getFieldIconColor(
                              signUpProvider.passwordFocusNode,
                              signUpProvider.passwordController),
                        ),
                        onSuffixIconPressed: signUpProvider.togglePasswordVisibility,
                        autovalidateMode: signUpProvider.hasValidated
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      ),
                      // Sign up button
                      SizedBox(height: 3.h),
                      customButton(
                        voidCallback: signUpProvider.isFormValid
                            ? () {
                          signUpProvider.hasValidated = true;
                          if (signUpProvider.formKey.currentState!.validate()) {
                            // Navigator.of(context).pushNamed(chooseCountry);
                            Navigator.of(context).pushNamed(profile);
                            signUpProvider.resetForm();
                          }
                        }
                            : null,
                        buttonText: "Sign up",
                        width: 90.w,
                        height: 6.h,
                        color: signUpProvider.isFormValid
                            ? AppColors.buttonColor
                            : AppColors.Color_BDBDBD,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize16,
                        showShadow: signUpProvider.isFormValid,
                      ),
                      // Social login divider
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25.w,
                            height: 0.1.h,
                            color: AppColors.Color_EEEEEE,
                            margin: EdgeInsets.only(right: 2.5.w, top: 0.5.h),
                          ),
                          Text(
                            "or continue with",
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize18,
                              color: AppColors.Color_757575,
                              fontFamily: AppColors.fontFamilySemiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 25.w,
                            height: 0.1.h,
                            color: AppColors.Color_EEEEEE,
                            margin: EdgeInsets.only(left: 2.5.w, top: 0.5.h),
                          ),
                        ],
                      ),
                      // Social buttons
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: 75.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSocialButton(
                              imagePath: "assets/images/FaceBookIcon.png",
                              text: "Continue with Facebook",
                            ),
                            _buildSocialButton(
                              imagePath: "assets/images/GoogleIcon.png",
                              text: "Continue with Google",
                            ),
                            _buildSocialButton(
                              imagePath: "assets/images/AppleIcon.png",
                              text: "Continue with Apple",
                            ),
                          ],
                        ),
                      ),
                      // Already have an account
                      const Spacer(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: AppColors.fontFamilyRegular,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Color_9E9E9E,
                            fontSize: AppFontSize.fontSize14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(login);
                                },
                              style: TextStyle(
                                fontFamily: AppColors.fontFamilySemiBold,
                                fontWeight: FontWeight.w600,
                                color: AppColors.Color_607D8B,
                                fontSize: AppFontSize.fontSize14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialButton({required String imagePath, required String text}) {
    return GestureDetector(
      onTap: () {
        print("Social login: $text"); // TODO: Implement social login
      },
      child: Container(
        width: 22.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.h)),
          border: Border.all(width: 1, color: AppColors.greyDotColor),
        ),
        child: Image.asset(imagePath, height: 2.5.h),
      ),
    );
  }
}