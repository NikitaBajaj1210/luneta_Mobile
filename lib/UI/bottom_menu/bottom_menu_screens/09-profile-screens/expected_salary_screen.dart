import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/expected_salary_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ExpectedSalaryScreen extends StatefulWidget {
  const ExpectedSalaryScreen({super.key});

  @override
  State<ExpectedSalaryScreen> createState() => _ExpectedSalaryScreenState();
}

class _ExpectedSalaryScreenState extends State<ExpectedSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpectedSalaryProvider, ProfileBottommenuProvider>(
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
                  if (provider.minSalaryController.text.isNotEmpty &&
                      provider.maxSalaryController.text.isNotEmpty) {

                    // Update salary in profile provider
                    // profileProvider.setExpectedSalary(
                    //     min: provider.minSalaryController.text,
                    //     max: provider.maxSalaryController.text,
                    //     frequency: provider.selectedFrequency
                    // );

                    // Mark salary section as completed
                    // profileProvider.setSectionStatus('Expected Salary', true);

                    // Return to profile screen
                    Navigator.pop(context);
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all required fields'),
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
                      title: "Expected Salary",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Minimum Salary
                    _buildLabel("Minimum"),
                    customTextField(
                      context: context,
                      controller: provider.minSalaryController,
                      hintText: "10,000",
                      textInputType: TextInputType.number,
                      borderColor: AppColors.Color_EEEEEE,
                      textColor: AppColors.Color_212121,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      activeFillColor: AppColors.activeFieldBgColor,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.maxSalaryFocusNode);
                        setState(() {

                        });
                      },
                      focusNode: provider.minSalaryFocusNode,
                      voidCallback: (value) {
                        // Here you can handle validation or any other action on field submit
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Maximum Salary
                    _buildLabel("Maximum"),
                    customTextField(
                      context: context,
                      controller: provider.maxSalaryController,
                      hintText: "25,000",
                      textInputType: TextInputType.number,
                      borderColor: AppColors.Color_EEEEEE,
                      textColor: AppColors.Color_212121,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      activeFillColor: AppColors.activeFieldBgColor,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        setState(() {

                        });
                      },
                      focusNode: provider.maxSalaryFocusNode,
                      voidCallback: (value) {
                        // Handle validation or action on field submit
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Currency
                    _buildLabel("Currency"),
                    _buildDropdown(
                      context,
                      provider.selectedCurrency,
                      provider.currencies,
                      provider.setCurrency,
                    ),
                    SizedBox(height: 2.h),

                    // Frequency
                    _buildLabel("Frequency"),
                    _buildDropdown(
                      context,
                      provider.selectedFrequency,
                      provider.frequencies,
                      provider.setFrequency,
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

  /// Builds a label for fields
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w500,
          fontFamily: AppColors.fontFamilyMedium,
          color: AppColors.Color_424242,
        ),
      ),
    );
  }

  /// Builds dropdown with same style as in reference
  Widget _buildDropdown(BuildContext context, String value, List<String> items, Function(String) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.Color_FAFAFA,
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Image.asset("assets/images/dropdownIcon.png", height: 2.5.h),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: AppFontSize.fontSize16),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}
