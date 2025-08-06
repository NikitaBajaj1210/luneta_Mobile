import 'package:flutter/material.dart';
import 'package:luneta/network/network_services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/education_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../network/network_helper.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<EducationProvider>(context, listen: false);
      provider.resetForm();
      provider.fetchEducationData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EducationProvider>(
      builder: (context, provider, child) {
        // Show error dialog if there's an error
        // if (provider.hasError && provider.errorMessage.isNotEmpty) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     _showErrorDialog(context, provider.errorMessage);
        //   });
        // }
        return SafeArea(
          child:
          Container(
            height: 100.h,
            width: 100.w,
            color: AppColors.Color_FFFFFF,
            child: NetworkService.loading == 0 ? Center(
              child: CircularProgressIndicator(color: AppColors.Color_607D8B),
            ) :
            NetworkService.loading == 1 ? Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    NetworkService.loading = 0;
                    setState(() {}); // Show loader immediately
                    provider.fetchEducationData(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                          'assets/images/refresh.png',
                          width: 4.5.h,
                          height: 4.5.h,
                          color: AppColors.Color_607D8B
                      ),
                      SizedBox(
                        height:1.h,
                      ),
                      Text(
                        "Tab to Try Again",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: AppColors.fontFamilyBold,
                            fontSize: AppFontSize.fontSize15,
                            color: AppColors.Color_607D8B,
                            decoration: TextDecoration.none
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ):
            Scaffold(
            backgroundColor: AppColors.Color_FFFFFF,
            bottomNavigationBar: Container(
              height: 11.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
              ),
              child: customButton(
                  voidCallback: () async {
                  if (provider.languagesSpokenFormKey.currentState!.validate()) {
                      NetworkService.loading = 0;
                      setState(() {}); // Trigger UI update to show loader
                      
                      // Call the API to save education data
                      bool success = await provider.createOrUpdateEducationAPI(context);
                      
                      if (success) {
                        // Reset loading state before calling getProfileInfo
                        // NetworkService.loading = 2;
                        
                          Provider.of<ProfileBottommenuProvider>(
                              context,
                              listen: false).getProfileInfo(context);
                        Navigator.pop(context);
                      } else {
                        // Reset loading state on failure
                        NetworkService.loading = 2;
                        setState(() {}); // Trigger UI update
                      }
                  } else {
                    setState(() {
                      provider.autovalidateModeLanguages = AutovalidateMode.always;
                    });
                  }
                },
                buttonText: "Save",
                width: 90.w,
                height: 4.h,
                color: AppColors.buttonColor,
                buttonTextColor: AppColors.buttonTextWhiteColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize18,
                showShadow: true,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Form(
                  key: provider.formKey,
                  autovalidateMode: provider.autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button and Title
                      backButtonWithTitle(
                        title: "Education",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),

                      // Academic Qualification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              'Academic Qualification',
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize16,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppColors.fontFamilyMedium,
                                color: AppColors.Color_424242,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                provider.setAcademicQualificationVisibility(true);
                                provider.academicQualification_Edit_Index = null;
                                provider.academicQualification_IsEdit = false;
                              },
                              child: Container(
                                padding: EdgeInsets.all(2.5.w),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(150),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 2.5.h,
                                  color: AppColors.buttonTextWhiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.academicQualificationList.length,
                        itemBuilder: (context, index) {
                          AcademicQualification qualification = provider.academicQualificationList[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.1.h,
                                          color: AppColors.Color_EEEEEE,
                                        ),
                                        borderRadius: BorderRadius.circular(2.h),
                                      ),
                                      padding: EdgeInsets.all(1.2.h),
                                      child: Image.asset(
                                        "assets/images/companyLogo.png",
                                        height: 5.h,
                                        width: 5.h,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Container(
                                      width: 64.w,
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                qualification.educationalDegree,
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize20,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.Color_212121,
                                                  fontFamily: AppColors.fontFamilyBold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.educationalDegree = qualification.educationalDegree;
                                                      provider.fieldOfStudyController.text = qualification.fieldOfStudy;
                                                      provider.educationalInstitutionController.text = qualification.educationalInstitution;
                                                      provider.country = qualification.country;
                                                      provider.graduationDateController.text = qualification.graduationDate;
                                                      provider.academicDocument = qualification.document;
                                                      provider.setAcademicQualificationVisibility(true);
                                                      provider.academicQualification_Edit_Index = index;
                                                      provider.academicQualification_IsEdit = true;
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Edit.png",
                                                      height: 2.h,
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.removeAcademicQualification(index);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Delete.png",
                                                      height: 2.h,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            qualification.fieldOfStudy,
                                            style: TextStyle(
                                              fontSize: AppFontSize.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.Color_212121,
                                              fontFamily: AppColors.fontFamilyMedium,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            qualification.educationalInstitution,
                                            style: TextStyle(
                                              fontSize: AppFontSize.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.Color_212121,
                                              fontFamily: AppColors.fontFamilyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      if (provider.showAddSection_academicQualification)
                        Form(
                          key: provider.academicQualificationFormKey,
                          autovalidateMode: provider.autovalidateModeAcademic,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Educational Degree',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: SearchChoices.single(
                                  items: provider.educationalDegrees.map((degree) {
                                    return DropdownMenuItem(
                                      child: Text(degree),
                                      value: degree,
                                    );
                                  }).toList(),
                                  value: provider.educationalDegree,
                                  hint: "Select Degree",
                                  onClear: (){
                                    provider.setEducationalDegree('');
                                  },
                                  searchHint: "Search for a degree",
                                  onChanged: (value) {
                                    provider.setEducationalDegree(value as String);
                                  },
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  autovalidateMode: provider.autovalidateModeAcademic,
                                  displayItem: (item, selected) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                        borderRadius: BorderRadius.circular(2.h),
                                        border: Border.all(
                                          color: AppColors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(item.child.data),
                                      ),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null && provider.autovalidateModeAcademic == AutovalidateMode.always) {
                                      return 'Please select a degree';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Field of Study',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              customTextField(
                                context: context,
                                controller: provider.fieldOfStudyController,
                                hintText: 'Enter Field of Study',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autovalidateMode: provider.autovalidateModeAcademic,
                                voidCallback: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Field of Study';
                                  }
                                  return null;
                                },
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: AppColors.Color_FAFAFA,
                                onFieldSubmitted: (String) {},
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Educational Institution',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              customTextField(
                                context: context,
                                controller: provider.educationalInstitutionController,
                                hintText: 'Enter Educational Institution',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autovalidateMode: provider.autovalidateModeAcademic,
                                voidCallback: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Educational Institution';
                                  }
                                  return null;
                                },
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: AppColors.Color_FAFAFA,
                                onFieldSubmitted: (String) {},
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Country',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: SearchChoices.single(
                                  items: provider.countries.map((country) {
                                    return DropdownMenuItem(
                                      child: Text(country),
                                      value: country,
                                    );
                                  }).toList(),
                                  value: provider.country,
                                  hint: "Select Country",
                                  autovalidateMode: provider.autovalidateModeAcademic,
                                  onClear: (){
                                    provider.setCountry('');
                                  },
                                  searchHint: "Search for a country",
                                  onChanged: (value) {
                                    provider.setCountry(value as String);
                                  },
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  displayItem: (item, selected) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                        borderRadius: BorderRadius.circular(2.h),
                                        border: Border.all(
                                          color: AppColors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(item.child.data),
                                      ),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null && provider.autovalidateModeAcademic == AutovalidateMode.always) {
                                      return 'Please select a country';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Graduation Date',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    provider.setGraduationDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.graduationDateController,
                                    hintText: 'Select Graduation Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    autovalidateMode: provider.autovalidateModeAcademic,
                                    voidCallback: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select Graduation Date';
                                      }
                                      return null;
                                    },
                                    fontSize: AppFontSize.fontSize16,
                                    inputFontSize: AppFontSize.fontSize16,
                                    backgroundColor: AppColors.Color_FAFAFA,
                                    borderColor: AppColors.buttonColor,
                                    textColor: Colors.black,
                                    labelColor: AppColors.Color_9E9E9E,
                                    cursorColor: AppColors.Color_212121,
                                    fillColor: AppColors.Color_FAFAFA,
                                    onFieldSubmitted: (String) {},
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Attach Document',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await provider.showAttachmentOptions(context, 'academic');
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(15),
                                  dashPattern: [10, 10],
                                  color: AppColors.buttonColor,
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
                                        Image.asset("assets/images/Upload.png", height: 5.h),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Browse File",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppColors.fontFamilySemiBold,
                                            color: AppColors.Color_9E9E9E,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (provider.academicDocument == null && provider.autovalidateModeAcademic == AutovalidateMode.always)
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h, left: 4.w),
                                  child: Text(
                                    "Please select a document",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: AppFontSize.fontSize12,
                                    ),
                                  ),
                                ),
                              SizedBox(height: 3.h),
                              if (provider.academicDocument != null)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(1.h),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.academicDocument!.path.split('/').last,
                                              style: TextStyle(
                                                fontSize: AppFontSize.fontSize16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.Color_212121,
                                                fontFamily: AppColors.fontFamilyBold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder<int>(
                                              future: provider.academicDocument!.length(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                                    style: TextStyle(
                                                      fontSize: AppFontSize.fontSize12,
                                                      color: AppColors.Color_616161,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: AppColors.fontFamilyMedium,
                                                    ),
                                                  );
                                                }
                                                return SizedBox();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.removeAttachment('academic');
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                  child: customButton(
                                    voidCallback: () {
                                      setState(() {
                                        provider.autovalidateModeAcademic = AutovalidateMode.always;
                                      });
                                      if (provider.academicQualificationFormKey.currentState!.validate()) {
                                        AcademicQualification qualification = AcademicQualification(
                                          educationalDegree: provider.educationalDegree!,
                                          fieldOfStudy: provider.fieldOfStudyController.text,
                                          educationalInstitution: provider.educationalInstitutionController.text,
                                          country: provider.country!,
                                          graduationDate: provider.graduationDateController.text,
                                          document: provider.academicDocument,
                                        );
                                        if (provider.academicQualification_IsEdit) {
                                          provider.updateAcademicQualification(provider.academicQualification_Edit_Index!, qualification);
                                        } else {
                                          provider.addAcademicQualification(qualification);
                                        }
                                        provider.setAcademicQualificationVisibility(false);
                                        provider.educationalDegree = null;
                                        provider.fieldOfStudyController.clear();
                                        provider.educationalInstitutionController.clear();
                                        provider.country = null;
                                        provider.graduationDateController.clear();
                                        provider.academicDocument = null;
                                        provider.autovalidateModeAcademic = AutovalidateMode.disabled;
                                      }
                                    },
                                    buttonText: provider.academicQualification_IsEdit ? "Update" : "Add",
                                    width: 30.w,
                                    height: 10.w,
                                    color: AppColors.buttonColor,
                                    buttonTextColor: AppColors.buttonTextWhiteColor,
                                    shadowColor: AppColors.buttonBorderColor,
                                    fontSize: AppFontSize.fontSize18,
                                    showShadow: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Certifications and Trainings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              'Certifications and Trainings',
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize16,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppColors.fontFamilyMedium,
                                color: AppColors.Color_424242,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                provider.setCertificationVisibility(true);
                                provider.certification_Edit_Index = null;
                                provider.certification_IsEdit = false;
                              },
                              child: Container(
                                padding: EdgeInsets.all(2.5.w),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(150),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 2.5.h,
                                  color: AppColors.buttonTextWhiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.certificationList.length,
                        itemBuilder: (context, index) {
                          Certification certification = provider.certificationList[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.1.h,
                                          color: AppColors.Color_EEEEEE,
                                        ),
                                        borderRadius: BorderRadius.circular(2.h),
                                      ),
                                      padding: EdgeInsets.all(1.2.h),
                                      child: Image.asset(
                                        "assets/images/companyLogo.png",
                                        height: 5.h,
                                        width: 5.h,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Container(
                                      width: 64.w,
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                certification.typeOfCertification,
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize20,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.Color_212121,
                                                  fontFamily: AppColors.fontFamilyBold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.typeOfCertification = certification.typeOfCertification;
                                                      provider.issuingAuthorityController.text = certification.issuingAuthority;
                                                      provider.issueDateController.text = certification.issueDate;
                                                      provider.expiryDateController.text = certification.expiryDate;
                                                      provider.certificationDocument = certification.document;
                                                      provider.setCertificationVisibility(true);
                                                      provider.certification_Edit_Index = index;
                                                      provider.certification_IsEdit = true;
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Edit.png",
                                                      height: 2.h,
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.removeCertification(index);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Delete.png",
                                                      height: 2.h,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            certification.issuingAuthority,
                                            style: TextStyle(
                                              fontSize: AppFontSize.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.Color_212121,
                                              fontFamily: AppColors.fontFamilyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      if (provider.showAddSection_certification)
                        Form(
                          key: provider.certificationFormKey,
                          autovalidateMode: provider.autovalidateModeCertification,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Type of Certification',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: SearchChoices.single(
                                  items: provider.certificationTypes.map((type) {
                                    return DropdownMenuItem(
                                      child: Text(type),
                                      value: type,
                                    );
                                  }).toList(),
                                  value: provider.typeOfCertification,
                                  hint: "Select Type",
                                  searchHint: "Search for a type",
                                  onChanged: (value) {
                                    provider.setTypeOfCertification(value as String);
                                  },
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  displayItem: (item, selected) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                        borderRadius: BorderRadius.circular(2.h),
                                        border: Border.all(
                                          color: AppColors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(item.child.data),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Issuing Authority',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              customTextField(
                                context: context,
                                controller: provider.issuingAuthorityController,
                                hintText: 'Enter Issuing Authority',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: AppColors.Color_FAFAFA,
                                onFieldSubmitted: (String) {},
                                voidCallback: (value) {},
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Issue Date',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    provider.setIssueDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.issueDateController,
                                    hintText: 'Select Issue Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    fontSize: AppFontSize.fontSize16,
                                    inputFontSize: AppFontSize.fontSize16,
                                    backgroundColor: AppColors.Color_FAFAFA,
                                    borderColor: AppColors.buttonColor,
                                    textColor: Colors.black,
                                    labelColor: AppColors.Color_9E9E9E,
                                    cursorColor: AppColors.Color_212121,
                                    fillColor: AppColors.Color_FAFAFA,
                                    onFieldSubmitted: (String) {},
                                    voidCallback: (value) {},
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                                    lastDate: DateTime(DateTime.now().year+100),
                                  );
                                  if (picked != null) {
                                    provider.setExpiryDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.expiryDateController,
                                    hintText: 'Select Expiry Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    fontSize: AppFontSize.fontSize16,
                                    inputFontSize: AppFontSize.fontSize16,
                                    backgroundColor: AppColors.Color_FAFAFA,
                                    borderColor: AppColors.buttonColor,
                                    textColor: Colors.black,
                                    labelColor: AppColors.Color_9E9E9E,
                                    cursorColor: AppColors.Color_212121,
                                    fillColor: AppColors.Color_FAFAFA,
                                    onFieldSubmitted: (String) {},
                                    voidCallback: (value) {},
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Attach Document',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await provider.showAttachmentOptions(context, 'certification');
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(15),
                                  dashPattern: [10, 10],
                                  color: AppColors.buttonColor,
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
                                        Image.asset("assets/images/Upload.png", height: 5.h),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Browse File",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppColors.fontFamilySemiBold,
                                            color: AppColors.Color_9E9E9E,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                                SizedBox(height: 3.h),
                              if (provider.certificationDocument != null)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(1.h),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.certificationDocument!.path.split('/').last,
                                              style: TextStyle(
                                                fontSize: AppFontSize.fontSize16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.Color_212121,
                                                fontFamily: AppColors.fontFamilyBold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder<int>(
                                              future: provider.certificationDocument!.length(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                                    style: TextStyle(
                                                      fontSize: AppFontSize.fontSize12,
                                                      color: AppColors.Color_616161,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: AppColors.fontFamilyMedium,
                                                    ),
                                                  );
                                                }
                                                return SizedBox();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.removeAttachment('certification');
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                  child: customButton(
                                    voidCallback: () {
                                      if (provider.certificationFormKey.currentState!.validate()) {
                                        Certification certification = Certification(
                                          typeOfCertification: provider.typeOfCertification!,
                                          issuingAuthority: provider.issuingAuthorityController.text,
                                          issueDate: provider.issueDateController.text,
                                          expiryDate: provider.expiryDateController.text,
                                          document: provider.certificationDocument,
                                        );
                                        if (provider.certification_IsEdit) {
                                          provider.updateCertification(provider.certification_Edit_Index!, certification);
                                        } else {
                                          provider.addCertification(certification);
                                        }
                                        provider.setCertificationVisibility(false);
                                        provider.typeOfCertification = null;
                                        provider.issuingAuthorityController.clear();
                                        provider.issueDateController.clear();
                                        provider.expiryDateController.clear();
                                        provider.certificationDocument = null;
                                        provider.autovalidateModeCertification = AutovalidateMode.disabled;
                                      } else {
                                        setState(() {
                                          provider.autovalidateModeCertification = AutovalidateMode.always;
                                        });
                                      }
                                    },
                                    buttonText: provider.certification_IsEdit ? "Update" : "Add",
                                    width: 30.w,
                                    height: 10.w,
                                    color: AppColors.buttonColor,
                                    buttonTextColor: AppColors.buttonTextWhiteColor,
                                    shadowColor: AppColors.buttonBorderColor,
                                    fontSize: AppFontSize.fontSize18,
                                    showShadow: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Languages Spoken
                      Form(
                        key: provider.languagesSpokenFormKey,
                        autovalidateMode: provider.autovalidateModeLanguages,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Text(
                                'Languages Spoken',
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppColors.fontFamilyMedium,
                                  color: AppColors.Color_424242,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Text(
                                'Native',
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppColors.fontFamilyMedium,
                                  color: AppColors.Color_424242,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.Color_FAFAFA,
                                borderRadius: BorderRadius.circular(2.h),
                              ),
                              child: MultiSelectDialogField(
                                items: provider.allLanguages.map((e) => MultiSelectItem(e, e)).toList(),
                                title: Text("Native Languages"),
                                selectedColor: AppColors.buttonColor,
                                searchable: true,
                                  initialValue: provider.nativeLanguages,
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.buttonColor, width: 1),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                                buttonText: Text("Select Native Languages"),
                                onConfirm: (values) {
                                  provider.setNativeLanguages(values.cast<String>());
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select at least one native language';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Text(
                                'Additional Language',
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppColors.fontFamilyMedium,
                                  color: AppColors.Color_424242,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.Color_FAFAFA,
                                borderRadius: BorderRadius.circular(2.h),
                              ),
                              child: SearchChoices.single(
                                items: provider.allLanguages.map((language) {
                                  return DropdownMenuItem(
                                    child: Text(language),
                                    value: language,
                                  );
                                }).toList(),
                                value: provider.additionalLanguage,
                                hint: "Select Language",
                                searchHint: "Search for a language",
                                validator: (value) {
                                  if ((value == null || value.isEmpty) && provider.autovalidateModeLanguages== AutovalidateMode.always) {
                                    return 'Please select language';
                                  }
                                  return null;
                                },
                                autovalidateMode: provider.autovalidateModeLanguages,
                                onChanged: (value) {
                                  provider.setAdditionalLanguage(value as String);
                                },
                                isExpanded: true,
                                onClear: (){
                                  provider.setAdditionalLanguage('');
                                },
                                underline: SizedBox(),
                                displayItem: (item, selected) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                      borderRadius: BorderRadius.circular(2.h),
                                      border: Border.all(
                                        color: AppColors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(item.child.data),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Text(
                                'Level',
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppColors.fontFamilyMedium,
                                  color: AppColors.Color_424242,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.Color_FAFAFA,
                                borderRadius: BorderRadius.circular(2.h),
                              ),
                              child: SearchChoices.single(
                                items: provider.languageLevels.map((level) {
                                  return DropdownMenuItem(
                                    child: Text(level),
                                    value: level,
                                  );
                                }).toList(),
                                value: provider.additionalLanguageLevel,
                                hint: "Select Level",
                                onClear: (){
                                  provider.setAdditionalLanguageLevel('');
                                },
                                searchHint: "Search for a level",
                           autovalidateMode: provider.autovalidateModeLanguages,
                                onChanged: (value) {
                                  provider.setAdditionalLanguageLevel(value as String);
                                },
                                isExpanded: true,
                                underline: SizedBox(),
                                displayItem: (item, selected) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                      borderRadius: BorderRadius.circular(2.h),
                                      border: Border.all(
                                        color: AppColors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(item.child.data),
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if ((value == null || value.isEmpty) && provider.autovalidateModeLanguages== AutovalidateMode.always) {
                                    return 'Please select a level';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Show error dialog if there's an error
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class backButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const backButtonWithTitle({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        SizedBox(width: 3.w),
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.bold,
            color: AppColors.Color_424242,
          ),
        ),
      ],
    );
  }
}
