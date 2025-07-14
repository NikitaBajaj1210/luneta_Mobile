import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/cupertino.dart';  // For CupertinoSwitch
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/Setting-Screen-Provider/linked_account_provider.dart'; // Import the provider

class LinkedAccountsScreen extends StatelessWidget {
  const LinkedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LinkedAccountProvider(),
      child: Consumer<LinkedAccountProvider>(
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
                      title: "Linked Accounts",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Google Account Switch
                    linkedAccountSwitch(
                      label: 'Google',
                      iconPath: 'assets/images/GoogleIcon.png', // Add icon path
                      value: provider.googleLinked,
                      onChanged: (bool value) {
                        provider.googleLinked = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Apple Account Switch
                    linkedAccountSwitch(
                      label: 'Apple',
                      iconPath: 'assets/images/AppleIcon.png', // Add icon path
                      value: provider.appleLinked,
                      onChanged: (bool value) {
                        provider.appleLinked = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Facebook Account Switch
                    linkedAccountSwitch(
                      label: 'Facebook',
                      iconPath: 'assets/images/FaceBookIcon.png', // Add icon path
                      value: provider.facebookLinked,
                      onChanged: (bool value) {
                        provider.facebookLinked = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Twitter Account Switch
                    linkedAccountSwitch(
                      label: 'Twitter',
                      iconPath: 'assets/images/bird.png', // Add icon path
                      value: provider.twitterLinked,
                      onChanged: (bool value) {
                        provider.twitterLinked = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // LinkedIn Account Switch
                    linkedAccountSwitch(
                      label: 'LinkedIn',
                      iconPath: 'assets/images/linkedIN.png', // Add icon path
                      value: provider.linkedinLinked,
                      onChanged: (bool value) {
                        provider.linkedinLinked = value;
                      },
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

  // Custom Switch for each linked account with icon
  Widget linkedAccountSwitch({
    required String label,
    required String iconPath,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          iconPath, // Icon path passed to the widget
          width: 2.5.h, // Adjust the size as needed
          height: 2.5.h,
        ),
        SizedBox(width: 2.w), // Space between icon and text
        Text(
          label,
          style: TextStyle(
            fontSize: AppFontSize.fontSize16,
            fontWeight: FontWeight.w600,
            color: AppColors.Color_212121,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(left: 1.5.w),
          child: Transform.scale(
            scale: 0.7, // Adjust this value to decrease the size (0.7 = 70% of original size)
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
