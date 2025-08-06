import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customMultiLineTextField.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/awards_achievements_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class AwardsAchievementsScreen extends StatelessWidget {
  const AwardsAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AwardsAchievementsProvider>(
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
                  final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);

                  // Validate required fields
                  if (provider.titleController.text.isEmpty ||
                      provider.issuerController.text.isEmpty ||
                      provider.dateAwarded == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all required fields')),
                    );
                    return;
                  }

                  // Add award to profile
                  // profileProvider.addAward(
                  //   title: provider.titleController.text,
                  //   issuer: provider.issuerController.text,
                  //   date: DateFormat('MMMM yyyy').format(provider.dateAwarded!),
                  // );

                  Navigator.pop(context);
                },
                buttonText: "Save",
                width: 90.w,
                height: 5.h,
                color: AppColors.buttonColor,
                buttonTextColor: AppColors.buttonTextWhiteColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize18,
                showShadow: true,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButtonWithTitle(
                    title: "Awards & Achievements",
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  _buildLabel("Title"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.titleController,
                    focusNode: provider.titleFocusNode,
                    hintText: "Best Employee of the Year",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.titleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.titleFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.issuerFocusNode);
                    },
                  ),
                  _buildLabel("Issuer"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.issuerController,
                    focusNode: provider.issuerFocusNode,
                    hintText: "Company Name",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.issuerFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.issuerFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.descriptionFocusNode);
                    },
                  ),
                  _buildLabel("Date Awarded"),
                  _buildDateField(
                    context,
                    provider.dateAwarded,
                    (BuildContext context) async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: provider.dateAwarded ?? DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 100),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != provider.dateAwarded) {
                        provider.dateAwarded = picked;
                        provider.notifyListeners();
                      }
                    },
                    "February 2022",
                  ),
                  _buildLabel("Description (Optional)"),
                  customMultilineTextField(
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.descriptionController,
                    focusNode: provider.descriptionFocusNode,
                    hintText: "Description",
                    textInputType: TextInputType.multiline,
                    validator: (value) => null,
                    maxLines: 5,
                    fillColor: provider.descriptionFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.descriptionFocusNode.unfocus();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// **✅ Method to Build Labels**
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w, top: 2.h),
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

  /// **✅ Method to Build Date Field**
  Widget _buildDateField(BuildContext context, DateTime? date, Function(BuildContext) onTap, String hintText) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.Color_FAFAFA,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat("MMMM yyyy").format(date) : hintText,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: date == null ? FontWeight.w400 : FontWeight.w600,
                color: date == null ? AppColors.Color_9E9E9E : AppColors.Color_212121,
              ),
            ),
            Image.asset("assets/images/dropdownIcon.png", height: 2.2.h, color: AppColors.Color_212121),
          ],
        ),
      ),
    );
  }
}
