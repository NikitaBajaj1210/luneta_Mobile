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
import '../../provider/account-provider/profile_provider.dart';
import '../../route/route_constants.dart';

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
      _setupFocusListeners(provider);
    });
  }

  void _setupFocusListeners(ProfileProvider provider) {
    provider.nameFocusNode.addListener(() {
      if (!provider.nameFocusNode.hasFocus && provider.nameController.text.isNotEmpty) {
        provider.validateFieldIfFocused('name', provider.nameController.text);
      }
    });

    provider.nickNameFocusNode.addListener(() {
      if (!provider.nickNameFocusNode.hasFocus && provider.nickNameController.text.isNotEmpty) {
        provider.validateFieldIfFocused('nickname', provider.nickNameController.text);
      }
    });

    provider.emailFocusNode.addListener(() {
      if (!provider.emailFocusNode.hasFocus && provider.emailController.text.isNotEmpty) {
        provider.validateFieldIfFocused('email', provider.emailController.text);
      }
    });

    provider.phoneFocusNode.addListener(() {
      if (!provider.phoneFocusNode.hasFocus && provider.phoneController.text.isNotEmpty) {
        provider.validateFieldIfFocused('phone', provider.phoneController.text);
      }
    });
  }

  @override
  void dispose() {
    var provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.nameFocusNode.dispose();
    provider.nickNameFocusNode.dispose();
    provider.emailFocusNode.dispose();
    provider.phoneFocusNode.dispose();
    provider.dateFocusNode.dispose();
    provider.genderFocusNode.dispose();
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
              profileProvider.emailController.text.isNotEmpty &&
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
                    profileProvider.validateAllFields(context);
                    profileProvider.validatePhone(notify: false);

                    bool isValid = profileProvider.validateFields();
                    if (isValid) {
                      profileProvider.phoneController.clear();
                      Navigator.of(context).pushNamed(createPin);
                      profileProvider.resetForm();
                    }
                    setState(() {

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
                          voidCallback: (value) => profileProvider.validateFieldIfFocused('name', value!),
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.nameFocusNode, 'name'),
                          textColor: profileProvider.getFieldTextColor('name', hasValue: profileProvider.nameController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('name', hasValue: profileProvider.nameController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              profileProvider.validateFieldIfFocused('name', value);
                              profileProvider.markFieldAsSubmitted('name');
                            }
                            FocusScope.of(context).requestFocus(profileProvider.nickNameFocusNode);
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
                          voidCallback: (value) => profileProvider.validateFieldIfFocused('nickname', value!),
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.nickNameFocusNode, 'nickname'),
                          textColor: profileProvider.getFieldTextColor('nickname', hasValue: profileProvider.nickNameController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('nickname', hasValue: profileProvider.nickNameController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              profileProvider.validateFieldIfFocused('nickname', value);
                              profileProvider.markFieldAsSubmitted('nickname');
                            }
                            FocusScope.of(context).requestFocus(profileProvider.emailFocusNode);
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
                          initialDate: DateTime.now(),
                          addDate: profileProvider.addDate,
                          hintText: 'Date of Birth',
                          addDateApi: profileProvider.addDateApi,
                          width: 100.w,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.dateFocusNode, 'date'),
                          textColor: profileProvider.getFieldTextColor('date', hasValue: profileProvider.addDate != 'Date of Birth'),
                          iconColor: profileProvider.getFieldIconColor(profileProvider.dateFocusNode, 'date', hasValue: profileProvider.addDate != 'Date of Birth'),
                          onTap: () async {
                            profileProvider.dateFocusNode.requestFocus();
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now(),
                            );

                            if (selectedDate != null) {
                              profileProvider.addDate = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                              profileProvider.addDateApi = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                              profileProvider.markFieldAsSubmitted('date');
                            }

                            profileProvider.dateFocusNode.unfocus();
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('date', profileProvider.addDate);
                            }
                          },
                          onDateSelected: (selectedDate) {
                            if (selectedDate != null) {
                              profileProvider.addDate = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                              profileProvider.addDateApi = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                              profileProvider.markFieldAsSubmitted('date');
                            }
                            if (profileProvider.hasSubmitted) {
                              profileProvider.validateFieldIfFocused('date', profileProvider.addDate);
                            }
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
                        SizedBox(height: 2.h),
                        customTextField(
                          context: context,
                          focusNode: profileProvider.emailFocusNode,
                          controller: profileProvider.emailController,
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
                          voidCallback: (value) => profileProvider.validateFieldIfFocused('email', value!),
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.emailFocusNode, 'email'),
                          textColor: profileProvider.getFieldTextColor('email', hasValue: profileProvider.emailController.text.isNotEmpty),
                          labelColor: profileProvider.getFieldTextColor('email', hasValue: profileProvider.emailController.text.isNotEmpty),
                          cursorColor: AppColors.Color_212121,
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
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              profileProvider.validateFieldIfFocused('email', value);
                              profileProvider.markFieldAsSubmitted('email');
                            }
                            FocusScope.of(context).requestFocus(profileProvider.phoneFocusNode);
                          },
                          autovalidateMode: profileProvider.autoValidateMode,
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
                        SizedBox(height: 2.h),
                        countryPhoneInput(
                          width: 100.w,
                          phoneNumber: profileProvider.phoneNumber,
                          controller: profileProvider.phoneController,
                          onPhoneChanged: (PhoneNumber newNumber) {
                            profileProvider.phoneNumber = newNumber;
                            profileProvider.validateFieldIfFocused('phone', profileProvider.phoneController.text);
                          },
                          maxLength: 10,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: profileProvider.getFieldBorderColor(profileProvider.phoneFocusNode, 'phone'),
                          labelColor: profileProvider.getFieldTextColor('phone', hasValue: profileProvider.phoneController.text.isNotEmpty),
                          iconColor: profileProvider.getFieldIconColor(profileProvider.phoneFocusNode, 'phone', hasValue: profileProvider.phoneController.text.isNotEmpty),
                          isEditable: true,
                          focusNode: profileProvider.phoneFocusNode,
                          onFieldSubmitted: (value) {
                            profileProvider.phoneFocusNode.unfocus();
                            profileProvider.markFieldAsSubmitted('phone');
                            profileProvider.validatePhone();
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
                                profileProvider.genderFocusNode.unfocus();
                              },
                              items: <String>['Gender', 'Male', 'Female', 'Other']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
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