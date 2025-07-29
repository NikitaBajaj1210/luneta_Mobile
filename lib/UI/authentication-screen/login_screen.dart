import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
import '../../provider/authentication-provider/login_provider.dart';
import '../../route/route_constants.dart';
import '../../const/font_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Scaffold(
            backgroundColor: AppColors.Color_FFFFFF,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h)
                    .copyWith(top: 0),
                child: Form(
                  key: loginProvider.formKey,
                  autovalidateMode: loginProvider.autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Back arrow button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      // Logo
                      SizedBox(height: 3.5.h),
                      Image.asset(
                        "assets/images/LunetaLogo.png",
                        height: 2.h,
                      ),
                      // Title text
                      SizedBox(height: 5.h),
                      Text(
                        "Login to Your Account",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize32,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppColors.fontFamilyBold,
                          color: AppColors.Color_212121,
                        ),
                      ),
                      // Email field
                      SizedBox(height: 4.h),
                      customTextField(
                        context: context,
                        focusNode: loginProvider.emailFocusNode,
                        controller: loginProvider.emailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        voidCallback: validateEmail,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: loginProvider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: loginProvider.emailFocusNode.hasFocus
                            ? AppColors.buttonColor
                            : AppColors.Color_212121,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        prefixIcon: Image.asset(
                          "assets/images/Message.png",
                          width: 2.h,
                          height: 2.h,
                          color: loginProvider.getFieldIconColor(
                              loginProvider.emailFocusNode,
                              loginProvider.emailController),
                        ),
                        fillColor: loginProvider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(loginProvider.passwordFocusNode);
                        },
                        autovalidateMode: loginProvider.hasValidated
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      ),
                      // Password field
                      SizedBox(height: 3.h),
                      customTextField(
                        context: context,
                        focusNode: loginProvider.passwordFocusNode,
                        controller: loginProvider.passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: loginProvider.obscurePassword,
                        voidCallback: validateLoginPassword,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: loginProvider.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: loginProvider.passwordFocusNode.hasFocus
                            ? AppColors.buttonColor
                            : AppColors.Color_212121,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: loginProvider.getFieldIconColor(
                              loginProvider.passwordFocusNode,
                              loginProvider.passwordController),
                        ),
                        suffixIcon: Icon(
                          loginProvider.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: loginProvider.getFieldIconColor(
                              loginProvider.passwordFocusNode,
                              loginProvider.passwordController),
                        ),
                        fillColor: loginProvider.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onSuffixIconPressed: () {
                          loginProvider.togglePasswordVisibility();
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        autovalidateMode: loginProvider.hasValidated
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      ),
                      // Remember me checkbox
                      SizedBox(height: 3.h),
                      Container(
                        width: 40.w,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            loginProvider.isChecked = !loginProvider.isChecked;
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 2.6.h,
                                width: 2.6.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: loginProvider.isChecked
                                      ? AppColors.buttonColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(0.8.h),
                                  border: Border.all(
                                    color: AppColors.buttonColor,
                                    width: 2,
                                  ),
                                ),
                                child: loginProvider.isChecked
                                    ? Image.asset(
                                  "assets/images/tickIcon.png",
                                  scale: 0.5.h,
                                )
                                    : Container(),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilySemiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sign in button
                      SizedBox(height: 3.h),
                      customButton(
                        voidCallback: loginProvider.isFormValid
                            ? () {
                          loginProvider.hasValidated = true; // Set validation attempt
                          if (loginProvider.formKey.currentState!
                              .validate()) {
                            // Navigator.of(context).pushNamed(bottomMenu);
                            loginProvider.loginApi(context, true);
                            // Handle successful login
                          }else{
                            loginProvider.autovalidateMode = AutovalidateMode.onUserInteraction;
                          }
                        }
                            : null,
                        buttonText: "Sign in",
                        width: 90.w,
                        height: 6.h,
                        color: loginProvider.isFormValid
                            ? AppColors.buttonColor
                            : AppColors.Color_BDBDBD,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        fontSize: AppFontSize.fontSize16,
                        showShadow: loginProvider.isFormValid,
                        shadowColor: AppColors.buttonBorderColor,
                      ),
                      // Forgot password
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(forgotPassword);
                        },
                        child: Text(
                          "Forgot the password?",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor,
                            fontFamily: AppColors.fontFamilySemiBold,
                          ),
                        ),
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
                      const Spacer(),
                      // Sign up link
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(
                            fontFamily: AppColors.fontFamilyRegular,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Color_9E9E9E,
                            fontSize: AppFontSize.fontSize14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(signUp);
                                },
                              style: TextStyle(
                                fontFamily: AppColors.fontFamily,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonColor,
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

  Widget _buildSocialButton({
    required String imagePath,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement social login
        print("Social login: $text");
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