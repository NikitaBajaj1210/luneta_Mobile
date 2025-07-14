import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/travel_document_provider.dart';

class TravelDocumentScreen extends StatefulWidget {
  const TravelDocumentScreen({super.key});

  @override
  State<TravelDocumentScreen> createState() => _TravelDocumentScreenState();
}

class _TravelDocumentScreenState extends State<TravelDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TravelDocumentProvider>(
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
                  final error = provider.validate();
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // Save the data in provider or update the profile here
                    Navigator.pop(context);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Title
                    backButtonWithTitle(
                      title: "Travel Documents & Credentials",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Seafarer’s Registration No.
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Seafarer’s Registration No.',
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
                      controller: provider.seafarerRegistrationNoController,
                      hintText: 'Enter Seafarer’s Registration No.',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.seafarerRegistrationNoFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),

                    // Passport
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Passport',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Passport UI
                    customTextField(
                      context: context,
                      controller: provider.passportNoController,
                      hintText: 'Enter Passport No.',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.passportNoFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    SizedBox(height: 1.h),
                    // Country Dropdown
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setPassportIssueDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.passportIssueDateController,
                          hintText: 'Select Issue Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.passportIssueDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setPassportExpiryDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.passportExpiryDateController,
                          hintText: 'Select Expiry Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.passportExpiryDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () {
                        provider.pickPassportDocument();
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.passportDocumentController,
                          hintText: 'Attach Document',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.passportDocumentFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),

                    // Seaman’s Book
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Seaman’s Book',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Seaman’s Book UI
                    customTextField(
                      context: context,
                      controller: provider.seamanBookNoController,
                      hintText: 'Enter Seaman’s Book No.',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.seamanBookNoFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    SizedBox(height: 1.h),
                    // Issuing Country Dropdown
                    SizedBox(height: 1.h),
                    customTextField(
                      context: context,
                      controller: provider.seamanIssuingAuthorityController,
                      hintText: 'Enter Issuing Authority',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.seamanIssuingAuthorityFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setSeamanIssueDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.seamanIssueDateController,
                          hintText: 'Select Issue Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seamanIssueDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setSeamanExpiryDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.seamanExpiryDateController,
                          hintText: 'Select Expiry Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seamanExpiryDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Checkbox(
                          value: provider.seamanNeverExpire,
                          onChanged: (value) {
                            provider.setSeamanNeverExpire(value!);
                          },
                        ),
                        Text('Some never expire'),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    // Nationality Dropdown
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () {
                        provider.pickSeamanDocument();
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.seamanDocumentController,
                          hintText: 'Attach Document',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seamanDocumentFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),

                    // Valid Seafarer’s Visa
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Valid Seafarer’s Visa',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Valid Seafarer’s Visa UI
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: provider.validSeafarerVisa,
                          onChanged: (value) {
                            provider.setValidSeafarerVisa(value!);
                          },
                        ),
                        Text('Yes'),
                        Radio(
                          value: false,
                          groupValue: provider.validSeafarerVisa,
                          onChanged: (value) {
                            provider.setValidSeafarerVisa(value!);
                          },
                        ),
                        Text('No'),
                      ],
                    ),
                    if (provider.validSeafarerVisa)
                      Column(
                        children: [
                          SizedBox(height: 1.h),
                          // Issuing Country Dropdown
                          SizedBox(height: 1.h),
                          customTextField(
                            context: context,
                            controller: provider.seafarerVisaNoController,
                            hintText: 'Enter Visa No.',
                            textInputType: TextInputType.text,
                            obscureText: false,
                            voidCallback: (value) {},
                            fontSize: AppFontSize.fontSize16,
                            inputFontSize: AppFontSize.fontSize16,
                            backgroundColor: AppColors.Color_FAFAFA,
                            borderColor: AppColors.buttonColor,
                            textColor: Colors.black,
                            labelColor: AppColors.Color_9E9E9E,
                            cursorColor: AppColors.Color_212121,
                            fillColor: provider.seafarerVisaNoFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                          ),
                          SizedBox(height: 1.h),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                provider.setSeafarerVisaIssueDate(picked);
                              }
                            },
                            child: AbsorbPointer(
                              child: customTextField(
                                context: context,
                                controller: provider.seafarerVisaIssueDateController,
                                hintText: 'Select Issue Date',
                                textInputType: TextInputType.datetime,
                                obscureText: false,
                                voidCallback: (value) {},
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: provider.seafarerVisaIssueDateFocusNode.hasFocus
                                    ? AppColors.activeFieldBgColor
                                    : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                provider.setSeafarerVisaExpiryDate(picked);
                              }
                            },
                            child: AbsorbPointer(
                              child: customTextField(
                                context: context,
                                controller: provider.seafarerVisaExpiryDateController,
                                hintText: 'Select Expiry Date',
                                textInputType: TextInputType.datetime,
                                obscureText: false,
                                voidCallback: (value) {},
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: provider.seafarerVisaExpiryDateFocusNode.hasFocus
                                    ? AppColors.activeFieldBgColor
                                    : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          GestureDetector(
                            onTap: () {
                              provider.pickSeafarerVisaDocument();
                            },
                            child: AbsorbPointer(
                              child: customTextField(
                                context: context,
                                controller: provider.seafarerVisaDocumentController,
                                hintText: 'Attach Document',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                voidCallback: (value) {},
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: provider.seafarerVisaDocumentFocusNode.hasFocus
                                    ? AppColors.activeFieldBgColor
                                    : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                              ),
                            ),
                          ),
                        ],
                      ),

                    // Visa
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Visa',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Visa UI
                    // Issuing Country Dropdown
                    SizedBox(height: 1.h),
                    customTextField(
                      context: context,
                      controller: provider.visaNoController,
                      hintText: 'Enter Visa No.',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.visaNoFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setVisaIssueDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.visaIssueDateController,
                          hintText: 'Select Issue Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.visaIssueDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setVisaExpiryDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.visaExpiryDateController,
                          hintText: 'Select Expiry Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.visaExpiryDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () {
                        provider.pickVisaDocument();
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.visaDocumentController,
                          hintText: 'Attach Document',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.visaDocumentFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),

                    // Residence Permit
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Residence Permit',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Residence Permit UI
                    // Issuing Country Dropdown
                    SizedBox(height: 1.h),
                    customTextField(
                      context: context,
                      controller: provider.residencePermitNoController,
                      hintText: 'Enter No.',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.residencePermitNoFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setResidencePermitIssueDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.residencePermitIssueDateController,
                          hintText: 'Select Issue Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.residencePermitIssueDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setResidencePermitExpiryDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.residencePermitExpiryDateController,
                          hintText: 'Select Expiry Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.residencePermitExpiryDateFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: () {
                        provider.pickResidencePermitDocument();
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.residencePermitDocumentController,
                          hintText: 'Attach Document',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.residencePermitDocumentFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                      ),
                    ),
                  ],
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
