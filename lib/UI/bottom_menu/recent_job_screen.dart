import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/provider/bottom_menu_provider/recent_job_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../custom-component/back_button_with_title.dart';
class RecentJobScreen extends StatefulWidget {
  const RecentJobScreen({super.key});

  @override
  State<RecentJobScreen> createState() => _RecentJobScreenState();
}

class _RecentJobScreenState extends State<RecentJobScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecentJobProvider(),
      child: Consumer<RecentJobProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Container(
                width: 100.w,
                height: 100.h,
                color: AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backButtonWithTitle(
                          title: "Recent Jobs",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Image.asset(
                            "assets/images/Search.png",
                            height: 2.5.h,
                            color: AppColors.Color_212121,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 5.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.recentJobs.length,
                        itemBuilder: (context, index) {
                          final job = provider.recentJobs[index];
                          final isSelected = provider.selectedJobIndex == index;
                          return GestureDetector(
                            onTap: () {
                              provider.updateSelectedJob(index); // Update selection
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 3.w),
                              padding: EdgeInsets.symmetric(horizontal: 4.w, ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.buttonColor
                                    : AppColors.Color_FFFFFF,
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  job,
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppColors.fontFamilySemiBold,
                                    color: isSelected
                                        ? AppColors.introBackgroundColor
                                        : AppColors.buttonColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.visibleRecommendations.length, // Use visibleRecommendations
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final item = provider.visibleRecommendations[index]; // Use visibleRecommendations
                          return Padding(
                            padding: EdgeInsets.only(bottom:5.w), // Adjust spacing between cards
                            child: Container(
                              width: 100.w, // Set width to 90% of screen width
                              padding: EdgeInsets.all(2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.Color_EEEEEE, width: 0.1.h),
                                color: AppColors.Color_FFFFFF,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(1.5.h),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
                                                color: AppColors.Color_FFFFFF,
                                                border: Border.all(
                                                  width: 0.1.h,color: AppColors.Color_EEEEEE,
                                                )),
                                            child: Image.asset(
                                              item["companyLogo"],height: 4.h,),),
                                          SizedBox(width: 2.w),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['jobTitle'],
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: AppColors.fontFamilyBold,
                                                  color: AppColors.Color_212121,
                                                ),
                                              ),
                                              Text(
                                                item['companyName'],
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.Color_616161,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        child:
                                        item['isSaved'] ? Image.asset("assets/images/saveInactive.png",height: 2.5.h,color: AppColors.buttonColor,):Image.asset("assets/images/saveActive.png",height: 2.5.h),
                                        onTap: () {
                                          provider.toggleSaveStatus(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2.h, bottom: 1.h),
                                    height: 0.05.h,
                                    color: AppColors.Color_EEEEEE,
                                    width: 100.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.h),
                                        Text(
                                          item['jobType'],
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.Color_616161,
                                            fontFamily: AppColors.fontFamilyBold,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          item['salaryRange'],
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.buttonColor,
                                            fontFamily: AppColors.fontFamilyBold,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildTag(item['duration']),
                                            SizedBox(width: 3.w),
                                            item['requirements'] ==null?SizedBox():_buildTag(item['requirements']),
                                          ],
                                        ),
                                      ],
                                    ),
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
            ),
          );
        },
      ),
    );
  }
  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.8.h)),
          border: Border.all(
            width: 0.1.h,color: AppColors.Color_757575,
          )),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppFontSize.fontSize12,
          fontWeight: FontWeight.w500,
          color: AppColors.Color_757575,
        ),
      ),
    );
  }
}
