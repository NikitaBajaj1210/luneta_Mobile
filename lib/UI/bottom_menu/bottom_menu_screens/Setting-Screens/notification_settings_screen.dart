import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/notification_provider.dart'; // Import the provider

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButtonWithTitle(
                      title: "Notification",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Title

                    SizedBox(height: 2.h),

                    // General Notification Switch
                    notificationSwitch(
                      label: 'General Notification',
                      value: provider.generalNotification,
                      onChanged: (bool value) {
                        provider.setGeneralNotification = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Sound Switch
                    notificationSwitch(
                      label: 'Sound',
                      value: provider.sound,
                      onChanged: (bool value) {
                        provider.setSound = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Vibrate Switch
                    notificationSwitch(
                      label: 'Vibrate',
                      value: provider.vibrate,
                      onChanged: (bool value) {
                        provider.setVibrate = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Notify me when there is a job recommendation
                    notificationSwitch(
                      label: 'Notify me when there is a job recommendation',
                      value: provider.jobRecommendation,
                      onChanged: (bool value) {
                        provider.setJobRecommendation = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Notify me when there is a job invitation
                    notificationSwitch(
                      label: 'Notify me when there is a job invitation',
                      value: provider.jobInvitation,
                      onChanged: (bool value) {
                        provider.setJobInvitation = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // Notify me when a recruiter views my profile
                    notificationSwitch(
                      label: 'Notify me when a recruiter views my profile',
                      value: provider.profileViews,
                      onChanged: (bool value) {
                        provider.setProfileViews = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // App Updates Switch
                    notificationSwitch(
                      label: 'App Updates',
                      value: provider.appUpdates,
                      onChanged: (bool value) {
                        provider.setAppUpdates = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // New Services Available Switch
                    notificationSwitch(
                      label: 'New Services Available',
                      value: provider.newServices,
                      onChanged: (bool value) {
                        provider.setNewServices = value;
                      },
                    ),
                    SizedBox(height: 1.h),

                    // New Tips Available Switch
                    notificationSwitch(
                      label: 'New Tips Available',
                      value: provider.newTips,
                      onChanged: (bool value) {
                        provider.setNewTips = value;
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

  // Custom Switch for each notification setting
  Widget notificationSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 70.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.fontSize18,
              fontWeight: FontWeight.w600,
              fontFamily: AppColors.fontFamilySemiBold,
              color: AppColors.Color_212121,
            ),
          ),
        ),
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
