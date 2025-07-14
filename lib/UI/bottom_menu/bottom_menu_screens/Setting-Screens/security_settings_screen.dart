import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/cupertino.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/security_provider.dart'; // Import the provider

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SecurityProvider(),
      child: Consumer<SecurityProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    backButtonWithTitle(
                      title: "Security",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Title

                    SizedBox(height: 2.h),

                    // Remember Me Switch
                    securitySwitch(
                      label: 'Remember me',
                      value: provider.rememberMe,
                      onChanged: (bool value) {
                        provider.setRememberMe = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Biometric ID Switch
                    securitySwitch(
                      label: 'Biometric ID',
                      value: provider.biometricID,
                      onChanged: (bool value) {
                        provider.setBiometricID = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Face ID Switch
                    securitySwitch(
                      label: 'Face ID',
                      value: provider.faceID,
                      onChanged: (bool value) {
                        provider.setFaceID = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Google Authenticator Switch
                    securitySwitch(
                      label: 'Google Authenticator',
                      value: provider.googleAuthenticator,
                      onChanged: (bool value) {
                        provider.setGoogleAuthenticator = value;
                      },
                    ),
                    SizedBox(height: 3.h),

                    // Change PIN Button
                    customButton(
                      voidCallback: () {
                        // Get the profile provider
                      },
                      buttonText: "Change PIN",
                      width: 90.w,
                      height: 5.5.h,
                      color: AppColors.applyCVButtonColor,
                      buttonTextColor: AppColors.buttonColor,
                      shadowColor: AppColors.buttonBorderColor,
                      fontSize: AppFontSize.fontSize18,
                      showShadow: false,
                    ),
                    SizedBox(height: 2.h),

                    // Change Password Button
                    customButton(
                      voidCallback: () {
                        // Get the profile provider
                      },
                      buttonText: "Change Password",
                      width: 90.w,
                      height: 5.5.h,
                      color: AppColors.applyCVButtonColor,
                      buttonTextColor: AppColors.buttonColor,
                      shadowColor: AppColors.buttonBorderColor,
                      fontSize: AppFontSize.fontSize18,
                      showShadow: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Custom Switch for each security setting
  Widget securitySwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.w600,
            fontFamily: AppColors.fontFamilySemiBold,
            color: AppColors.Color_212121,
          ),
        ),
     label=='Google Authenticator'?Icon(Icons.arrow_forward_ios,size: 2.h,):   Container(
          padding: EdgeInsets.only(left: 1.5.w),
          child: Transform.scale(
            scale: 0.7,
            // Adjust this value to decrease the size (0.7 = 70% of original size)
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.buttonColor,
              trackColor: AppColors.Color_EEEEEE,
            ),
          ),
        ),
      ],
    );
  }

}