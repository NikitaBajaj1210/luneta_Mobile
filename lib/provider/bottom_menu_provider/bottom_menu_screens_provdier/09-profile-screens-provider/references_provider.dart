import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ReferencesProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode companyFocusNode = FocusNode();
  FocusNode occupationFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');

  //
  // PhoneNumber? _phoneNumber; // Nullable PhoneNumber
  //
  // PhoneNumber? get phoneNumber => _phoneNumber;  // Getter remains nullable
  //
  // set phoneNumber(PhoneNumber? value) {  // Setter allows nullable value
  //   _phoneNumber = value;
  //   notifyListeners();
  // }

  // Setter and Getter for other fields
  String get name => nameController.text;
  String get company => companyController.text;
  String get occupation => occupationController.text;
  String get email => emailController.text;

  void setName(String value) {
    nameController.text = value;
    notifyListeners();
  }

  void setCompany(String value) {
    companyController.text = value;
    notifyListeners();
  }

  void setOccupation(String value) {
    occupationController.text = value;
    notifyListeners();
  }

  void setEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  // Method to handle Phone Number format updates
  // void updatePhoneNumber(PhoneNumber? newNumber) {  // Accepts nullable PhoneNumber
  //   _phoneNumber = newNumber;
  //   if (newNumber != null) {
  //     phoneController.text = newNumber.phoneNumber!;
  //   }
  //   notifyListeners();
  // }

  void initializeWithData(Map<String, dynamic> reference) {
    nameController.text = reference['name'] ?? '';
    companyController.text = reference['company'] ?? '';
    occupationController.text = reference['occupation'] ?? '';
    emailController.text = reference['email'] ?? '';
    
    // Handle phone number
    if (reference['phoneNumber'] != null) {
      phoneController.text = reference['phoneNumber'];
      // Initialize with default region code since we're getting a string
      // _phoneNumber = PhoneNumber(phoneNumber: reference['phoneNumber'], isoCode: 'US');
    } else {
      phoneController.clear();
      // _phoneNumber = null;
    }
    
    notifyListeners();
  }

  void resetForm() {
    nameController.clear();
    companyController.clear();
    occupationController.clear();
    emailController.clear();
    phoneController.clear();
    // _phoneNumber = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    companyController.dispose();
    occupationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    companyFocusNode.dispose();
    occupationFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }
}
