import 'package:flutter/material.dart';
import 'package:luneta/provider/bottom_menu_provider/notification_provider.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: Consumer<NotificationProvider>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header with Back Button and Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backButtonWithTitle(
                            title: "Notification",
                            onBackPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Image.asset(
                              "assets/images/menuIcon.png",
                              height: 3.h,
                              color: AppColors.Color_212121,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 5.h,
                        child: Stack(
                          children: [
                            // Continuous Grey Line for All Tabs
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 0.2.h,
                                color: AppColors.Color_BDBDBD, // Grey line for unselected state
                              ),
                            ),
                            // Tabs
                            Align(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: model.tabs.length,
                                itemBuilder: (context, index) {
                                  final isSelected = model.selectedTabIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      model.setSelectedTabIndex(index);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      // margin: EdgeInsets.symmetric(horizontal:index !=0?3.w:0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Tab Text
                                          Text(
                                            model.tabs[index],
                                            style: TextStyle(
                                              fontSize: AppFontSize.fontSize18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppColors.fontFamilySemiBold,
                                              color: isSelected
                                                  ? AppColors.buttonColor
                                                  : AppColors.Color_9E9E9E,
                                            ),
                                          ),
                                          SizedBox(height: 0.8.h),
                                          // Selected Tab Border Overlapping Grey Line
                                          Container(
                                            height: 0.35.h, // Same height as the grey line for overlap
                                            width: 46.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.h),color: isSelected
                                                ? AppColors.buttonColor
                                                : Colors.transparent,),// Width of the underline
                                            // No underline for unselected tabs
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      Center(
                        child: model.selectedTabIndex == 0
                            ?model.generalNotifications.isEmpty?_buildNotifications(): _buildGeneralNotifications(model)
                            : _buildApplicationsNotifications(model),
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

Widget _getNotificationIcon(String title) {
  // Match the title to return appropriate images
  if (title.contains("Security")) {
    return Image.asset("assets/images/ShieldDone.png", height: 3.h, fit: BoxFit.contain);
  } else if (title.contains("Password")) {
    return Image.asset("assets/images/Lock.png", height: 3.h, fit: BoxFit.contain,color: AppColors.buttonColor,);
  } else if (title.contains("Luneta")) {
    return Image.asset("assets/images/TickSquare.png", height: 3.h, fit: BoxFit.contain);
  } else if (title.contains("New")) {
    return Image.asset("assets/images/InfoSquare.png", height: 3.h, fit: BoxFit.contain);
  } else if (title.contains("Account")) {
    return Image.asset("assets/images/Profile.png", height: 3.h, fit: BoxFit.contain);
  } else {
    return Image.asset("assets/images/bellIcon.png", height: 3.h, fit: BoxFit.contain); // Default image for unknown notifications
  }
}

Color _getNotificationBackgroundColor(String title) {
  if (title.contains("Security") || title.contains("Password")) {
    return AppColors.activeFieldBgColor;
  } else if (title.contains("Luneta")) {
    return AppColors.colorNotificationBlue;
  } else if (title.contains("New")) {
    return AppColors.colorRed;
  } else if (title.contains("Account")) {
    return AppColors.colorGreen;
  } else {
    return AppColors.activeFieldBgColor; // Default background color
  }
}

// Helper for General Notifications
Widget _buildGeneralNotifications(NotificationProvider model) {
  return ListView.builder(
    itemCount: model.generalNotifications.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final notification = model.generalNotifications[index];
      // Handle null values with a default fallback
      final title = notification["title"] ?? "Untitled Notification";
      final description = notification["description"] ?? "No description provided.";
      final time = notification["time"] ?? "Unknown Time";
      final isNew = notification["isNew"] ?? false;

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon or Image Avatar
                CircleAvatar(
                  radius: 3.5.h,
                  backgroundColor:_getNotificationBackgroundColor(notification["title"]),
                  child: _getNotificationIcon(notification["title"]),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.Color_212121,
                                fontFamily: AppColors.fontFamilyBold,
                              ),
                            ),
                          ),
                          if (isNew)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              child: Text(
                                "NEW",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.introBackgroundColor,
                                  fontFamily: AppColors.fontFamilySemiBold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      // Date and Time
                      Text(
                        "$time",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.Color_616161,
                          fontFamily: AppColors.fontFamilyMedium,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: FontWeight.w400,
                color: AppColors.Color_424242,
                fontFamily: AppColors.fontFamilyRegular,
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      );
    },
  );
}



// Helper for Applications Notifications
Widget _buildApplicationsNotifications(NotificationProvider model) {
  return ListView.separated(
    itemCount: model.applicationNotifications.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final application = model.applicationNotifications[index];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.h),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1.5.h),
                    margin: EdgeInsets.only(bottom: 4.h,right: 2.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.8.h)),
                        border: Border.all(
                          width: 0.1.h,color: AppColors.Color_EEEEEE,
                        )),
                    child: Image.asset(
                     'assets/images/companyLogo.png',height: 4.h,),),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application["position"]!,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyBold
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          application["company"]!,
                          style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Color_616161,
                              fontFamily: AppColors.fontFamilyMedium
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                          decoration: BoxDecoration(
                            color: application["status"] == "Accepted"
                                ? AppColors.colorGreen
                                : AppColors.cardIconBgColour,
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          child: Text(
                            application["status"] == "Accepted"
                                ? "Application Accepted"
                                : "Application Sent",
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize12,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppColors.fontFamilySemiBold,
                              color: application["status"] == "Accepted"
                                  ? AppColors.successColor
                                  : AppColors.buttonColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h,),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(recentJobs);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 2.h,
                        color: AppColors.Color_616161,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => Divider(
      height: 1.h,
      color: AppColors.Color_EEEEEE,
    ),
  );
}

Widget _buildNotifications() {
  return Container(
    height: 70.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Empty Notification Icon
        Image.asset(
          "assets/images/EmptyNotificationIcon.png",
          height: 34.h, // Adjust height based on your design
          fit: BoxFit.contain,
        ),
        SizedBox(height: 2.h), // Space between image and title
        // Title Text
        Text(
          "Empty",
          style: TextStyle(
            fontSize: AppFontSize.fontSize24, // Responsive font size
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
            fontFamily: AppColors.fontFamilyBold,
          ),
        ),
        SizedBox(height: 1.h), // Space between title and description
        // Subtitle Text
        Text(
          "You don't have any notifications at this time",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppFontSize.fontSize16, // Responsive font size
            fontWeight: FontWeight.w400,
            color: AppColors.Color_212121,
            fontFamily: AppColors.fontFamilyRegular
          ),
        ),
      ],
    ),
  );
}

