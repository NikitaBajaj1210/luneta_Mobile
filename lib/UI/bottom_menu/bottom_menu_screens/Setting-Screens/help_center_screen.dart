import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/help_center_provider.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HelpCenterProvider(),
      child: Consumer<HelpCenterProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 1),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button and Title
                      backButtonWithTitle(
                        title: "Help Center",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),

                      // Tabs for FAQ and Contact us
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
                                itemCount: provider.tabs.length,
                                itemBuilder: (context, index) {
                                  final isSelected = provider.selectedTabIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      provider.setSelectedTabIndex(index);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Tab Text
                                          Text(
                                            provider.tabs[index],
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
                                            height: 0.35.h,
                                            width: 46.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.h),color: isSelected
                                                ? AppColors.buttonColor
                                                : Colors.transparent),
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

                      // FAQ Section
                      if (provider.selectedTabIndex == 0)
                        Column(
                          children: [
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
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                            SizedBox(height: 2.h),

                            // Search Field
                            Container(
                              width: 100.w,
                              child: customTextField(
                                context: context,
                                focusNode: provider.searchFocusNode,
                                controller: provider.searchController,
                                hintText: 'Search',
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
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.buttonColor,
                                fillColor: provider.searchFocusNode.hasFocus
                                    ? AppColors.activeFieldBgColor
                                    : AppColors.bottomNavBorderColor,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChange: (value) {
                                  provider.updateSearchQuery(value);
                                },
                                suffixIcon: Image.asset(
                                  "assets/images/Filter.png",
                                  width: 2.h,
                                  height: 2.h,
                                  color: provider.searchFocusNode.hasFocus
                                      ? AppColors.buttonColor
                                      : (provider.searchController.text.isNotEmpty
                                      ? AppColors.Color_212121
                                      : AppColors.Color_BDBDBD),
                                ),
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
                                onPrefixIconPressed: () {},
                              ),
                            ),
                            SizedBox(height: 2.h),

                            // Use Stack to Overlay Search Results on FAQ List
                            Stack(
                              children: [
                                // FAQ List
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: provider.faqItems.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final faqItem = provider.faqItems[index];
                                    return GestureDetector(
                                      onTap: () {
                                        provider.setFaqExpanded(index, !(faqItem["expanded"] == "true"));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                                        margin: EdgeInsets.only(bottom: 1.5.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.Color_FFFFFF,
                                          borderRadius: BorderRadius.circular(2.h),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.dropDownShadow,
                                              blurRadius: 24,
                                              offset: Offset(0, 8),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  faqItem["question"]!,
                                                  style: TextStyle(
                                                    fontSize: AppFontSize.fontSize18,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: AppColors.fontFamilyBold,
                                                    color: AppColors.Color_212121,
                                                  ),
                                                ),
                                                Image.asset(
                                                  "assets/images/dropdownIcon.png",
                                                  height: 2.h,
                                                  color: AppColors.buttonColor,
                                                ),
                                              ],
                                            ),
                                            if (faqItem["expanded"] == "true")
                                              CustomDivider(),
                                            if (faqItem["expanded"] == "true")
                                              SizedBox(
                                                width: 100.w,
                                                child: Text(
                                                  faqItem["answer"]!,
                                                  style: TextStyle(
                                                    fontSize: AppFontSize.fontSize14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: AppColors.fontFamilyMedium,
                                                    color: AppColors.Color_424242,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Search Results (Overlay)
                                if (provider.searchQuery.isNotEmpty)
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.Color_FFFFFF,
                                        borderRadius: BorderRadius.circular(2.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.dropDownShadow,
                                            blurRadius: 24,
                                            offset: Offset(0, 6),
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: provider.searchResults.length,
                                        itemBuilder: (context, index) {
                                          final searchItem = provider.searchResults[index];
                                          return Container(
                                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  searchItem["question"]!,
                                                  style: TextStyle(
                                                    fontSize: AppFontSize.fontSize18,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: AppColors.fontFamilyBold,
                                                    color: AppColors.Color_212121,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Container(
                                            height: 0.01.h,
                                            color: AppColors.Color_EEEEEE,
                                            width: 100.w,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),

                      // Contact Us Section
                      if (provider.selectedTabIndex == 1)
                        Column(
                          children: [
                            SizedBox(height: 2.h),
                            // Contact Us List
                            // Example adjustment to Contact Us List rendering logic
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.contactUsList.length,
                              itemBuilder: (context, index) {
                                final contactItem = provider.contactUsList[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Handle tap actions if necessary
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.Color_FFFFFF,
                                      borderRadius: BorderRadius.circular(2.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.dropDownShadow,
                                          blurRadius: 24,
                                          offset: Offset(0, 8),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // Checking if it's an Icon or an Image
                                        if (contactItem['icon'] is Icon)
                                          contactItem['icon'] as Icon // If it's an Icon, use it directly
                                        else if (contactItem['icon'] is Image)
                                          contactItem['icon'] as Widget, // If it's an image, use it as a Widget
                                        SizedBox(width: 2.w),
                                        Text(
                                          contactItem['name']!,
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: AppColors.fontFamilyBold,
                                            color: AppColors.Color_212121,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )

                          ],
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

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
      height: 0.01.h,
      color: AppColors.Color_757575,
      width: 100.w,
    );
  }
}
