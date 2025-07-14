import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customMultiLineTextField.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/work_experience_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/profile_bottommenu_provider.dart';

class WorkExperienceScreen extends StatefulWidget {
  const WorkExperienceScreen({super.key});

  @override
  State<WorkExperienceScreen> createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  late WorkExperienceProvider workExperienceProvider;

  @override
  void initState() {
    super.initState();
    workExperienceProvider = Provider.of<WorkExperienceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkExperienceProvider>(
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
                  if (provider.jobTitleController.text.isNotEmpty &&
                      provider.companyController.text.isNotEmpty &&
                      provider.fromDate != null) {
                        
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
                    
                    // Create work experience data
                    final workExperienceData = {
                      'title': provider.jobTitleController.text,
                      'company': provider.companyController.text,
                      'startDate': startDate,
                      'endDate': formattedEndDate,
                      'location': provider.locationController.text,
                      'description': provider.descriptionController.text,
                      'employmentType': provider.selectedEmploymentType,
                      'jobLevel': provider.selectedJobLevel,
                      'jobFunction': provider.selectedJobFunction,
                    };
                    
                    // Update existing or add new work experience
                    // if (provider.isEditing && provider.editingIndex != null) {
                    //   // Update existing work experience
                    //   profileProvider.updateWorkExperience(provider.editingIndex!, workExperienceData);
                    // } else {
                    //   // Add new work experience
                    //   profileProvider.addWorkExperience(
                    //     title: workExperienceData['title']!,
                    //     company: workExperienceData['company']!,
                    //     startDate: workExperienceData['startDate']!,
                    //     endDate: workExperienceData['endDate']!,
                    //     location: workExperienceData['location'],
                    //     description: workExperienceData['description'],
                    //     employmentType: workExperienceData['employmentType'],
                    //     jobLevel: workExperienceData['jobLevel'],
                    //     jobFunction: workExperienceData['jobFunction'],
                    //   );
                    // }
                    
                    // Mark work experience section as completed
                    // profileProvider.setSectionStatus('Work Experience', true);
                    
                    // Reset form
                    provider.resetForm();
                    
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
                buttonText: provider.isEditing ? "Update" : "Save",
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
                        title: "Work Experience",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                          onTap: (){

                          },
                          child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                    ],
                  ),

                  _buildLabel("Job Title"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.jobTitleController,
                    focusNode: provider.jobTitleFocusNode,
                    hintText: "UI/UX Designer",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null, fillColor: provider.jobTitleFocusNode.hasFocus
                      ? AppColors.activeFieldBgColor
                      : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                  ),
                  _buildLabel("Company"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.companyController,
                    focusNode: provider.companyFocusNode,
                    hintText: "Paypal Inc",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null, fillColor: provider.companyFocusNode.hasFocus
                      ? AppColors.activeFieldBgColor
                      : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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


                  Padding(
                    padding: EdgeInsets.only(top:2.h),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("I currently work here", style: TextStyle(fontSize: AppFontSize.fontSize16, color: AppColors.Color_424242,fontFamily: AppColors.fontFamilyMedium,fontWeight: FontWeight.w500),),
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
                  _buildLabel("Employment Type"),
                  _buildDropdown(provider.selectedEmploymentType, provider.employmentTypes, provider.setEmploymentType),

                  _buildLabel("Location"),
                  _buildLocationField(provider),

                  _buildLabel("Job Level"),
                  _buildDropdown(provider.selectedJobLevel, provider.jobLevels, provider.setJobLevel),

                  _buildLabel("Job Function"),
                  _buildDropdown(provider.selectedJobFunction, provider.jobFunctions, provider.setJobFunction),

                  _buildLabel("Salary (Optional)"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.salaryController,
                    focusNode: provider.salaryFocusNode,
                    hintText: "Salary",
                    textInputType: TextInputType.number,
                    voidCallback: (value) => null, fillColor: provider.salaryFocusNode.hasFocus
                  ? AppColors.activeFieldBgColor
                    : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildLabel("Currency"),
                      ),
                      Expanded(
                        child: _buildLabel("Frequency"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(provider.selectedCurrency, provider.currencies, provider.setCurrency),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: _buildDropdown(provider.selectedFrequency, provider.frequencies, provider.setFrequency),
                      ),
                    ],
                  ),

                  _buildLabel("Add Media (Optional)"),
                  _buildFileUploadBox(provider),

                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ));
        },
      );
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w,top: 2.h),
      child: Text(text, style:  TextStyle(fontSize: AppFontSize.fontSize16, fontWeight: FontWeight.w500,fontFamily: AppColors.fontFamilyMedium,color: AppColors.Color_424242)),
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String) onChanged) {
    return Container(
      height: 6.5.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
            child: Text(item, style: TextStyle(fontSize: AppFontSize.fontSize16,fontWeight: FontWeight.w600,fontFamily: AppColors.fontFamilySemiBold,color: AppColors.Color_212121)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }

  Widget _buildLocationField(WorkExperienceProvider provider) {
    return Container(
      height: 6.5.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color:  AppColors.Color_FAFAFA,
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: Row(
        children: [
          Image.asset("assets/images/Location.png",height: 2.h,color: AppColors.Color_212121,),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(provider.locationController.text, style: TextStyle(fontSize: AppFontSize.fontSize16,color: AppColors.Color_212121,fontWeight:FontWeight.w600,fontFamily: AppColors.fontFamilySemiBold),),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadBox(WorkExperienceProvider provider) {
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
              date != null ? DateFormat('MM/yyyy').format(date) : hintText,
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

