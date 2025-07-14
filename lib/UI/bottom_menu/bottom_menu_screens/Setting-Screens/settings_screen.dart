import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/Setting-Screens/deactivate_account_screen.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/settings_provider.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../const/color.dart';
import '../../../../custom-component/custom-button.dart';

// Custom Divider Widget
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
      height: 0.01.h,
      color: AppColors.Color_EEEEEE,
      width: 100.w,
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backButtonWithTitle(
                        title: "Settings",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 16.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/settingCard.png"),
                            fit: BoxFit.fill, // This ensures the image covers the entire container
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.buttonBorderColor.withOpacity(0.25),
                              blurRadius: 24,
                              offset: Offset(4, 8),
                              spreadRadius: 0,  // Position the shadow (horizontal, vertical)
                            ),
                          ],
                          borderRadius: BorderRadius.circular(1.5.h),  // Optional, for rounded corners
                        ),
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 5.h, // Adjust size here
                              lineWidth: 1.h,
                              animation: true,
                              animationDuration: 2000,
                              percent: settingsProvider.profileCompletion / 100.0, // Convert percentage to a decimal
                              center: Text(
                                "${(settingsProvider.profileCompletion).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.Color_FFFFFF,
                                  fontFamily: AppColors.fontFamilyBold,
                                ),
                              ),
                              progressColor: AppColors.Color_FFFFFF, // Progress color
                              backgroundColor: AppColors.greyDotColor, // Background circle color
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            SizedBox(width: 5.2.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Profile Completed!",
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.Color_FFFFFF,
                                    fontFamily: AppColors.fontFamilyBold,
                                  ),
                                ),
                                Container(
                                  width: 52.w,
                                  child: Text(
                                    "A complete profile increases the chances of a recruiter being more interested in recruiting you.",
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.Color_FFFFFF,
                                      fontFamily: AppColors.fontFamilyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),



                      // Custom Divider
                      CustomDivider(),

                      // Account Section
                      SectionTile(
                        title: "Job Seeking Status",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/Show.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(jobSeekingStatusScreen);

                          // Add functionality here
                        },
                      ),
                      CustomDivider(),
                      Text(
                        "Account",
                        style: TextStyle(
                            fontSize:AppFontSize.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.Color_616161,
                            fontFamily: AppColors.fontFamilyBold
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      SectionTile(
                        title: "Personal Information",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/userIcon.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(personalInformationScreen);
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Linked Accounts",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/SwapIcon.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(linkedAccountsScreen);
                          // Add functionality here
                        },
                      ),
                      SizedBox(height: 3.h),
                      CustomDivider(),
                      // General Section
                      Text(
                        "General",
                        style: TextStyle(
                            fontSize:AppFontSize.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.Color_616161,
                            fontFamily: AppColors.fontFamilyBold
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      SectionTile(
                        title: "Notification",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/bellIcon.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(notificationSettingsScreen);
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Application Issues",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/Work.png",height: 2.5.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Timezone",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h),
                        prefixIcon: Image.asset("assets/images/TimeSquare.png",height: 2.5.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Security",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/shield.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(security);
                          // Add functionality here
                        }
                      ),
                      SectionTile(
                        title: "Language",
                        prefixIcon: Image.asset("assets/images/MoreCircle.png",height: 2.5.h,),
                        trailing: Row(
                          children: [
                            Text(
                              settingsProvider.language,style:TextStyle( fontSize: AppFontSize.fontSize18,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppColors.fontFamilySemiBold,
                                color: AppColors.Color_212121) ,),
                            SizedBox(width: 5.w,),
                            Icon(Icons.arrow_forward_ios,size: 2.h,),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(languageSettingsScreen);
                          // Add functionality to change language here
                        },
                      ),
                      SectionTile(
                        title: "Dark Mode",
                        onTap: () {},
                        prefixIcon: Image.asset("assets/images/Show.png",height: 2.5.h,),
                        trailing: Container(
                          padding: EdgeInsets.only(left: 1.5.w),
                          child: Transform.scale(
                            scale: 0.65, // Adjust this value to decrease the size (0.7 = 70% of original size)
                            child: CupertinoSwitch(
                              value: settingsProvider.isDarkMode,
                              onChanged:settingsProvider.setDarkMode,
                              activeColor: Color(0xFF6B7280),
                              trackColor: Color(0xFFE5E7EB),
                            ),
                          ),
                        ),
                      ),
                      SectionTile(
                        title: "Help Center",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/InfoSquareBlack.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(helpCenterScreen);
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Invite Friends",
                        prefixIcon: Image.asset("assets/images/3UserBlack.png",height: 2.5.h,),
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Rate Us",
                        prefixIcon: Image.asset("assets/images/StarBlack.png",height: 2.5.h,),
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      CustomDivider(),
                      Text(
                        "About",
                        style: TextStyle(
                            fontSize:AppFontSize.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.Color_616161,
                            fontFamily: AppColors.fontFamilyBold
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      // About Section
                      SectionTile(
                        title: "Privacy & Policy",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/shield.png",height: 2.5.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "Terms of Services",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/Password.png",height: 2.5.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      SectionTile(
                        title: "About Us",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/InfoSquareBlack.png",height: 2.5.h,),
                        onTap: () {
                          // Add functionality here
                        },
                      ),
                      CustomDivider(),
                      SectionTile(
                        title: "Deactivate My Account",
                        trailing: Icon(Icons.arrow_forward_ios,size: 2.h,),
                        prefixIcon: Image.asset("assets/images/LockIconRed.png",height: 2.5.h,),
                        onTap: () {
                          Navigator.of(context).pushNamed(deactivateAccountScreen);

                          // Add functionality here
                        },
                        titleStyle: TextStyle( fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppColors.fontFamilySemiBold,
                            color: AppColors.errorRedColor),
                      ),
                      SectionTile(
                        title: "Logout",
                        trailing:null,
                        prefixIcon: Image.asset("assets/images/Logout.png",height: 2.5.h,),
                        onTap: () {
                          _showApplyJobBottomSheet(context,settingsProvider);
                          // Add functionality here
                        },
                        titleStyle: TextStyle( fontSize: AppFontSize.fontSize18,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppColors.fontFamilySemiBold,
                          color: AppColors.errorRedColor),
                      ),
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
}


class SectionTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final TextStyle? titleStyle;
  final Widget? prefixIcon;  // Allow both Icon and Image

  const SectionTile({
    Key? key,
    required this.title,
    this.trailing,
    required this.onTap,
    this.titleStyle,
    this.prefixIcon,  // This is an optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,  // Display either Image or Icon
              SizedBox(width: 2.w),  // Add some space between the icon and title
            ],
            Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppColors.fontFamilySemiBold,
                    color: AppColors.Color_212121
                  ),
            ),
            Spacer(),
            if (trailing != null) ...[
              trailing!,  // Display either Image or Icon
            ],

          ],
        ),
      ),
    );
  }
}

