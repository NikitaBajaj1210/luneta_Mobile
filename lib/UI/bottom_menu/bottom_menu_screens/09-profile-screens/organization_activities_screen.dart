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
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/organization_activities_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class OrganizationActivitiesScreen extends StatefulWidget {
  const OrganizationActivitiesScreen({super.key});

  @override
  State<OrganizationActivitiesScreen> createState() => _OrganizationActivitiesScreenState();
}

class _OrganizationActivitiesScreenState extends State<OrganizationActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizationActivitiesProvider>(
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
                  // Validate required fields
                  if (provider.organizationController.text.isEmpty ||
                      provider.roleController.text.isEmpty ||
                      provider.fromDate == null ||
                      (!provider.stillMember && provider.toDate == null)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all required fields')),
                    );
                    return;
                  }

                  final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);

                  // Add organization activity to profile
                  // profileProvider.addOrganizationActivity(
                  //   organization: provider.organizationController.text,
                  //   role: provider.roleController.text,
                  //   fromDate: provider.fromDate!,
                  //   toDate: provider.stillMember ? DateTime.now() : provider.toDate!,
                  //   stillMember: provider.stillMember,
                  //   description: provider.descriptionController.text,
                  // );

                  Navigator.pop(context); // Go back after saving
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
                  /// **Header with Back and Delete Icon**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButtonWithTitle(
                        title: "Organization Activities",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                    ],
                  ),

                  /// **Organization**
                  _buildLabel("Organization"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.organizationController,
                    focusNode: provider.organizationFocusNode,
                    hintText: "Reddit United States",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.organizationFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (value) {
                      provider.organizationFocusNode.unfocus();
                    },
                  ),

                  /// **Role**
                  _buildLabel("Role"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.roleController,
                    focusNode: provider.roleFocusNode,
                    hintText: "Community Officer",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.roleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (value) {
                      provider.roleFocusNode.unfocus();
                    },
                  ),

                  /// **From - To (Date Selection)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("From"),
                          _buildDateField(context, provider.fromDate, () => provider.pickDate(context, true), "March 2021"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("To"),
                          _buildDateField(context, provider.toDate, () => provider.pickDate(context, false), "April 2022"),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h,),
                  /// **Still a Member (Checkbox)**
                  GestureDetector(
                    onTap: () {
                      provider.stillMember = !provider.stillMember;
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 2.6.h,
                          width: 2.6.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: provider.stillMember ? AppColors.buttonColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(0.8.h),
                            border: Border.all(color: AppColors.buttonColor, width: 2),
                          ),
                          child: provider.stillMember
                              ? Image.asset("assets/images/tickIcon.png", scale: 0.5.h)
                              : Container(),
                        ),
                        SizedBox(width: 4.w),
                        Text("Still a member", style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppColors.fontFamilySemiBold,
                          color: AppColors.Color_212121
                        )),
                      ],
                    ),
                  ),

                  /// **Description**
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
                    onFieldSubmitted: (value) {
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

  /// **🔹 Helper Methods**
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w, top: 2.h),
      child: Text(
        text,
        style: TextStyle( fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w500,
          fontFamily: AppColors.fontFamilyMedium,
          color: AppColors.Color_424242,),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, DateTime? date, VoidCallback onTap, String hintText) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
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
