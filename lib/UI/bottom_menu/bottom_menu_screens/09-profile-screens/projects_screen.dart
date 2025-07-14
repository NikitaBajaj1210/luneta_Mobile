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
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/projects_screen_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final String projectLogo = 'assets/images/bagIcon.png';

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
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

  Widget _buildDateField(BuildContext context, DateTime? date, VoidCallback onTap, String hintText) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43.w,
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.4.h),
        decoration: BoxDecoration(
          color: AppColors.Color_FAFAFA,
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('MMM yyyy').format(date) : hintText,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: date == null ? FontWeight.w400 : FontWeight.w600,
                color: date == null ? AppColors.Color_9E9E9E : AppColors.Color_212121,
                fontFamily: date == null ? AppColors.fontFamilyRegular : AppColors.fontFamilyMedium,
              ),
            ),
            Image.asset(
              "assets/images/dropdownIcon.png",
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProjectsProfileScreenProvider, ProfileBottommenuProvider>(
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
                  if (provider.titleController.text.isNotEmpty &&
                      provider.roleController.text.isNotEmpty &&
                      provider.fromDate != null) {
                    
                    // Format dates for display
                    final startDate = provider.fromDate != null ? 
                        DateFormat('MMM yyyy').format(provider.fromDate!) : '';
                    
                    String endDate;
                    if (provider.currentlyWorking) {
                      endDate = 'Present';
                    } else if (provider.toDate != null) {
                      endDate = DateFormat('MMM yyyy').format(provider.toDate!);
                    } else {
                      endDate = '';
                    }

                    // Add project to profile provider
                    // profileProvider.addProject(
                    //   title: provider.titleController.text.trim(),
                    //   role: provider.roleController.text.trim(),
                    //   startDate: startDate,
                    //   endDate: endDate,
                    //   associatedWith: provider.selectedAssociation,
                    //   description: provider.descriptionController.text.trim(),
                    //   projectUrl: provider.projectUrlController.text.trim(),
                    // );
                    //
                    // // Mark section as completed
                    // profileProvider.setSectionStatus('Projects', true);

                    // Print debug info
                    // print('Project added successfully');
                    // print('Projects count: ${profileProvider.projects.length}');

                    // Clear form
                    provider.clearForm();

                    // Navigate back
                    Navigator.of(context).pop();
                  } else {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButtonWithTitle(
                        title: "Project",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle delete
                        },
                        child: Image.asset(
                          "assets/images/Delete.png",
                          height: AppFontSize.fontSize24,
                        ),
                      ),
                    ],
                  ),
                  _buildLabel("Project Title"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.titleController,
                    focusNode: provider.titleFocusNode,
                    hintText: "Project Title",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.titleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.titleFocusNode.unfocus();
                    },
                  ),
                  _buildLabel("Role"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.roleController,
                    focusNode: provider.roleFocusNode,
                    hintText: "Your Role",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.roleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
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
                          _buildDateField(context, provider.fromDate, () => provider.pickDate(context, true), "From"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("To"),
                          _buildDateField(context, provider.toDate, () => provider.pickDate(context, false), "To"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        "Currently Working",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyMedium,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 1.5.w),
                        child: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: provider.currentlyWorking,
                            onChanged: provider.toggleCurrentlyWorking,
                            activeColor: Color(0xFF6B7280),
                            trackColor: Color(0xFFE5E7EB),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildLabel("Associated with (Optional)"),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppColors.Color_FAFAFA,
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: provider.selectedAssociation,
                        hint: Text(
                          "Associated with",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Color_9E9E9E,
                            fontFamily: AppColors.fontFamilyRegular,
                          ),
                        ),
                        isExpanded: true,
                        icon: Image.asset(
                          "assets/images/dropdownIcon.png",
                          height: 2.h,
                        ),
                        items: provider.associationOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.Color_212121,
                                fontFamily: AppColors.fontFamilyRegular,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          provider.setSelectedAssociation(newValue);
                        },
                      ),
                    ),
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
                    maxLines: 5,
                    fillColor: provider.descriptionFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.descriptionFocusNode.unfocus();
                    },
                    validator: (_) {  },
                  ),
                  _buildLabel("Project URL (Optional)"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.projectUrlController,
                    focusNode: provider.projectUrlFocusNode,
                    hintText: "www.yourdomain.com/Project URL/",
                    textInputType: TextInputType.url,
                    fillColor: provider.projectUrlFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.projectUrlFocusNode.unfocus();
                    }, voidCallback: (_) {  },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