void _showApplyJobBottomSheet(BuildContext context,SettingsProvider provider) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Transparent background to show rounded corner effect
    builder: (BuildContext context) {
      return Container(
        height: 26.h, // Adjust the height of the bottom sheet
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: AppColors.Color_FFFFFF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.h),
            topRight: Radius.circular(5.h),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 1.h,bottom: 2.h),
              height: 0.5.h,
              width: 10.w,
              decoration: BoxDecoration(
                  color: AppColors.greyDotColor,
                  borderRadius: BorderRadius.circular(10.h)),
            ),
            // Title of the Bottom Sheet
            Text(
              "Logout",
              style: TextStyle(
                fontSize: AppFontSize.fontSize24,
                fontWeight: FontWeight.w700,
                fontFamily: AppColors.fontFamilyBold,
                color:AppColors.errorRedColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, bottom: 2.5.h),
              height: 0.01.h,
              color: AppColors.Color_EEEEEE,
              width: 100.w,
            ),
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                fontSize: AppFontSize.fontSize20,
                fontWeight: FontWeight.w700,
                fontFamily: AppColors.fontFamilyBold,
                color:AppColors.Color_424242,
              ),
            ),
            SizedBox(height: 3.h,),
            // Share Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customButton(
                  voidCallback: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(applyJobCv);

                  },
                  buttonText: "Cancel",
                  width: 42.w,
                  height: 6.h,
                  color: AppColors.applyCVButtonColor,
                  buttonTextColor: AppColors.buttonColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize16,
                  showShadow: false,
                ),

                customButton(
                  voidCallback: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(applyJobProfile);
                  },
                  buttonText: "Yes, Logout",
                  width: 48.w,
                  height: 6.h,
                  color: AppColors.buttonColor,
                  buttonTextColor: AppColors.Color_FFFFFF,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize16,
                  showShadow: true,
                ),
              ],)
          ],
        ),
      );
    },
  );
}
