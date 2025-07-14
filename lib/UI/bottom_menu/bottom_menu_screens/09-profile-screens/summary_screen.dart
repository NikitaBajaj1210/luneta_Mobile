import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customMultiLineTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/Summary_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  Widget build(BuildContext context) {
    return Consumer2<SummaryProvider, ProfileBottommenuProvider>(
      builder: (context, provider, profileProvider, child) {
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
                  if (provider.summaryController.text.isNotEmpty) {
                    // Update summary in profile provider
                    // profileProvider.setSummary(provider.summaryController.text);
                    
                    // Mark summary section as completed
                    // profileProvider.setSectionStatus('Summary', true);
                    
                    // Return to profile screen
                    Navigator.pop(context);
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in the summary field'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
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
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Title
                    backButtonWithTitle(
                      title: "Summary",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Summary (Max. ${provider.maxCharacters} characters)",
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppColors.fontFamilyMedium,
                        color: AppColors.Color_424242,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    customMultilineTextField(
                      maxLines:15,
                      context: context,
                      controller: provider.summaryController,
                      hintText: "Write your summary here...",
                      textInputType: TextInputType.multiline,
                      validator: (value) =>
                      value!.isEmpty ? "This field cannot be empty" : null,
                      borderColor:provider.summaryFocusNode.hasFocus?AppColors.buttonColor:AppColors.Color_EEEEEE,
                      textColor: AppColors.Color_212121,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.summaryFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      focusNode: provider.summaryFocusNode,
                      maxLength: provider.maxCharacters,
                      width: 100.w, // Make it fully responsive
                      onChange: (text) => provider.updateSummary(text),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
