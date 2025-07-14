// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//
// import '../../../../const/color.dart';
//
// class PersonalInfoProvider with ChangeNotifier {
//   // FocusNodes for each field
//   final FocusNode nameFocusNode = FocusNode();
//   final FocusNode lastNameFocusNode = FocusNode();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode jobTitleFocusNode = FocusNode();
//   final FocusNode phoneFocusNode = FocusNode();
//   final FocusNode dateFocusNode = FocusNode();
//
//   String _dob = 'Date of Birth';
//   String _dobApi = '';
//   String _name = '';
//   String _lastName = '';
//   String _gender = 'Male';
//   String _email = '';
//   String _jobTitle = '';
//   PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US', phoneNumber: '');
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//
//   String get dob => _dob;
//   String get dobApi => _dobApi;
//   String get name => _name;
//   String get lastName => _lastName;
//   String get gender => _gender;
//   String get email => _email;
//   String get jobTitle => _jobTitle;
//   // PhoneNumber get phoneNumber => _phoneNumber;
//   TextEditingController get phoneController => _phoneController;
//   PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');
//
//
//   set setDob(String value) {
//     _dob = value;
//     notifyListeners();
//   }
//
//   set setDobApi(String value) {
//     _dobApi = value;
//     notifyListeners();
//   }
//
//   set setName(String value) {
//     _name = value;
//     notifyListeners();
//   }
//
//   set setLastName(String value) {
//     _lastName = value;
//     notifyListeners();
//   }
//
//   set setGender(String value) {
//     _gender = value;
//     notifyListeners();
//   }
//
//   set setEmail(String value) {
//     _email = value;
//     notifyListeners();
//   }
//
//   set setJobTitle(String value) {
//     _jobTitle = value;
//     notifyListeners();
//   }
//
//   set setPhoneNumber(PhoneNumber phoneNumber) {
//     _phoneNumber = phoneNumber;
//     notifyListeners();
//   }
//
//   // Make sure to dispose focus nodes when they are no longer needed
//   @override
//   void dispose() {
//     nameFocusNode.dispose();
//     lastNameFocusNode.dispose();
//     emailFocusNode.dispose();
//     jobTitleFocusNode.dispose();
//     phoneFocusNode.dispose();
//     super.dispose();
//   }
//
//   Color getFieldBorderColor(FocusNode focusNode, String fieldName) {
//     if (focusNode.hasFocus) {
//       return AppColors.buttonColor;
//     } else if (isFieldSubmitted(fieldName) && !focusNode.hasFocus) {
//       return Colors.transparent;
//     }
//     return Colors.transparent;
//   }
//
//   Set<String> _submittedFields = {};
//
//   bool isFieldSubmitted(String fieldName) {
//     return _submittedFields.contains(fieldName);
//   }
//
//   Color getFieldIconColor(FocusNode focusNode, String fieldName, {bool hasValue = false}) {
//     if (focusNode.hasFocus) {
//       return AppColors.buttonColor;
//     } else if (isFieldSubmitted(fieldName) || hasValue) {
//       return AppColors.Color_212121;
//     }
//     return AppColors.Color_9E9E9E;
//   }
//
//
//   Color getFieldTextColor(String fieldName, {bool hasValue = false}) {
//     if (isFieldSubmitted(fieldName) || hasValue) {
//       return AppColors.Color_212121;
//     }
//     return AppColors.Color_9E9E9E;
//   }
//
// }
