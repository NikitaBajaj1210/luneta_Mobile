import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/medical_document_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';

class MedicalDocumentScreen extends StatefulWidget {
  const MedicalDocumentScreen({super.key});

  @override
  State<MedicalDocumentScreen> createState() => _MedicalDocumentScreenState();
}

class _MedicalDocumentScreenState extends State<MedicalDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MedicalDocumentProvider>(
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
                  if (provider.formKey.currentState!.validate()) {
                    // Save the data in provider or update the profile here
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      provider.autovalidateMode = AutovalidateMode.always;
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
                        title: "Medical Documents",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),

                      // Medical Fitness
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              'Medical Fitness',
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
                                provider.setMedicalFitnessVisibility(true);
                                provider.medicalFitness_Edit_Index = null;
                                provider.medicalFitness_IsEdit = false;
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
                        itemCount: provider.medicalFitnessList.length,
                        itemBuilder: (context, index) {
                          MedicalFitness medicalFitness = provider.medicalFitnessList[index];
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
                                                medicalFitness.documentType,
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
                                                      provider.medicalFitnessDocumentType = medicalFitness.documentType;
                                                      provider.medicalFitnessCertificateNoController.text = medicalFitness.certificateNo;
                                                      provider.medicalFitnessIssuingCountry = medicalFitness.issuingCountry;
                                                      provider.medicalFitnessIssuingAuthorityController.text = medicalFitness.issuingAuthority;
                                                      provider.medicalFitnessIssueDateController.text = medicalFitness.issueDate;
                                                      provider.medicalFitnessExpiryDateController.text = medicalFitness.expiryDate;
                                                      provider.medicalFitnessNeverExpire = medicalFitness.neverExpire;
                                                      provider.medicalFitnessDocument = medicalFitness.document;
                                                      provider.setMedicalFitnessVisibility(true);
                                                      provider.medicalFitness_Edit_Index = index;
                                                      provider.medicalFitness_IsEdit = true;
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Edit.png",
                                                      height: 2.h,
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.removeMedicalFitness(index);
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
                                            medicalFitness.certificateNo,
                                            style: TextStyle(
                                              fontSize: AppFontSize.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.Color_212121,
                                              fontFamily: AppColors.fontFamilyMedium,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            medicalFitness.issueDate + " - " + medicalFitness.expiryDate,
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
                      if (provider.showAddSection_medicalFitness)
                        Form(
                          key: provider.medicalFitnessFormKey,
                          autovalidateMode: provider.autovalidateModeMedical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Document type',
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
                                  items: provider.medicalFitnessDocumentTypes.map((type) {
                                    return DropdownMenuItem(
                                      child: Text(type),
                                      value: type,
                                    );
                                  }).toList(),
                                  value: provider.medicalFitnessDocumentType,
                                  onClear: (){
                                    provider.setMedicalFitnessDocumentType('');
                                  },
                                  hint: "Select Document Type",
                                  autovalidateMode: provider.autovalidateMode,
                                  validator: (value) {
                                    if ((value == null || value.isEmpty) && provider.autovalidateModeMedical == AutovalidateMode.always) {
                                      return '      Please select Document Type';
                                    }
                                    return null;
                                  },
                                  searchHint: "Search for a document type",
                                  onChanged: (value) {
                                    provider.setMedicalFitnessDocumentType(value as String);
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
                                  'Certificate No.',
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
                                controller: provider.medicalFitnessCertificateNoController,
                                hintText: 'Enter Certificate No.',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autovalidateMode: provider.autovalidateMode,
                                voidCallback: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Certificate No.';
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
                                fillColor: provider.medicalFitnessCertificateNoFocusNode.hasFocus ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                onFieldSubmitted: (String) {},
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Issuing Country',
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
                                  value: provider.medicalFitnessIssuingCountry,
                                  onClear: (){
                                    provider.setMedicalFitnessIssuingCountry('');
                                  },
                                  hint: "Select Country",
                                  autovalidateMode: provider.autovalidateMode,
                                  validator: (value) {
                                    if ((value == null || value.isEmpty) && provider.autovalidateModeMedical == AutovalidateMode.always) {
                                      return '      Please select Country';
                                    }
                                    return null;
                                  },
                                  searchHint: "Search for a country",
                                  onChanged: (value) {
                                    provider.setMedicalFitnessIssuingCountry(value as String);
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
                                  'Issuing Clinic/Hospital/Authority',
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
                                controller: provider.medicalFitnessIssuingAuthorityController,
                                hintText: 'Enter Issuing Clinic/Hospital/Authority',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autovalidateMode: provider.autovalidateMode,
                                voidCallback: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Issuing Clinic/Hospital/Authority';
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
                                fillColor: provider.medicalFitnessIssuingAuthorityFocusNode.hasFocus ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                onFieldSubmitted: (String) {},
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
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != null) {
                                    provider.setMedicalFitnessIssueDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.medicalFitnessIssueDateController,
                                    hintText: 'Select Issue Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    autovalidateMode: provider.autovalidateMode,
                                    voidCallback: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select Issue Date';
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
                                    fillColor: provider.medicalFitnessIssueDateFocusNode.hasFocus ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                    onFieldSubmitted: (String) {},
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
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != null) {
                                    provider.setMedicalFitnessExpiryDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.medicalFitnessExpiryDateController,
                                    hintText: 'Select Expiry Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    autovalidateMode: provider.autovalidateMode,
                                    voidCallback: (value) {
                                      if ((value == null || value.isEmpty) && !provider.medicalFitnessNeverExpire) {
                                        return 'Please select Expiry Date';
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
                                    fillColor: provider.medicalFitnessExpiryDateFocusNode.hasFocus ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                    onFieldSubmitted: (String) {},
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Checkbox(
                                    value: provider.medicalFitnessNeverExpire,
                                    onChanged: (value) {
                                      provider.setMedicalFitnessNeverExpire(value!);
                                    },
                                  ),
                                  Text('Some never expire'),
                                ],
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
                                  await provider.showAttachmentOptions(context, 'medical_fitness');
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
                              if (provider.medicalFitnessDocument == null && provider.autovalidateModeMedical == AutovalidateMode.always)
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h, left: 4.w),
                                  child: Text(
                                    "Please select Medical Fitness Document",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: AppFontSize.fontSize12,
                                    ),
                                  ),
                                ),
                              SizedBox(height: 3.h),
                              if (provider.medicalFitnessDocument != null)
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
                                              provider.medicalFitnessDocument!.path.split('/').last,
                                              style: TextStyle(
                                                fontSize: AppFontSize.fontSize16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.Color_212121,
                                                fontFamily: AppColors.fontFamilyBold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder<int>(
                                              future: provider.medicalFitnessDocument!.length(),
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
                                          provider.removeAttachment('medical_fitness');
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
                                      if (provider.medicalFitnessFormKey.currentState!.validate() && provider.medicalFitnessDocument!=null) {
                                        MedicalFitness medicalFitness = MedicalFitness(
                                          documentType: provider.medicalFitnessDocumentType!,
                                          certificateNo: provider.medicalFitnessCertificateNoController.text,
                                          issuingCountry: provider.medicalFitnessIssuingCountry!,
                                          issuingAuthority: provider.medicalFitnessIssuingAuthorityController.text,
                                          issueDate: provider.medicalFitnessIssueDateController.text,
                                          expiryDate: provider.medicalFitnessExpiryDateController.text,
                                          neverExpire: provider.medicalFitnessNeverExpire,
                                          document: provider.medicalFitnessDocument,
                                        );
                                        if (provider.medicalFitness_IsEdit) {
                                          provider.updateMedicalFitness(provider.medicalFitness_Edit_Index!, medicalFitness);
                                        } else {
                                          provider.addMedicalFitness(medicalFitness);
                                        }
                                        provider.setMedicalFitnessVisibility(false);
                                        provider.medicalFitnessDocumentType = null;
                                        provider.medicalFitnessCertificateNoController.clear();
                                        provider.medicalFitnessIssuingCountry = null;
                                        provider.medicalFitnessIssuingAuthorityController.clear();
                                        provider.medicalFitnessIssueDateController.clear();
                                        provider.medicalFitnessExpiryDateController.clear();
                                        provider.medicalFitnessNeverExpire = false;
                                        provider.medicalFitnessDocument = null;
                                        provider.autovalidateModeMedical= AutovalidateMode.disabled;
                                      } else {
                                        setState(() {
                                          provider.autovalidateModeMedical = AutovalidateMode.always;
                                        });
                                      }
                                    },
                                    buttonText: provider.medicalFitness_IsEdit ? "Update" : "Add",
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

                      // Drug & Alcohol Test
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Drug & Alcohol Test',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      // Drug & Alcohol Test UI
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Document type',
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
                          items: provider.drugAndAlcoholTestDocumentTypes.map((type) {
                            return DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            );
                          }).toList(),
                          value: provider.drugAndAlcoholTestDocumentType,
                          hint: "Select Document Type",
                          onClear: (){
                            provider.setDrugAndAlcoholTestDocumentType('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value){
                            if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                              return '      Please select Document Type';
                            }
                            return null;
                          },
                          searchHint: "Search for a document type",
                          onChanged: (value) {
                            provider.setDrugAndAlcoholTestDocumentType(value as String);
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
                          'Certificate No.',
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
                        controller: provider.drugAndAlcoholTestCertificateNoController,
                        hintText: 'Enter Certificate No.',
                        textInputType: TextInputType.text,
                        obscureText: false,
                        autovalidateMode: provider.autovalidateMode,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Certificate No.';
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
                        fillColor: provider.drugAndAlcoholTestCertificateNoFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Issuing Country',
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
                          value: provider.drugAndAlcoholTestIssuingCountry,
                          hint: "Select Country",
                          onClear: (){
                            provider.setDrugAndAlcoholTestIssuingCountry('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value){
                            if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                              return '      Please select Country';
                            }
                            return null;
                          },
                          searchHint: "Search for a country",
                          onChanged: (value) {
                            provider.setDrugAndAlcoholTestIssuingCountry(value as String);
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
                          'Issuing Clinic/Hospital/Authority',
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
                        controller: provider.drugAndAlcoholTestIssuingAuthorityController,
                        hintText: 'Enter Issuing Clinic/Hospital/Authority',
                        textInputType: TextInputType.text,
                        obscureText: false,
                        autovalidateMode: provider.autovalidateMode,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Issuing Clinic/Hospital/Authority';
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
                        fillColor: provider.drugAndAlcoholTestIssuingAuthorityFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setDrugAndAlcoholTestIssueDate(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: provider.drugAndAlcoholTestIssueDateController,
                            hintText: 'Select Issue Date',
                            textInputType: TextInputType.datetime,
                            obscureText: false,
                            autovalidateMode: provider.autovalidateMode,
                            voidCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Issue Date';
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
                            fillColor: provider.drugAndAlcoholTestIssueDateFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setDrugAndAlcoholTestExpiryDate(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: provider.drugAndAlcoholTestExpiryDateController,
                            hintText: 'Select Expiry Date',
                            textInputType: TextInputType.datetime,
                            obscureText: false,
                            autovalidateMode: provider.autovalidateMode,
                            voidCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Expiry Date';
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
                            fillColor: provider.drugAndAlcoholTestExpiryDateFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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
                          await provider.showAttachmentOptions(context, 'drug_alcohol_test');
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
                                      color: AppColors.Color_9E9E9E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (provider.drugAndAlcoholTestDocument == null && provider.autovalidateMode==AutovalidateMode.always)
                        Padding(
                          padding: EdgeInsets.only(top: 1.h, left: 4.w),
                          child: Text("Please select Drug & Alcohol Test Document",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: AppFontSize.fontSize12,
                            ),
                          ),
                        ),
                      SizedBox(height: 3.h),
                      if (provider.drugAndAlcoholTestDocument != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.drugAndAlcoholTestDocument!.path.split('/').last,
                                      style: TextStyle(
                                          fontSize: AppFontSize.fontSize16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.Color_212121,
                                          fontFamily:
                                          AppColors.fontFamilyBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FutureBuilder<int>(
                                      future: provider.drugAndAlcoholTestDocument!.length(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                            style: TextStyle(
                                                fontSize: AppFontSize.fontSize12,
                                                color: AppColors.Color_616161,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                AppColors.fontFamilyMedium),
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
                                  provider.removeAttachment('drug_alcohol_test');
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

                      // Vaccination Certificates
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Vaccination Certificates',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      // Vaccination Certificates UI
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Document type',
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
                          items: provider.vaccinationCertificateDocumentTypes.map((type) {
                            return DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            );
                          }).toList(),
                          value: provider.vaccinationCertificateDocumentType,
                          hint: "Select Document Type",
                          onClear: (){
                            provider.setVaccinationCertificateDocumentType('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value){
                            if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                              return '      Please select Document Type';
                            }
                            return null;
                          },
                          searchHint: "Search for a document type",
                          onChanged: (value) {
                            provider.setVaccinationCertificateDocumentType(value as String);
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
                          'Vaccination Country',
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
                          value: provider.vaccinationCertificateIssuingCountry,
                          hint: "Select Country",
                          onClear: (){
                            provider.setVaccinationCertificateIssuingCountry('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value){
                            if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                              return '      Please select Country';
                            }
                            return null;
                          },
                          searchHint: "Search for a country",
                          onChanged: (value) {
                            provider.setVaccinationCertificateIssuingCountry(value as String);
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
                          'Issuing Clinic/Hospital/Authority',
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
                        controller: provider.vaccinationCertificateIssuingAuthorityController,
                        hintText: 'Enter Issuing Clinic/Hospital/Authority',
                        textInputType: TextInputType.text,
                        obscureText: false,
                        autovalidateMode: provider.autovalidateMode,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Issuing Clinic/Hospital/Authority';
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
                        fillColor: provider.vaccinationCertificateIssuingAuthorityFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setVaccinationCertificateIssueDate(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: provider.vaccinationCertificateIssueDateController,
                            hintText: 'Select Issue Date',
                            textInputType: TextInputType.datetime,
                            obscureText: false,
                            autovalidateMode: provider.autovalidateMode,
                            voidCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Issue Date';
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
                            fillColor: provider.vaccinationCertificateIssueDateFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
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
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setVaccinationCertificateExpiryDate(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: provider.vaccinationCertificateExpiryDateController,
                            hintText: 'Select Expiry Date',
                            textInputType: TextInputType.datetime,
                            obscureText: false,
                            autovalidateMode: provider.autovalidateMode,
                            voidCallback: (value) {
                              if ((value == null || value.isEmpty) && !provider.vaccinationCertificateNeverExpire) {
                                return 'Please select Expiry Date';
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
                            fillColor: provider.vaccinationCertificateExpiryDateFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Checkbox(
                            value: provider.vaccinationCertificateNeverExpire,
                            onChanged: (value) {
                              provider.setVaccinationCertificateNeverExpire(value!);
                            },
                          ),
                          Text('Some never expire'),
                        ],
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
                          await provider.showAttachmentOptions(context, 'vaccination_certificate');
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
                                      color: AppColors.Color_9E9E9E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (provider.vaccinationCertificateDocument == null  && provider.autovalidateMode==AutovalidateMode.always)
                        Padding(
                          padding: EdgeInsets.only(top: 1.h, left: 4.w),
                          child: Text("Please select Vaccination Certificate Document",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: AppFontSize.fontSize12,
                            ),
                          ),
                        ),
                      SizedBox(height: 3.h),
                      if (provider.vaccinationCertificateDocument != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.vaccinationCertificateDocument!.path.split('/').last,
                                      style: TextStyle(
                                          fontSize: AppFontSize.fontSize16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.Color_212121,
                                          fontFamily:
                                          AppColors.fontFamilyBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FutureBuilder<int>(
                                      future: provider.vaccinationCertificateDocument!.length(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                            style: TextStyle(
                                                fontSize: AppFontSize.fontSize12,
                                                color: AppColors.Color_616161,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                AppColors.fontFamilyMedium),
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
                                  provider.removeAttachment('vaccination_certificate');
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
                    ],
                  ),
                ),
              ),
            ),
          ),
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

