// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//
// import '../../../../Utils/validation.dart';
// import '../../../../const/color.dart';
// import '../../../../const/font_size.dart';
// import '../../../../custom-component/back_button_with_title.dart';
// import '../../../../custom-component/country_input_field.dart';
// import '../../../../custom-component/custom-button.dart';
// import '../../../../custom-component/customTextField.dart';
// import '../../../../custom-component/custom_datePicker.dart';
// import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/Setting-Screen-Provider/personalInfo_provider.dart';  // For phone number input
//
// class PersonalInformationScreen extends StatefulWidget {
//   const PersonalInformationScreen({super.key});
//
//   @override
//   State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
// }
//
// class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => PersonalInfoProvider(),
//       child: Consumer<PersonalInfoProvider>(
//         builder: (context, provider, child) {
//           return SafeArea(
//             child: Scaffold(
//               backgroundColor: AppColors.Color_FFFFFF,
//               bottomNavigationBar: Container(
//                 height: 11.h,
//                 width: 100.w,
//                 padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
//                 ),
//                 child: customButton(
//                   voidCallback: () {
//                   },
//                   buttonText: "Save",
//                   width: 90.w,
//                   height: 4.h,
//                   color: AppColors.buttonColor,
//                   buttonTextColor: AppColors.buttonTextWhiteColor,
//                   shadowColor: AppColors.buttonBorderColor,
//                   fontSize: AppFontSize.fontSize18,
//                   showShadow: true,
//                 ),
//               ),
//               resizeToAvoidBottomInset: true,
//               body: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Using the existing back button and title component
//                       backButtonWithTitle(
//                         title: "Personal Information",
//                         onBackPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       SizedBox(height: 2.h),
//
//                       // Name Fields - Using customTextField
//                       customTextField(
//                         fontSize: AppFontSize.fontSize16,
//                         inputFontSize: AppFontSize.fontSize16,
//                         textColor: AppColors.Color_212121,
//                         context: context,
//                         controller: TextEditingController(text: provider.name),
//                         focusNode: provider.nameFocusNode,
//                         hintText: 'Full Name',
//                         textInputType: TextInputType.name,
//                         voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
//                         fillColor: provider.nameFocusNode.hasFocus
//                             ? AppColors.activeFieldBgColor
//                             : AppColors.Color_FAFAFA,
//                         onFieldSubmitted: (value) {
//                           provider.nameFocusNode.unfocus();
//                         },
//                       ),
//                       SizedBox(height: 2.h),
//
//                       customTextField(
//                         fontSize: AppFontSize.fontSize16,
//                         inputFontSize: AppFontSize.fontSize16,
//                         textColor: AppColors.Color_212121,
//                         context: context,
//                         controller: TextEditingController(text: provider.lastName),
//                         focusNode: provider.lastNameFocusNode,
//                         hintText: 'Last Name',
//                         textInputType: TextInputType.name,
//                         voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
//                         fillColor: provider.lastNameFocusNode.hasFocus
//                             ? AppColors.activeFieldBgColor
//                             : AppColors.Color_FAFAFA,
//                         onFieldSubmitted: (value) {
//                           provider.lastNameFocusNode.unfocus();
//                         },
//                       ),
//                       SizedBox(height: 2.h),
//
//                       // Custom Date Picker for Date of Birth
//                       // CustomDatePicker(
//                       //   initialDate: DateTime.now(),
//                       //   addDate: provider.dob,
//                       //   hintText: 'Date of Birth',
//                       //   addDateApi: provider.dobApi,
//                       //   width: 100.w,
//                       //   onTap: () async {
//                       //     DateTime? selectedDate = await showDatePicker(
//                       //       context: context,
//                       //       initialDate: DateTime.now(),
//                       //       firstDate: DateTime(1900),
//                       //       lastDate: DateTime.now(),
//                       //     );
//                       //     if (selectedDate != null) {
//                       //       provider.setDob = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//                       //       provider.setDobApi = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
//                       //     }
//                       //   },
//                       // ),
//                       CustomDatePicker(
//                         initialDate: DateTime.now(),
//                         addDate: provider.dob,
//                         hintText: 'Date of Birth',
//                         addDateApi: '',
//                         width: 100.w,
//                         borderColor: provider.getFieldBorderColor(provider.dateFocusNode, 'date'),
//                         textColor: provider.getFieldTextColor('date', hasValue: provider.dob != 'Date of Birth'),
//
//                         onTap: () async {
//                           DateTime? selectedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(DateTime.now().year - 100),
//                             lastDate: DateTime.now(),
//                           );
//
//                           // profileProvider.isShowDateError = selectedDate == null;
//
//                           if (selectedDate != null) {
//                             provider.setDob = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//                             provider.setDobApi = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
//                           }
//
//                           // provider.formKey.currentState?.validate();
//                         },
//                         onDateSelected: (selectedDate) {
//                           if (selectedDate != null) {
//                             provider.setDob = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//                             provider.setDobApi = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
//                           }
//                         },
//                         iconColor: provider.getFieldIconColor(provider.dateFocusNode, 'date', hasValue: provider.dob != 'Date of Birth'),
//
//                       ),
//
//                       SizedBox(height: 2.h),
//
//                       // Gender Dropdown
//                       Container(
//                         width: 100.w,
//                         padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
//                         decoration: BoxDecoration(
//                           color: AppColors.Color_FAFAFA,
//                           borderRadius: BorderRadius.circular(2.h),
//                         ),
//                         child: DropdownButtonFormField<String>(
//                           value: provider.gender.isNotEmpty ? provider.gender : null,
//                           onChanged: (value) {
//                             provider.setGender = value!;
//                           },
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//
//                           icon: Image.asset(
//                             'assets/images/dropdownIcon.png', // Path to your custom icon
//                             height: 2.5.h, // Adjust width as needed
//                           ),
//                           items: <String>['Male', 'Female', 'Other']
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       SizedBox(height: 2.h),
//
//                       // Email TextField - Using customTextField
//                       customTextField(
//                         fontSize: AppFontSize.fontSize16,
//                         inputFontSize: AppFontSize.fontSize16,
//                         textColor: AppColors.Color_212121,
//                         context: context,
//                         controller: provider.emailController,
//                         focusNode: provider.emailFocusNode,
//                         hintText: 'Email',
//                         textInputType: TextInputType.emailAddress,
//                         voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
//                         fillColor: provider.emailFocusNode.hasFocus
//                             ? AppColors.activeFieldBgColor
//                             : AppColors.Color_FAFAFA,
//                         suffixIcon: Image.asset(
//                           "assets/images/emailIcon.png",
//                           width: 2.5.h,
//                           height: 2.5.h,
//                           color: provider.emailFocusNode.hasFocus
//                               ? AppColors.buttonColor
//                               : (provider.emailController.text.isNotEmpty
//                               ? AppColors.Color_212121
//                               : AppColors.Color_BDBDBD),
//                         ),
//                         onFieldSubmitted: (value) {
//                           provider.emailFocusNode.unfocus();
//                         },
//                       ),
//                       SizedBox(height: 2.h),
//
//                       // Phone Number with Country Picker
//                       countryPhoneInput(
//                         // height: 6.h,
//                           width: 100.w,
//                           phoneNumber: provider.phoneNumber,
//                           controller: provider.phoneController,
//                           onPhoneChanged: (PhoneNumber newNumber) {
//                             setState(() {
//                               provider.phoneNumber = newNumber; // Update provider with new number
//                             });
//                           },
//                           maxLength: 10,
//                           backgroundColor: provider.phoneFocusNode.hasFocus
//                               ? AppColors.activeFieldBgColor
//                               : AppColors.Color_FAFAFA,
//                           // hasBorder:provider.phoneFocusNode.hasFocus,
//                           borderColor: provider.phoneFocusNode.hasFocus
//                               ? AppColors.buttonColor
//                               : Colors.transparent,
//                           isEditable: true,
//                           focusNode: provider.phoneFocusNode,
//                           onFieldSubmitted: (value){
//                             provider.phoneFocusNode.unfocus();
//                             setState(() {
//
//                             });
//                           }
//                       ),
//                       SizedBox(height: 2.h),
//
//                       // Job Title TextField - Using customTextField
//                       customTextField(
//                         fontSize: AppFontSize.fontSize16,
//                         inputFontSize: AppFontSize.fontSize16,
//                         textColor: AppColors.Color_212121,
//                         context: context,
//                         controller: TextEditingController(text: provider.jobTitle),
//                         focusNode: provider.jobTitleFocusNode,
//                         hintText: 'Job Title',
//                         textInputType: TextInputType.text,
//                         voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
//                         fillColor: provider.jobTitleFocusNode.hasFocus
//                             ? AppColors.activeFieldBgColor
//                             : AppColors.Color_FAFAFA,
//                         onFieldSubmitted: (value) {
//                           provider.jobTitleFocusNode.unfocus();
//                         },
//                       ),
//                       SizedBox(height: 2.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
