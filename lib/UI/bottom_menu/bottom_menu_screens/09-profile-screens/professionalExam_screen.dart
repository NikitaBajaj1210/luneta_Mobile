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
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_exam_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ProfessionalExamScreen extends StatelessWidget {
  const ProfessionalExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalExamProvider>(
      builder: (context, provider, child) {
        return Scaffold(
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
                if (provider.titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter title')),
                  );
                  return;
                }
                if (provider.scoreController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter score')),
                  );
                  return;
                }
                if (provider.dateTaken == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select date')),
                  );
                  return;
                }

                // Get profile provider and save data
                // final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);
                // profileProvider.addProfessionalExam(
                //   examName: provider.titleController.text,
                //   score: provider.scoreController.text,
                //   date: DateFormat('MMMM yyyy').format(provider.dateTaken!),
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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButtonWithTitle(
                    title: "Professional Exams",
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
                    hintText: "IELTS Official Test",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.titleFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.titleFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.scoreFocusNode);
                    },
                  ),
                  _buildLabel("Score"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.scoreController,
                    focusNode: provider.scoreFocusNode,
                    hintText: "7.5/9.0",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.scoreFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.scoreFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.descriptionFocusNode);
                    },
                  ),
                  _buildLabel("Date Taken"),
                  _buildDateField(
                    context,
                    provider.dateTaken,
                    (BuildContext context) async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: provider.dateTaken ?? DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != provider.dateTaken) {
                        provider.dateTaken = picked;
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
