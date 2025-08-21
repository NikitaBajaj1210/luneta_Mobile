import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Utils/validation.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/country_input_field.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/references_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ReferencesScreen extends StatefulWidget {
  const ReferencesScreen({super.key});

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  String? phoneError; // Store error message

  @override
  Widget build(BuildContext context) {
    return Consumer<ReferencesProvider>(
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
                  if (provider.nameController.text.isEmpty || provider.companyController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all required fields')),
                    );
                    return;
                  }

                  // Add reference to profile provider
                  // profileProvider.addReference(
                  //   name: provider.nameController.text,
                  //   company: provider.companyController.text,
                  //   occupation: provider.occupationController.text,
                  //   email: provider.emailController.text,
                  //   phoneNumber: provider.phoneNumber?.phoneNumber ?? '',
                  // );

                  // Navigate back to Profile Screen after saving the data
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
                        title: "References",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  _buildLabel("Name"),
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.nameController,
                    focusNode: provider.nameFocusNode,
                    hintText: "David Alexander",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (value) {
                      provider.nameFocusNode.unfocus();
                    },
                  ),

                  _buildLabel("Company"),
                  customTextField(
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.companyController,
                    focusNode: provider.companyFocusNode,
                    hintText: "Paypal Inc.",
                    textInputType: TextInputType.text,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    onFieldSubmitted: (value) {
                      provider.companyFocusNode.unfocus();
                    },
                  ),

                  _buildLabel("Occupation"),
                  customTextField(
                    context: context,
                    textColor: AppColors.Color_212121,
                    controller: provider.occupationController,
                    focusNode: provider.occupationFocusNode,
                    hintText: "Supervisor",
                    textInputType: TextInputType.text,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    onFieldSubmitted: (value) {
                      provider.occupationFocusNode.unfocus();
                    },
                  ),

                  _buildLabel("Email"),
                  customTextField(
                    context: context,
                    textColor: AppColors.Color_212121,
                    focusNode: provider.emailFocusNode,
                    controller: provider.emailController,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    voidCallback: validateEmail,
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    backgroundColor: AppColors.Color_FAFAFA,
                    borderColor: AppColors.buttonColor,
                    labelColor: AppColors.Color_9E9E9E,
                    cursorColor: AppColors.Color_212121,
                    prefixIcon: Image.asset(
                      "assets/images/emailIcon.png",
                      width: 2.5.h,
                      height: 2.5.h,
                      color: provider.emailController.text.isNotEmpty
                          ? AppColors.Color_212121
                          : AppColors.Color_BDBDBD,
                    ),
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                  ),

                  _buildLabel("Phone Number"),
                  countryPhoneInput(
                    // height: 6.h,
                    onFieldSubmitted: (value){
                      provider.phoneFocusNode.unfocus();
                    },
                    width: 100.w,
                    phoneNumber: provider.phoneNumber ?? PhoneNumber(isoCode: 'US'), // Default to US if null
                    controller: provider.phoneController,
                    onPhoneChanged: (PhoneNumber newNumber) {
                      provider.phoneNumber = newNumber;
                    },
                    maxLength: 10,
                    backgroundColor: AppColors.Color_FAFAFA,
                    borderColor: Colors.transparent,
                    isEditable: true,
                    focusNode: provider.phoneFocusNode,
                  ),

                ],
              ),
            )));
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
}
