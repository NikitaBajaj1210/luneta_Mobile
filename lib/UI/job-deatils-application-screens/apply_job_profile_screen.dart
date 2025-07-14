import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../provider/job-details-application-provider/apply_job_profile_provider.dart';

class ApplyJobProfileScreen extends StatefulWidget {
  const ApplyJobProfileScreen({super.key});

  @override
  State<ApplyJobProfileScreen> createState() => _ApplyJobProfileScreenState();
}

class _ApplyJobProfileScreenState extends State<ApplyJobProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyJobProfileProvider(),
      child: Consumer<ApplyJobProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: () {
                    showCustomDialogWithLoader(context);
                    // Apply Button Click Logic
                  },
                  buttonText: "Submit",
                  width: 90.w,
                  height: 4.h,
                  color: AppColors.buttonColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: true,
                ),
              ),
              body: Container(
                color: AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      backButtonWithTitle(
                        title: "Apply Job",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 2.5.h),

                      // Profile Section
                      _buildProfileSection(provider),
                      Container(
                        margin: EdgeInsets.only(top: 2.h, bottom:2.h),
                        height: 0.01.h,
                        color: AppColors.Color_EEEEEE,
                        width: 100.w,
                      ),
                      // Contact Information
                      _buildInfoCard(
                        title: "Contact Information",
                        iconPath: "assets/images/profileActive.png",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("assets/images/LocationBlack.png", provider.location),
                            _infoRow("assets/images/Call.png", provider.phoneNumber, isPhoneNumber: true),
                            _infoRow("assets/images/emailIcon.png", provider.email,),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Summary
                      _buildInfoCard(
                        title: "Summary",
                        iconPath: "assets/images/DocumentIcon.png",
                        content: Text(
                          provider.summary,
                          style:
                          TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              color: AppColors.Color_424242,
                              fontFamily: AppColors.fontFamilyRegular,
                              fontWeight:FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      // Expected Salary
                      _buildInfoCard(
                        title: "Expected Salary",
                        iconPath: "assets/images/SalaryChart.png",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),

                            // **Salary Range Text**
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppColors.fontFamilyMedium,
                                  color: AppColors.Color_212121,
                                ),
                                children: [
                                  TextSpan(text:"\$10,000 - \$25,000 ",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppColors.fontFamilySemiBold,
                                      fontSize: AppFontSize.fontSize16,
                                      color: AppColors.Color_212121
                                  )),
                                  TextSpan(
                                    text: "/month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppColors.fontFamilySemiBold,
                                      fontSize: AppFontSize.fontSize16,
                                      color: AppColors.Color_212121
                                    ),
                                  ),
                                  TextSpan(
                                    text: " (only you can see this)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppColors.fontFamilyMedium,
                                        fontSize: AppFontSize.fontSize12,
                                        color: AppColors.Color_616161
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

// ✅ Profile Section Widget (Fixed Overflow Issue)
Widget _buildProfileSection(ApplyJobProfileProvider provider) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 4.5.h,
        backgroundImage: AssetImage(provider.profileImage),
      ),
      SizedBox(width: 4.w),

      Expanded( // ✅ Fix Overflow Issue by using Expanded
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.name,
              style: TextStyle(
                  fontSize: AppFontSize.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppColors.fontFamilyBold,
                  color: AppColors.Color_212121),
            ),
            SizedBox(height: 0.5.h),
            Text(
              provider.jobTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppColors.fontFamilyMedium,
                  color: AppColors.Color_616161),
            ),
          ],
        ),
      ),
      GestureDetector(
        child: Image.asset("assets/images/Edit.png", height: 2.5.h),
        onTap: () {
          // Handle edit action
        },
      ),
    ],
  );
}

// ✅ Generic Information Card Widget (Fixed Asset Image Issue)
Widget _buildInfoCard({required String title, required String iconPath, required Widget content}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w,).copyWith(top: 0.8.h,bottom: 2.h,),
    decoration: BoxDecoration(
      color: AppColors.Color_FFFFFF,
      borderRadius: BorderRadius.circular(3.h),
      border: Border.all(width: 0.1.h,color: AppColors.Color_EEEEEE)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconPath, height: 2.5.h), // ✅ Fix Asset Image Issue
                SizedBox(width: 3.w),
                Text(title, style: TextStyle(fontSize: AppFontSize.fontSize20, fontWeight: FontWeight.w700,fontFamily: AppColors.fontFamilyBold,color: AppColors.Color_212121)),
              ],
            ),
            GestureDetector(
              child: Image.asset("assets/images/Edit.png", height: 2.5.h),
              onTap: () {
                // Handle edit action
              },
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 1.h, bottom: 1.5.h),
          height: 0.01.h,
          color: AppColors.Color_EEEEEE,
          width: 100.w,
        ),
        content,
      ],
    ),
  );
}

// ✅ Information Row Widget
Widget _infoRow(String iconPath, String text, {bool isPhoneNumber = false,}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 1.h),
    child: Row(
      children: [
        Image.asset(iconPath, height: 2.5.h, color: AppColors.Color_212121),
        SizedBox(width: 2.w),
        Expanded(
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  color: AppColors.Color_212121,
                  fontFamily: AppColors.fontFamilyMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 2.w,),
              if (isPhoneNumber)
                Image.asset("assets/images/BlueTick.png", height: 2.5.h,),
            ],
          ),
        ),
      ],
    ),
  );
}



void showCustomDialogWithLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Container(
              width: 100.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.introBackgroundColor,
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/CvUploadImg.png",
                    height: 20.h,
                    width: 100.w,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize24,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppColors.fontFamilyBold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      "Your application has been successfully submitted. You can track the progress of your application through the applications menu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppColors.fontFamilyRegular,
                        color: AppColors.Color_212121,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  customButton(
                    voidCallback: () {
                      Navigator.pop(context);
                    },
                    buttonText: "Go to My Applications",
                    width: 65.w,
                    height: 7.h,
                    color: AppColors.buttonColor,
                    buttonTextColor: AppColors.Color_FFFFFF,
                    shadowColor: AppColors.buttonBorderColor,
                    fontSize: AppFontSize.fontSize16,
                    showShadow: true,
                  ),
                  SizedBox(height: 3.h),
                  customButton(
                    voidCallback: () {
                      Navigator.pop(context);
                    },
                    buttonText: "Cancel",
                    width: 65.w,
                    height: 7.h,
                    color: AppColors.applyCVButtonColor,
                    buttonTextColor: AppColors.buttonColor,
                    shadowColor: AppColors.buttonBorderColor,
                    fontSize: AppFontSize.fontSize16,
                    showShadow: false,
                  ),
                ],
              )));
    },
  );
}
