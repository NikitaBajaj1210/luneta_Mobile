import 'package:flutter/cupertino.dart';
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
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/volunteering_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class VolunteeringScreen extends StatefulWidget {
  const VolunteeringScreen({super.key});

  @override
  State<VolunteeringScreen> createState() => _VolunteeringScreenState();
}

class _VolunteeringScreenState extends State<VolunteeringScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<VolunteeringProvider, ProfileBottommenuProvider>(
      builder: (context, provider, profileProvider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.Color_FFFFFF,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: backButtonWithTitle(
                title: "Volunteering Experience",
                onBackPressed: () => Navigator.pop(context),
              ),
            ),
            bottomNavigationBar: Container(
              height: 11.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
              ),
              child: customButton(
                voidCallback: () {
                  if (provider.titleController.text.trim().isEmpty ||
                      provider.organizationController.text.trim().isEmpty ||
                      provider.fromDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all required fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Format dates
                  final startDate = DateFormat('MMM yyyy').format(provider.fromDate!);
                  final endDate = provider.currentlyWorking 
                      ? null 
                      : provider.toDate != null 
                          ? DateFormat('MMM yyyy').format(provider.toDate!)
                          : null;

                  // Add volunteering to profile provider
                  // profileProvider.addVolunteering(
                  //   title: provider.titleController.text.trim(),
                  //   organization: provider.organizationController.text.trim(),
                  //   startDate: startDate,
                  //   endDate: endDate,
                  //   currentlyWorking: provider.currentlyWorking,
                  //   role: provider.roleController.text.trim(),
                  //   description: provider.descriptionController.text.trim(),
                  //   websiteUrl: provider.websiteController.text.trim(),
                  // );

                  // Navigate back
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
                  /// **Title**
                  _buildLabel("Title"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.titleController,
                    focusNode: provider.titleFocusNode,
                    hintText: "Nature Expedition",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (String) {
                      provider.titleFocusNode.unfocus();
                    },
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
                    hintText: "Nature Lovers Organization",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (String) {
                      provider.organizationFocusNode.unfocus();
                    },
                  ),

                  /// **Role (Optional)**
                  _buildLabel("Role (Optional)"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.roleController,
                    focusNode: provider.roleFocusNode,
                    hintText: "Role",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (String) {
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
                          _buildDateField(context, provider.fromDate, () => provider.pickDate(context, true), "May 2022"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("To"),
                          _buildDateField(context, provider.toDate, () => provider.pickDate(context, false), "July 2022"),
                        ],
                      ),
                    ],
                  ),

                  /// **Current (Toggle)**
                  Row(
                    children: [
                      Text("Current",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 1.5.w),
                        child: Transform.scale(
                          scale: 0.7, // Adjust this value to decrease the size (0.7 = 70% of original size)
                          child: CupertinoSwitch(
                            value: provider.currentlyWorking,
                            onChanged: (value) => provider.toggleCurrentlyWorking(value),
                            activeColor: Color(0xFF6B7280),
                            trackColor: Color(0xFFE5E7EB),
                          ),
                        ),
                      ),
                    ],
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
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (String) {},
                  ),

                  _buildLabel("Link to Organization Website (Optional)"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.websiteController,
                    focusNode: provider.websiteFocusNode,
                    hintText: "URL Link",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (String) {
                      provider.websiteFocusNode.unfocus();
                    },
                  ),
                ],
              ),
            ),
        ));
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
                fontFamily: date == null ? AppColors.fontFamilyRegular:AppColors.fontFamilySemiBold
              ),
            ),
            Image.asset("assets/images/dropdownIcon.png", height: 2.2.h, color: AppColors.Color_212121),
          ],
        ),
      ),
    );
  }
}
