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
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/seminars_trainings_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class SeminarsTrainingsScreen extends StatefulWidget {
  const SeminarsTrainingsScreen({super.key});

  @override
  State<SeminarsTrainingsScreen> createState() => _SeminarsTrainingsScreenState();
}

class _SeminarsTrainingsScreenState extends State<SeminarsTrainingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeminarsTrainingsProvider>(
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
                  if (provider.topicController.text.isEmpty ||
                      provider.organizerController.text.isEmpty ||
                      provider.fromDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all required fields')),
                    );
                    return;
                  }

                  // Format the display date
                  String displayDate = provider.currentlyOngoing
                      ? "${provider.organizerController.text} · ${DateFormat('MMM yyyy').format(provider.fromDate!)} - Present"
                      : "${provider.organizerController.text} · ${DateFormat('MMM yyyy').format(provider.fromDate!)} - ${DateFormat('MMM yyyy').format(provider.toDate!)}";

                  // Add seminar/training to profile provider
                  // profileProvider.addSeminarTraining(
                  //   title: provider.topicController.text,
                  //   organization: provider.organizerController.text,
                  //   displayDate: displayDate,
                  //   description: provider.descriptionController.text,
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
                  /// **Header with Back Button and Delete Icon**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButtonWithTitle(
                        title: "Seminars & Trainings",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24),
                      ),
                    ],
                  ),

                  /// **Topic**
                  _buildLabel("Topic"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.topicController,
                    focusNode: provider.topicFocusNode,
                    hintText: "App Developer Training",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.topicFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.topicFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.organizerFocusNode);
                    },
                  ),

                  /// **Organizer**
                  _buildLabel("Organizer"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.organizerController,
                    focusNode: provider.organizerFocusNode,
                    hintText: "Apple Academy",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: provider.organizerFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {
                      provider.organizerFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(provider.descriptionFocusNode);
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
                          _buildDateField(context, provider.fromDate, () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: provider.fromDate ?? DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != provider.fromDate) {
                              provider.setFromDate(picked);
                            }
                          }, "May 2021"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("To"),
                          _buildDateField(context, provider.toDate, () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: provider.toDate ?? DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != provider.toDate) {
                              provider.setToDate(picked);
                            }
                          }, "To", enabled: !provider.currentlyOngoing),
                        ],
                      ),
                    ],
                  ),

                  /// **Current (Toggle)**
                  Row(
                    children: [
                      Text(
                        "Current",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.Color_212121,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 1.5.w),
                        child: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: provider.currentlyOngoing,
                            onChanged: (value) {
                              provider.currentlyOngoing = value;
                            },
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

  Widget _buildDateField(BuildContext context, DateTime? date, VoidCallback onTap, String hintText, {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
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
                fontFamily: date == null ? AppColors.fontFamilyRegular : AppColors.fontFamilySemiBold,
              ),
            ),
            // DropDown Icon
            Image.asset("assets/images/dropdownIcon.png", height: 2.2.h, color: AppColors.Color_212121),
          ],
        ),
      ),
    );
  }
}
