import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/education_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customMultiLineTextField.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/profile_bottommenu_provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EducationScreenProvider>(
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
                    if (provider.schoolController.text.isNotEmpty &&
                        provider.courseController.text.isNotEmpty &&
                        provider.fromDate != null) {
                      
                      // Get the profile provider
                      final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);
                      
                      // Format dates for display
                      final startDate = provider.fromDate != null ? 
                          DateFormat('MM/yyyy').format(provider.fromDate!) : '';
                      
                      String formattedEndDate;
                      if (provider.currentlyWorking) {
                        formattedEndDate = 'Present';
                      } else if (provider.toDate != null) {
                        formattedEndDate = DateFormat('MM/yyyy').format(provider.toDate!);
                      } else {
                        formattedEndDate = '';
                      }

                      // Prepare education data
                      Map<String, dynamic> educationData = {
                        'degree': provider.selectedDegree,
                        'course': provider.courseController.text,
                        'school': provider.schoolController.text,
                        'startDate': startDate,
                        'endDate': formattedEndDate,
                        'gpa': provider.gpaController.text.isNotEmpty ? provider.gpaController.text : null,
                        'scale': provider.gpaController.text.isNotEmpty ? provider.selectedScale : null,
                        'description': provider.descriptionController.text.isNotEmpty ? provider.descriptionController.text : null,
                      };

                      // Check if we're editing an existing entry
                      // if (provider.editingIndex != null) {
                      //   // Update existing education
                      //   profileProvider.updateEducation(provider.editingIndex!, educationData);
                      // } else {
                      //   // Add new education
                      //   profileProvider.addEducation(
                      //     degree: provider.selectedDegree,
                      //     course: provider.courseController.text,
                      //     school: provider.schoolController.text,
                      //     startDate: startDate,
                      //     endDate: formattedEndDate,
                      //     gpa: provider.gpaController.text.isNotEmpty ? provider.gpaController.text : null,
                      //     scale: provider.gpaController.text.isNotEmpty ? provider.selectedScale : null,
                      //     description: provider.descriptionController.text.isNotEmpty ? provider.descriptionController.text : null,
                      //   );
                      // }
                      
                      // Mark education section as completed
                      // profileProvider.setSectionStatus('Education', true);

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
                          title: "Education",
                          onBackPressed: () => Navigator.pop(context),
                        ),
                        GestureDetector(
                            onTap: (){
                            },
                            child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                      ],
                    ),
                    _buildLabel("Educational Attainment"),
                    _buildDropdown(provider.selectedDegree, provider.degrees, provider.setDegree),
                    _buildLabel("Course"),
                    customTextField(
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      textColor: AppColors.Color_212121,
                      context: context,
                      controller: provider.courseController,
                      focusNode: provider.courseFocusNode,
                      hintText: "Course",
                      textInputType: TextInputType.text,
                      voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                      fillColor: provider.courseFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        provider.courseFocusNode.unfocus();
                      },
                    ),
                    _buildLabel("School"),
                    customTextField(
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      textColor: AppColors.Color_212121,
                      context: context,
                      controller: provider.schoolController,
                      focusNode: provider.schoolFocusNode,
                      hintText: "School",
                      textInputType: TextInputType.text,
                      voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                      fillColor: provider.schoolFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {
                        provider.schoolFocusNode.unfocus();
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


                    SizedBox(
                    height: 8.h,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Graduated", style: TextStyle(fontSize: AppFontSize.fontSize16, color: AppColors.Color_212121,fontFamily: AppColors.fontFamilyMedium,fontWeight: FontWeight.w500),),
                          Container(
                            padding: EdgeInsets.only(left: 1.5.w),
                            child: Transform.scale(
                              scale: 0.7, // Adjust this value to decrease the size (0.7 = 70% of original size)
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
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabel("GPA (Optional)"),
                        ),
                        Expanded(
                          child: _buildLabel("Scale"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                            fontSize: AppFontSize.fontSize16,
                            inputFontSize: AppFontSize.fontSize16,
                            textColor: AppColors.Color_212121,
                            context: context,
                            controller: provider.gpaController,
                            focusNode: provider.gpaFocusNode,
                            hintText: "GPA",
                            textInputType: TextInputType.numberWithOptions(decimal: true),
                            voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                            fillColor: provider.gpaFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA,
                            onFieldSubmitted: (String) {
                              provider.gpaFocusNode.unfocus();
                            },
                          ),
                        ),
                        SizedBox(width: 4.w,),
                        Expanded(
                          child: _buildDropdown(provider.selectedScale, provider.scale, provider.setScale),
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
                      maxLines: 5, fillColor: provider.descriptionFocusNode.hasFocus
                        ? AppColors.activeFieldBgColor
                        : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    _buildLabel("Add Media (Optional)"),
                    _buildFileUploadBox(provider),

                    SizedBox(height: 2.h),
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
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w,top: 2.h),
      child: Text(text, style:
      TextStyle(fontSize: AppFontSize.fontSize16, fontWeight: FontWeight.w500,fontFamily: AppColors.fontFamilyMedium,color: AppColors.Color_424242)),
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String) onChanged,
     ) {
    return Container(
      // height: 7.5.h,
      // // width: width,
      padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 4.w),

      decoration: BoxDecoration(
        color: AppColors.Color_FAFAFA,
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          icon: Image.asset("assets/images/dropdownIcon.png", height: 2.5.h),
          value: value,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(fontSize: AppFontSize.fontSize16,fontFamily: AppColors.fontFamilySemiBold,fontWeight: FontWeight.w600,color: AppColors.Color_212121)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }

  Widget _buildFileUploadBox(EducationScreenProvider provider) {
    return GestureDetector(
      onTap: () async {
        await provider.pickPdfFile();
      },
      child: provider.isUploading
          ? DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        dashPattern: [10, 10],
        color: AppColors.Color_BDBDBD,
        strokeWidth: 1,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.h),
            color: AppColors.Color_FAFAFA,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.hexagonDots(
                color: AppColors.buttonColor,
                size: 5.h,
              ),
              SizedBox(height: 2.h),
              Text(
                "Uploading...",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buttonColor,
                ),
              ),
            ],
          ),
        ),
      )
          : provider.fileName != null
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.colorRed,
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Row(
          children: [
            Image.asset("assets/images/pdfIcon.png", height: 5.h),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.fileName!,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.Color_424242,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    provider.fileSize,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize12,
                      color: AppColors.Color_424242.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: provider.removeFile,
              child: Icon(
                Icons.close,
                color: AppColors.errorRedColor,
                size: 2.5.h,
              ),
            ),
          ],
        ),
      )
          : DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        dashPattern: [10, 10],
        color: AppColors.Color_BDBDBD,
        strokeWidth: 1,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.h),
            color: AppColors.Color_FAFAFA,
          ),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/Upload.png",height: 5.h,),
                Text(
                  "Browse File",
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonColor,
                  ),
                ),
              ],
            ),
          ),
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
            // Date Text
            Text(
              date != null ? DateFormat("MMMM yyyy").format(date) : hintText,
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: date == null ? FontWeight.w400 : FontWeight.w600,
                color: date == null ? AppColors.Color_9E9E9E : AppColors.Color_212121,
                fontFamily: date == null ? AppColors.fontFamilyRegular : AppColors.fontFamilySemiBold,
              ),
            ),
            // Dropdown Icon
            Image.asset("assets/images/dropdownIcon.png",height: 2.2.h,color: AppColors.Color_212121,),
          ],
        ),
      ),
    );
  }

}