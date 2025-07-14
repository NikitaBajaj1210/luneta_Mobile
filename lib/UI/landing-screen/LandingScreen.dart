import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:luneta/const/color.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../custom-component/custom-button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // Define the Gesture Recognizer
  final TapGestureRecognizer tapGestureRecognizerSignup = TapGestureRecognizer();

  @override
  void dispose() {
    // Don't forget to dispose the recognizer when it's no longer needed
    tapGestureRecognizerSignup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Color_FFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
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
                      Navigator.pop(context); // Pop to the previous screen
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              // Logo
              SizedBox(height: 5.h),
              Image.asset(
                "assets/images/LunetaLogo.png", // Update the path to your logo
                height: 2.h, // Adjust logo size
              ),
              // Title text
              SizedBox(height: 8.h),
              Text(
                "Let’s sign you in",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize32,
                  fontWeight: FontWeight.w700,
                  color:AppColors.Color_212121,
                  fontFamily: AppColors.fontFamilyBold
                ),
              ),
              // Social login buttons
              SizedBox(height: 8.h),
              _buildSocialButton(
                imagePath: "assets/images/FaceBookIcon.png",
                text: "Continue with Facebook",
              ),
              SizedBox(height: 2.h),
              _buildSocialButton(
                imagePath: "assets/images/GoogleIcon.png",
                text: "Continue with Google",
              ),
              SizedBox(height: 2.h),
              _buildSocialButton(
                imagePath: "assets/images/AppleIcon.png",
                text: "Continue with Apple",
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 40.w, height: 0.1.h, color: AppColors.Color_EEEEEE, margin: EdgeInsets.only(right: 2.w, top: 0.5.h)),
                  Text("or", style: TextStyle(fontSize: AppFontSize.fontSize18, color: AppColors.Color_616161,fontWeight: FontWeight.w600,fontFamily: AppColors.fontFamilySemiBold)),
                  Container(width: 40.w, height: 0.1.h, color: AppColors.Color_EEEEEE, margin: EdgeInsets.only(left: 2.w, top: 0.5.h)),
                ],
              ),
              SizedBox(height: 4.h),
              customButton(
                voidCallback: () {
                  Navigator.of(context).pushNamed(login);
                },
                buttonText:"Sign in with password",
                width: 90.w,
                height: 6.h,
                color: AppColors.Color_607D8B,
                buttonTextColor: AppColors.Color_FFFFFF,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize16,
              ),
              Spacer(),
              Center(
                child: RichText(
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
                        text: ' Sign up',
                        recognizer: tapGestureRecognizerSignup
                          ..onTap = () {
                            // Navigate to Sign Up screen or perform an action
                            Navigator.of(context).pushNamed(signUp);
                          },
                        style: TextStyle(
                          fontFamily: AppColors.fontFamilySemiBold,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor,
                          // decoration: TextDecoration.underline,
                          fontSize: AppFontSize.fontSize14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create the social login buttons
  Widget _buildSocialButton({required String imagePath, required String text}) {
    return Container(
      width: 100.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
        border: Border.all(width: 1, color: AppColors.greyDotColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 2.5.h),
          SizedBox(width: 2.w),
          Text(
            text,
            style: TextStyle(
              fontFamily: AppColors.fontFamilySemiBold,
              fontSize: AppFontSize.fontSize16, // Responsive font size
              fontWeight: FontWeight.w600,
              color: AppColors.Color_212121, // Subtitle text color
            ),
          ),
        ],
      ),
    );
  }
}
