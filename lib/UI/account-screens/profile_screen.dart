import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/country_input_field.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
import '../../custom-component/custom_datePicker.dart';
import '../../network/network_helper.dart';
import '../../provider/account-provider/profile_provider.dart';
import '../../provider/account-provider/choose_country_provider.dart';
import '../../route/route_constants.dart';
import '../../custom-component/globalComponent.dart'; // Import for date formatting

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.autoValidateMode = AutovalidateMode.disabled;
      
      // Set the country in the provider if global data exists
      if (ChooseCountryProvider.globalSelectedCountry != null && 
          ChooseCountryProvider.globalSelectedCountryCode != null) {
        provider.setSelectedCountry(
          ChooseCountryProvider.globalSelectedCountry!,
          ChooseCountryProvider.globalSelectedCountryCode!
        );
      }
    });
  }

  // Remove the focus listeners setup to prevent keyboard conflicts
  // void _setupFocusListeners(ProfileProvider provider) {
  //   // This method is removed to prevent keyboard conflicts
  // }

  @override
  void dispose() {
    if (context.mounted) {
      var provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.nameFocusNode.dispose();
      provider.nickNameFocusNode.dispose();
      provider.emailFocusNode.dispose();
      provider.phoneFocusNode.dispose();
      provider.dateFocusNode.dispose();
      provider.genderFocusNode.dispose();
      provider.rankFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          bool isFormValid = profileProvider.nameController.text.isNotEmpty &&
              profileProvider.nickNameController.text.isNotEmpty &&
              // profileProvider.emailController.text.isNotEmpty && // Skip email validation since it's disabled
              profileProvider.phoneController.text.isNotEmpty &&
              profileProvider.addDate != 'Date of Birth' &&
              profileProvider.selectedGender != 'Gender';

          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: isFormValid
                      ? () {
                    // Unfocus all fields before validation to prevent keyboard conflicts
                    profileProvider.unfocusAllFields();
                    
                    // Add a small delay to ensure keyboard is fully dismissed
                    Future.delayed(const Duration(milliseconds: 100), () {
                      profileProvider.safeValidateAllFields(context);
                      profileProvider.safeValidatePhone(notify: false);
                      bool isValid = profileProvider.validateFields();
                      if (isValid) {
                        profileProvider.updateSeafarerProfile(context);
                      }
                      setState(() {});
                    });
                  }
                      : null,
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: isFormValid ? AppColors.buttonColor : AppColors.Color_BDBDBD,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: isFormValid,
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Form(
                    key: profileProvider.formKey,
                    autovalidateMode: profileProvider.autoValidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 1.h),
                        backButtonWithTitle(
                          title: "Fill Your Profile",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 2.h),
                        // Profile Image Section
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                profileProvider.showImageSourceBottomSheet(context);
                              },
                              child: CircleAvatar(
                                radius: 8.h,
                                backgroundColor: AppColors.introBackgroundColor,
                                backgroundImage: profileProvider.profileImage == null
                                    ? const AssetImage("assets/images/dummyProfileImg.png")
                                    : FileImage(profileProvider.profileImage!) as ImageProvider,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    child: Image.asset("assets/images/EditIcon.png", height: 3.h),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 2.h),
                        customTextField(
                          context: context,
                          focusNode: profileProvider.nameFocusNode,
                          controller: profileProvider.nameController,
                          hintText: 'Full Name',
                          textInputType: TextInputType.name,
                          obscureText: false,
                          voidCallback: (value) {
                            // Only validate if form has been submitted
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('name', value!);
                            }
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.nameFocusNode, 'name'),
                          textColor: profileProvider.getFieldTextColor('name', hasValue: profileProvider.nameController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('name', hasValue: profileProvider.nameController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            profileProvider.handleFieldSubmission('name', value);
                            // Use a more stable approach to focus next field
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              FocusScope.of(context).requestFocus(profileProvider.nickNameFocusNode);
                            });
                          },
                          onChange: (value) {
                            // Remove the problematic validation on change
                            // Only update UI state without validation
                            profileProvider.handleTextChange('name', value);
                          },
                          autovalidateMode: profileProvider.autoValidateMode,
                        ),
                        if (profileProvider.nameError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.nameError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 2.h),
                        customTextField(
                          context: context,
                          focusNode: profileProvider.nickNameFocusNode,
                          controller: profileProvider.nickNameController,
                          hintText: 'Nickname',
                          textInputType: TextInputType.name,
                          obscureText: false,
                          voidCallback: (value) {
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('nickname', value!);
                            }
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.nickNameFocusNode, 'nickname'),
                          textColor: profileProvider.getFieldTextColor('nickname', hasValue: profileProvider.nickNameController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('nickname', hasValue: profileProvider.nickNameController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            profileProvider.handleFieldSubmission('nickname', value);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              FocusScope.of(context).requestFocus(profileProvider.emailFocusNode);
                            });
                          },
                          onChange: (value) {
                            profileProvider.handleTextChange('nickname', value);
                          },
                          autovalidateMode: profileProvider.autoValidateMode,
                        ),
                        if (profileProvider.nickNameError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.nickNameError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 2.h),
                        CustomDatePicker(
                          initialDate: DateTime.now(), // This is just for the date picker, not the display
                          addDate: profileProvider.addDate,
                          hintText: 'Date of Birth',
                          addDateApi: profileProvider.addDateApi,
                          width: 100.w,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.dateFocusNode, 'date'),
                          textColor: profileProvider.getFieldTextColor('date', hasValue: profileProvider.addDate != 'Date of Birth'),
                          iconColor: profileProvider.getFieldIconColor(profileProvider.dateFocusNode, 'date', hasValue: profileProvider.addDate != 'Date of Birth'),
                          onTap: () async {
                            // Unfocus current field before showing date picker
                            profileProvider.unfocusAllFields();
                            
                            // Set default date if no date is selected
                            profileProvider.setDefaultDateIfNeeded();
                            
                            // Calculate the maximum date (18 years ago from today)
                            DateTime maxDate = profileProvider.getMaxAllowedDate();
                            DateTime defaultDate = profileProvider.getDefaultDateForPicker();
                            
                            print("=== Date Picker Debug ===");
                            print("Current date: ${DateTime.now()}");
                            print("Max allowed date (18 years ago): $maxDate");
                            print("Default date for picker: $defaultDate");
                            print("Current addDate: ${profileProvider.addDate}");
                            print("User will be 18+ if born on or before: $maxDate");
                            print("=== End Date Picker Debug ===");
                            
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: defaultDate, // Use default date (18 years ago)
                              firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                              lastDate: maxDate, // Maximum date is 18 years ago
                            );

                            if (selectedDate != null) {
                              print("Selected date: $selectedDate");
                              // Format date for age validation (MM/DD/YYYY)
                              String dateForValidation = formatToMMDDYYYY(selectedDate);
                              print("Age validation: ${profileProvider.validateAgeRequirement(dateForValidation)}");
                              
                              // Format date in MM/DD/YYYY format
                              String formattedDate = formatToMMDDYYYY(selectedDate);
                              String formattedDateApi = formatToApiDate(selectedDate);
                              
                              print("Formatted date for UI (MM/DD/YYYY): $formattedDate");
                              print("Formatted date for API: $formattedDateApi");
                              
                              profileProvider.addDate = formattedDate;
                              profileProvider.addDateApi = formattedDateApi;
                              profileProvider.markFieldAsSubmitted('date');
                              
                              if (profileProvider.hasSubmitted) {
                                profileProvider.validateFieldIfFocused('date', profileProvider.addDate);
                              }
                            }
                            setState(() {

                            });
                          },
                          onDateSelected: (selectedDate) {
                            if (selectedDate != null) {
                              // Calculate the maximum allowed date (18 years ago from today)
                              DateTime maxDate = profileProvider.getMaxAllowedDate();
                              
                              // Check if selected date is valid (18 years or older)
                              if (selectedDate.isAfter(maxDate)) {
                                // Show error message for invalid date
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You must be at least 18 years old to register.'),
                                    backgroundColor: AppColors.errorRedColor,
                                  ),
                                );
                                return; // Don't update the date
                              }
                              
                              profileProvider.addDate = formatToMMDDYYYY(selectedDate);
                              profileProvider.addDateApi = formatToApiDate(selectedDate);
                              profileProvider.markFieldAsSubmitted('date');
                              setState(() {

                              });
                            }
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('date', profileProvider.addDate);
                            }
                            setState(() {

                            });
                          },
                          validator: (value) => profileProvider.validateFieldIfFocused('date', value ?? '', notify: false),
                          autovalidateMode: profileProvider.autoValidateMode,

                        ),
                        if (profileProvider.dateError != null)
                          Padding(
                            padding: EdgeInsets.only(left: 4.w, top: 1.h),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.dateError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        // Add hint about age requirement
                        // Padding(
                        //   padding: EdgeInsets.only(left: 4.w, top: 0.5.h),
                        //   child: SizedBox(
                        //     width: 100.w,
                        //     child: Text(
                        //       "You must be at least 18 years old to register",
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //         color: AppColors.Color_9E9E9E,
                        //         fontSize: AppFontSize.fontSize12,
                        //         fontStyle: FontStyle.italic,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 2.h),
                        customTextField(
                          isReadOnly:true,
                          context: context,
                          focusNode: profileProvider.emailFocusNode,
                          controller: profileProvider.emailController,
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
                          voidCallback: (value) {
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('email', value!);
                            }
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.emailFocusNode, 'email'),
                          textColor: profileProvider.getFieldTextColor('email', hasValue: profileProvider.emailController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('email', hasValue: profileProvider.emailController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: null, // Disable submission for read-only field
                          onChange: null, // Disable change handling for read-only field
                          autovalidateMode: profileProvider.autoValidateMode,
                          suffixIcon: Image.asset(
                            "assets/images/emailIcon.png",
                            width: 3.h,
                            height: 3.h,
                            color: profileProvider.getFieldIconColor(
                              profileProvider.emailFocusNode,
                              'email',
                              hasValue: profileProvider.emailController.text.isNotEmpty,
                            ),
                          ),
                        ),
                        if (profileProvider.emailError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.emailError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 2.h,),


                        countryPhoneInput(
                          width: 100.w,
                          phoneNumber: profileProvider.phoneNumber,
                          controller: profileProvider.phoneController,
                          onPhoneChanged: (PhoneNumber newNumber) {
                            profileProvider.handlePhoneChange(newNumber, profileProvider.phoneController.text);
                          },
                          maxLength: 10,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.phoneFocusNode, 'phone'),
                          labelColor: profileProvider.getFieldTextColor('phone', hasValue: profileProvider.phoneController.text.isNotEmpty),
                          iconColor: profileProvider.getFieldIconColor(profileProvider.phoneFocusNode, 'phone', hasValue: profileProvider.phoneController.text.isNotEmpty),
                          isEditable: true,
                          focusNode: profileProvider.phoneFocusNode,
                          onFieldSubmitted: (value) {
                            profileProvider.handleFieldSubmission('phone', value);
                            profileProvider.safeValidatePhone();
                          },
                          validator: (value) => profileProvider.validateFieldIfFocused('phone', value ?? '', notify: false),
                          autovalidateMode: profileProvider.autoValidateMode,
                        ),
                        if (profileProvider.phoneError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.phoneError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () {
                            // Unfocus current field before opening dropdown
                            profileProvider.unfocusAllFields();
                            profileProvider.genderFocusNode.requestFocus();
                          },
                          child: Container(
                            height: 7.2.h,
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                              border: Border.all(
                                width: 1,
                                color: profileProvider.getFieldBorderColor(profileProvider.genderFocusNode, 'gender'),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              focusNode: profileProvider.genderFocusNode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                errorStyle: TextStyle(height: 0, fontSize: 0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              value: profileProvider.selectedGender,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize16,
                                color: profileProvider.getFieldTextColor('gender', hasValue: profileProvider.selectedGender != 'Gender'),
                                fontFamily: profileProvider.selectedGender == 'Gender'
                                    ? AppColors.fontFamilyRegular
                                    : AppColors.fontFamilySemiBold,
                                fontWeight: profileProvider.selectedGender == 'Gender' ? FontWeight.w400 : FontWeight.w600,
                              ),
                              onChanged: (String? newValue) {
                                profileProvider.selectedGender = newValue!;
                                profileProvider.validateGender(newValue);
                                profileProvider.markFieldAsSubmitted('gender');
                                profileProvider.notifyListeners(); // Trigger UI rebuild
                                // Unfocus after selection to prevent keyboard conflicts
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  profileProvider.genderFocusNode.unfocus();
                                });
                              },
                              items: <String>['Gender', 'Male', 'Female', 'Other']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize16,
                                      color: value == 'Gender' ? AppColors.Color_9E9E9E : AppColors.Color_212121,
                                      fontFamily: value == 'Gender' ? AppColors.fontFamilyRegular : AppColors.fontFamilySemiBold,
                                      fontWeight: value == 'Gender' ? FontWeight.w400 : FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                              validator: (value) => profileProvider.validateGender(value ?? 'Gender', notify: false),
                              icon: Image.asset(
                                'assets/images/dropdownIcon.png',
                                height: 2.5.h,
                                color: profileProvider.getFieldIconColor(
                                  profileProvider.genderFocusNode,
                                  'gender',
                                  hasValue: profileProvider.selectedGender != 'Gender',
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (profileProvider.genderError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                profileProvider.genderError!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.errorRedColor,
                                  fontSize: AppFontSize.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}