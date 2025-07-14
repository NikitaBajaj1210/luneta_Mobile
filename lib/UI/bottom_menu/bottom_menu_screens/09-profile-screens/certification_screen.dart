import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/certification_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/profile_bottommenu_provider.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CertificationProvider>(
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
                    if (provider.titleController.text.trim().isEmpty ||
                        provider.organizationController.text.trim().isEmpty ||
                        provider.issueDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all required fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Get the profile provider
                    final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);

                    // Prepare certification data
                    Map<String, dynamic> certificationData = {
                      'title': provider.titleController.text.trim(),
                      'organization': provider.organizationController.text.trim(),
                      'issueDate': DateFormat('MMM yyyy').format(provider.issueDate!),
                      'expirationDate': provider.noExpiry 
                          ? null 
                          : provider.expirationDate != null 
                              ? DateFormat('MMM yyyy').format(provider.expirationDate!)
                              : null,
                      'noExpiry': provider.noExpiry,
                      'credentialId': provider.credentialIdController.text.trim(),
                      'credentialUrl': provider.credentialUrlController.text.trim(),
                    };

                    // if (provider.editingIndex != null) {
                    //   // Update existing certification
                    //   profileProvider.updateCertification(provider.editingIndex!, certificationData);
                    // } else {
                    //   // Add new certification
                    //   profileProvider.addCertification(
                    //     title: provider.titleController.text.trim(),
                    //     organization: provider.organizationController.text.trim(),
                    //     issueDate: DateFormat('MMM yyyy').format(provider.issueDate!),
                    //     expirationDate: provider.noExpiry
                    //         ? null
                    //         : provider.expirationDate != null
                    //             ? DateFormat('MMM yyyy').format(provider.expirationDate!)
                    //             : null,
                    //     noExpiry: provider.noExpiry,
                    //     credentialId: provider.credentialIdController.text.trim(),
                    //     credentialUrl: provider.credentialUrlController.text.trim(),
                    //   );
                    // }

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
                    /// **Header with Back Button and Delete Icon**
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backButtonWithTitle(
                          title: "Certification and Licenses",
                          onBackPressed: () => Navigator.pop(context),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                      ],
                    ),

                    /// **Title**
                    _buildLabel("Title"),
                    customTextField(
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      textColor: AppColors.Color_212121,
                      context: context,
                      controller: provider.titleController,
                      focusNode: provider.titleFocusNode,
                      hintText: "UI Designer Professional",
                      textInputType: TextInputType.text,
                      voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                      fillColor: provider.titleFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        FocusScope.of(context).requestFocus(provider.organizationFocusNode);
                      },
                    ),

                    /// **Publishing Organization**
                    _buildLabel("Publishing Organization"),
                    customTextField(
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      textColor: AppColors.Color_212121,
                      context: context,
                      controller: provider.organizationController,
                      focusNode: provider.organizationFocusNode,
                      hintText: "Google Academy",
                      textInputType: TextInputType.text,
                      voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                      fillColor: provider.organizationFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        FocusScope.of(context).requestFocus(provider.credentialIdFocusNode);
                      },
                    ),

                    /// **Date of Issue & Expiration Date**
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Date of Issue"),
                            _buildDateField(
                              context,
                              provider.issueDate,
                              () async {
                                await provider.pickDate(context, true);
                                setState(() {});  // Refresh UI after date selection
                              },
                              "Select Date"
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Expiration Date"),
                            _buildDateField(
                              context,
                              provider.expirationDate,
                              provider.noExpiry ? null : () async {
                                if (provider.issueDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please select Issue Date first'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }
                                await provider.pickDate(context, false);
                                setState(() {});  // Refresh UI after date selection
                              },
                              provider.noExpiry ? "No Expiry" : "Select Date",
                              enabled: !provider.noExpiry
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 2.5.h,),
                    /// Checkbox for "This credential will not expire"
                    _buildCustomCheckbox(context, provider),
                    SizedBox(height: 1.h,),
                    /// **Credential ID**
                    _buildLabel("Credential ID (Optional)"),
                    customTextField(
                      context: context,
                      controller: provider.credentialIdController,
                      focusNode: provider.credentialIdFocusNode,
                      hintText: "Credential ID",
                      textInputType: TextInputType.text,
                      voidCallback: (value) => null,
                      fillColor: provider.credentialIdFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        FocusScope.of(context).requestFocus(provider.credentialUrlFocusNode);
                      },
                      textColor: AppColors.Color_212121
                    ),

                    /// **Credential URL**
                    _buildLabel("Credential URL (Optional)"),
                    customTextField(
                      context: context,
                      controller: provider.credentialUrlController,
                      focusNode: provider.credentialUrlFocusNode,
                      hintText: "Credential URL",
                      textInputType: TextInputType.url,
                      voidCallback: (value) => null,
                      fillColor: provider.credentialUrlFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        FocusScope.of(context).unfocus();
                      },
                      textColor: AppColors.Color_212121
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w, top: 2.h),
      child: Text(text, style: TextStyle(fontSize: AppFontSize.fontSize16, fontWeight: FontWeight.w500, color: AppColors.Color_424242)),
    );
  }
  /// Date Field with Dropdown Icon
  Widget _buildDateField(BuildContext context, DateTime? date, VoidCallback? onTap, String hintText, {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 44.w,
        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: enabled ? AppColors.Color_FAFAFA : AppColors.Color_FAFAFA,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat("MMM yyyy").format(date) : hintText,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                color: date != null ? AppColors.Color_212121 : AppColors.Color_BDBDBD,
                fontFamily: date != null ? AppColors.fontFamilySemiBold : AppColors.fontFamilyRegular,
              ),
            ),
             Image.asset(
              "assets/images/dropdownIcon.png",
              height: 2.2.h,
              color: AppColors.Color_212121,
            ),
          ],
        ),
      ),
    );
  }
  /// Custom Checkbox Widget
  Widget _buildCustomCheckbox(BuildContext context, CertificationProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.toggleNoExpiry();
        setState(() {});  // Refresh UI after toggling
      },
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: provider.noExpiry ? AppColors.buttonColor : AppColors.Color_FFFFFF,
              border: Border.all(
                color: provider.noExpiry ? AppColors.buttonColor : AppColors.buttonColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0.5.h),
            ),
            child: provider.noExpiry
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 3.5.w,
                  )
                : null,
          ),
          SizedBox(width: 2.w),
          Text(
            "This credential does not expire",
            style: TextStyle(
              fontSize: AppFontSize.fontSize16,
              fontWeight: FontWeight.w500,
              fontFamily: AppColors.fontFamilyMedium,
              color: AppColors.Color_212121,
            ),
          ),
        ],
      ),
    );
  }

}
