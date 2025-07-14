import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/job_seeking_status_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';  // Import your provider.

class JobSeekingStatusScreen extends StatelessWidget {
  const JobSeekingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobSeekingStatusProvider(),
      child: Consumer<JobSeekingStatusProvider>(
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
                    // Get the profile provider
                                     },
                  buttonText: "Save",
                  width: 90.w,
                  height: 4.h,
                  color: AppColors.buttonColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: true,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButtonWithTitle(
                      title: "Job Seeking Status",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    // Radio button options for job seeking status
                    Row(
                       children: [
                        Radio<int>(
                          fillColor: MaterialStateProperty.all(AppColors.buttonColor),  // Customize button color
                          value: 0,
                          groupValue: provider.selectedStatusIndex,
                          onChanged: (value) {
                            provider.selectedStatusIndex = value!;
                          },
                        ),
                        Text(
                          "Actively looking for jobs",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Color_424242,
                            fontFamily: AppColors.fontFamilyBold
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13.w),
                      width: 75.w,
                      child: Text(
                        "I am actively looking for job right now, and I would like to accept job invitations.",
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Color_424242,
                            fontFamily: AppColors.fontFamilyMedium
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Radio<int>(
                          fillColor: MaterialStateProperty.all(AppColors.buttonColor),
                          value: 1,
                          groupValue: provider.selectedStatusIndex,
                          onChanged: (value) {
                            provider.selectedStatusIndex = value!;
                          },
                        ),
                        Text(
                          "Passively looking for jobs",
                          style: TextStyle(
                              fontSize: AppFontSize.fontSize18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.Color_424242,
                              fontFamily: AppColors.fontFamilyBold
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13.w),
                      width: 75.w,
                      child: Text(
                        "I’m not looking for a job right now, but I am interested to accept job invitations.",
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Color_424242,
                            fontFamily: AppColors.fontFamilyMedium
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Radio<int>(
                          fillColor: MaterialStateProperty.all(AppColors.buttonColor),
                          value: 2,
                          groupValue: provider.selectedStatusIndex,
                          onChanged: (value) {
                            provider.selectedStatusIndex = value!;
                          },
                        ),
                        Text(
                          "Not looking for jobs",
                          style: TextStyle(
                              fontSize: AppFontSize.fontSize18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.Color_212121,
                              fontFamily: AppColors.fontFamilyBold
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13.w),
                      width: 75.w,
                      child: Text(
                        "I’m not looking for a job right now, please don’t send me job invitations.",
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Color_424242,
                            fontFamily: AppColors.fontFamilyMedium
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Save button

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
