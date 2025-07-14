import 'package:flutter/material.dart';
import 'package:luneta/const/color.dart';
import 'package:luneta/provider/job-details-application-provider/job_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../const/font_size.dart';
import '../../../custom-component/customTextField.dart';
import '../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/home_screen_provider.dart';
import '../../../route/route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenProvider(),
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return Container(
            width: 100.w,
            color: AppColors.Color_FFFFFF,
            // height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w,),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 1.h,),
                  // Header with Profile and Notification
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 3.2.h,
                            backgroundImage: const AssetImage(
                                'assets/images/profileImg.png'), // Replace with actual image path
                          ),
                          SizedBox(width: 2.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning 👋",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppColors.fontFamilyRegular,
                                  color: AppColors.Color_757575,
                                ),
                              ),
                              Text(
                                provider.userName,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppColors.fontFamilyBold,
                                  color: AppColors.Color_212121
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(notification);
                        },
                        child: Container(
                          padding: EdgeInsets.all(1.8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.h)),
                            border: Border.all(
                                width: 0.1.h, color: AppColors.Color_EEEEEE),
                          ),
                          child: Image.asset(
                            "assets/images/bellIcon.png",
                            height: 2.5.h,
                            width: 2.5.h,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 1.9.h),
                  customTextField(
                    context: context,
                    focusNode: provider.searchFocusNode,
                    controller: provider.searchController,
                    hintText: 'Search for a job or company',
                    textInputType: TextInputType.name,
                    obscureText: false,
                    voidCallback: (_) {},
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize14,
                    iconSize: AppFontSize.fontSize20,
                    backgroundColor: provider.searchFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.bottomNavBorderColor,
                    borderColor: AppColors.buttonColor,
                    textColor: AppColors.Color_212121,
                    labelColor: AppColors.Color_9E9E9E,
                    cursorColor: AppColors.buttonColor,
                    fillColor: provider.searchFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.bottomNavBorderColor,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pushNamed(searchScreen);
                    },
                    suffixIcon: Image.asset("assets/images/Filter.png",
                      width: 2.h,
                      height: 2.h,
                      color: provider.searchFocusNode.hasFocus
                          ? AppColors.buttonColor
                          : (provider.searchController.text.isNotEmpty
                          ? AppColors.Color_212121
                          : AppColors.Color_BDBDBD),),
                    onSuffixIconPressed: () {},
                    prefixIcon: Image.asset(
                        "assets/images/Search.png",
                      width: 2.h,
                      height: 2.h,
                      color: provider.searchFocusNode.hasFocus
                          ? AppColors.buttonColor
                          : (provider.searchController.text.isNotEmpty
                          ? AppColors.Color_212121
                          : AppColors.Color_BDBDBD),
                    ),
                    onPrefixIconPressed: () {
                      // Handle prefix icon press if needed
                    },
                  ),
                  Container(
                    height: 22.h,
                    width: 100.w,
                    margin: EdgeInsets.only(top: 1.9.h,bottom: 1.9.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.buttonBorderColor.withOpacity(0.25),
                          blurRadius: 24,
                          offset: Offset(4, 8),
                          spreadRadius: 0,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage("assets/images/homeCard.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "We are here to \n\ assist you!",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.Color_FFFFFF,
                              fontFamily: AppColors.fontFamilyBold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                            margin: EdgeInsets.only(top: 1.h),
                            decoration: BoxDecoration(
                              color: AppColors.Color_FFFFFF,
                              borderRadius: BorderRadius.circular(50.h)
                            ),
                            child: Text(
                              "Chat Now",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonColor,
                                fontFamily: AppColors.fontFamilySemiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommendation",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyBold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.increaseVisibleRecommendations(); // Call to increase visible recommendations
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.buttonColor,
                            fontFamily: AppColors.fontFamilyBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.9.h),
                  // Recommendation List
                  Container(
                    height: 28.h,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: provider.visibleRecommendations.length, // Use visibleRecommendations
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (contextList, index) {
                        final item = provider.visibleRecommendations[index]; // Use visibleRecommendations
                        return Padding(
                          padding: EdgeInsets.only(right:5.w), // Adjust spacing between cards
                          child: GestureDetector(
                            onTap: (){
                              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              //   Provider
                              //       .of<JobDetailsProvider>(context, listen: false)
                              //       .jobTitle = provider.visibleRecommendations[index]['jobTitle'].toString();
                              //   Provider
                              //       .of<JobDetailsProvider>(context, listen: false)
                              //       .companyName = provider.visibleRecommendations[index]['companyName'].toString();
                              //   Provider
                              //       .of<JobDetailsProvider>(context, listen: false)
                              //       .salaryRange = provider.visibleRecommendations[index]['salaryRange'].toString();
                              // });
                              // Navigator.of(context).pushNamed(jobDetails);
                              Navigator.of(context).pushNamed(
                                jobDetails,
                                arguments: {
                                  'jobTitle': item['jobTitle'].toString(),
                                  'companyName': item['companyName'].toString(),
                                  'salaryRange': item['salaryRange'].toString(),
                                },
                              );
                              // Provider.of<JobDetailsProvider>(context,listen: false).jobTitle =  provider.visibleRecommendations[index]['jobTitle'];
                              // Provider.of<JobDetailsProvider>(context,listen: false).companyName = provider.visibleRecommendations[index]['companyName'];
                              // Provider.of<JobDetailsProvider>(context,listen: false).salaryRange = provider.visibleRecommendations[index]['salaryRange'];
                              // Provider.of<JobDetailsProvider>(context,listen: false).jobTitle =  provider.visibleRecommendations[index]['jobTitle'];
                              // // Navigator.of(context).pushNamed(jobDetails);
                              // Navigator.of(context).pushNamed(jobDetails,arguments: {
                              // 'jobTitle': item['jobTitle'].toString(),'companyName':item['companyName'].toString(),
                              //   'salaryRange':item['salaryRange'].toString()
                              // },);
                            },
                            child: Container(
                              width: 86.w, // Set width to 90% of screen width
                              padding: EdgeInsets.all(2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.Color_EEEEEE, width: 0.5),
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
                                            _buildTag(item['requirements']),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 1.9.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Jobs",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyBold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.increaseVisibleRecommendations(); // Call to increase visible recommendations
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.buttonColor,
                            fontFamily: AppColors.fontFamilyBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.9.h),
                  SizedBox(
                    height: 5.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.recentJobs.length,
                      // physics: NeverScrollableScrollPhysics(),
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
                                  : Colors.white,
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
                  SizedBox(height: 1.9.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.visibleRecommendations.length, // Use visibleRecommendations
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = provider.visibleRecommendations[index]; // Use visibleRecommendations
                      return Padding(
                        padding: EdgeInsets.only(bottom:5.w), // Adjust spacing between cards
                        child: GestureDetector(
                          onTap: (){
                            // Navigator.of(context).pushNamed(jobDetails,arguments: {
                            //   'jobTitle': item['jobTitle'].toString(),'companyName':item['companyName'].toString(),
                            //   'salaryRange':item['salaryRange'].toString()
                            // },);
                            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            //   Provider
                            //       .of<JobDetailsProvider>(context, listen: false)
                            //       .jobTitle = item['jobTitle'].toString();
                            //   Provider
                            //       .of<JobDetailsProvider>(context, listen: false)
                            //       .companyName = item['companyName'].toString();
                            //   Provider
                            //       .of<JobDetailsProvider>(context, listen: false)
                            //       .salaryRange = item['salaryRange'].toString();
                            // });
                            // Navigator.of(context).pushNamed(jobDetails );
                            Navigator.of(context).pushNamed(
                              jobDetails,
                              arguments: {
                                'jobTitle': item['jobTitle'].toString(),
                                'companyName': item['companyName'].toString(),
                                'salaryRange': item['salaryRange'].toString(),
                              },
                            );
                          },
                          child: Container(
                            width: 100.w, // Set width to 90% of screen width
                            padding: EdgeInsets.all(2.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.Color_EEEEEE, width: 0.5),
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
                                          _buildTag(item['requirements']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.8.h)),
          border: Border.all(
            width: 0.1.h,color: AppColors.Color_757575,
          )),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppFontSize.fontSize10,
          fontWeight: FontWeight.w600,
          color: AppColors.Color_757575,
          fontFamily: AppColors.fontFamilySemiBold
        ),
      ),
    );
  }
}
