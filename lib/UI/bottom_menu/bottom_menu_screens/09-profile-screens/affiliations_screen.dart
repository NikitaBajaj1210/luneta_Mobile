import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luneta/custom-component/customMultiLineTextField.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/affiliations_provider.dart';

class AffiliationsScreen extends StatelessWidget {
  const AffiliationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AffiliationsProvider>(
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
                  // Print all field data
                  // print('Organization: ${provider.organizationController.text}');
                  // print('Role: ${provider.roleController.text}');
                  // print('From Date: ${provider.fromDate != null ? DateFormat("MMMM yyyy").format(provider.fromDate!) : "Not set"}');
                  // print('To Date: ${provider.toDate != null ? DateFormat("MMMM yyyy").format(provider.toDate!) : "Not set"}');
                  // print('Is Current: ${provider.isCurrent}');
                  // print('Description: ${provider.descriptionController.text}');
                  // final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);
                  //
                  // // Validate required fields
                  // if (provider.organizationController.text.isEmpty ||
                  //     provider.roleController.text.isEmpty ||
                  //     provider.fromDate == null) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Please fill in all required fields')),
                  //   );
                  //   return;
                  // }
                  //
                  // // Format the display date
                  // String displayDate = provider.isCurrent
                  //     ? "${DateFormat('MMM yyyy').format(provider.fromDate!)} - Present"
                  //     : "${DateFormat('MMM yyyy').format(provider.fromDate!)} - ${DateFormat('MMM yyyy').format(provider.toDate!)}";
                  //

                  // Navigate back to profile screen
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
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButtonWithTitle(
                        title: "Affiliations",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                    ],
                  ),
                  SizedBox(height: 2.h),

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

                  _buildLabel("Role"),
                  customTextField(
                    context: context,
                    textColor: AppColors.Color_212121,
                    controller: provider.roleController,
                    focusNode: provider.roleFocusNode,
                    hintText: "Content Writer",
                    textInputType: TextInputType.text,
                    fillColor: provider.roleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    onFieldSubmitted: (value) {
                      provider.roleFocusNode.unfocus();
                    },
                  ),

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

                  Row(
                    children: [
                      Text("Current",style: TextStyle(color: AppColors.Color_212121,fontFamily: AppColors.fontFamilyMedium,fontWeight: FontWeight.w500,fontSize: AppFontSize.fontSize16),),
                      Container(
                        padding: EdgeInsets.only(left: 1.5.w),
                        child: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: provider.isCurrent,
                            onChanged: (value) {
                              provider.isCurrent = value;
                            },
                            activeColor: Color(0xFF6B7280),
                            trackColor: Color(0xFFE5E7EB),
                          ),
                        ),
                      ),
                    ],
                  ),

                  _buildLabel("Description (Optional)"),
                  customMultilineTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
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
                    onFieldSubmitted: (String ) {  },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h, top: 2.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w500,
          color: AppColors.Color_212121,
          fontFamily: AppColors.fontFamilyMedium,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, DateTime? date, VoidCallback onTap, String hint) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43.w,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: AppColors.Color_FAFAFA,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('MMM yyyy').format(date) : hint,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                color: date != null ? AppColors.Color_212121 : AppColors.Color_616161,
                fontFamily: AppColors.fontFamilyMedium,
              ),
            ),
            Image.asset(
              "assets/images/dropdownIcon.png",
              height: 2.h,
              color: AppColors.buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
