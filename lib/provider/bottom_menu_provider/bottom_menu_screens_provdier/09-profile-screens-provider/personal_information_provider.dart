import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_picker/country_picker.dart';

class PersonalInformationProvider extends ChangeNotifier {
  List<String> countries = [];

  List<String> religions = [
    "Christianity",
    "Islam",
    "Hinduism",
    "Buddhism",
    "Sikhism",
    "Judaism",
    "Bahai",
    "Jainism",
    "Shinto",
    "Taoism",
    "Zoroastrianism",
    "Atheist",
    "Other"
  ];

  List<String> nearestAirportList = [
    "Hartsfield-Jackson Atlanta International Airport (ATL)",
    "Beijing Capital International Airport (PEK)",
    "Dubai International Airport (DXB)",
    "Los Angeles International Airport (LAX)",
    "Tokyo Haneda Airport (HND)",
    "O'Hare International Airport (ORD)",
    "London Heathrow Airport (LHR)",
    "Shanghai Pudong International Airport (PVG)",
    "Charles de Gaulle Airport (CDG)",
    "Dallas/Fort Worth International Airport (DFW)"
  ];

  PersonalInformationProvider() {
    countries = CountryService().getAll().map((country) => country.name).toList();
  }

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController countryOfBirthController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController NumberOrIDController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController directPhoneController = TextEditingController();

  // FocusNodes for managing focus
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode countryOfBirthFocusNode = FocusNode();
  final FocusNode religionFocusNode = FocusNode();
  final FocusNode nationalityFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode NumberOrIdFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode directPhoneFocusNode = FocusNode();
  final FocusNode sexFocusNode = FocusNode();
  File? _profileImage;
  File? get profileImage => _profileImage;

  bool _showAddSection_communication=false;
  bool get showAddSection_communication=>_showAddSection_communication;

  bool communication_IsEdit=false;
  int? communication_Edit_Index;

  // Phone number field (using the package intl_phone_number_input)
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US'); // Default country (US)
  PhoneNumber directPhoneNumber = PhoneNumber(isoCode: 'US'); // Default country (US)

  // Dropdown values
  String maritalStatus = "Single"; // Default value
  String? nearestAirport; // Default value
  String? platform; // Default value
  int numberOfChildren = 0;
  String sex = "Male"; // Default value


  final List<PlatformEntry> _communicationList = [];

  List<PlatformEntry> get communicationList => _communicationList;

  void setcommunicationVisibility(bool value){
    _showAddSection_communication=value;
    notifyListeners();
  }

  void addCommunicationChannel(PlatformEntry entry) {
    _communicationList.add(entry);
    notifyListeners();
  }

  void removeCommunicationChannel(int index) {
    _communicationList.removeAt(index);
    notifyListeners();
  }

  void updateCommunicationChannel(int index, PlatformEntry updatedEntry) {
    _communicationList[index] = updatedEntry;
    notifyListeners();
  }

  // Function to update phone number
  void setPhoneNumber(String? number) {
    if (number != null) {
      phoneNumber = PhoneNumber(isoCode: 'US', phoneNumber: number);
      phoneController.text = number;
      notifyListeners();
    }
  }
  void setDirectPhoneNumber(String? number) {
    if (number != null) {
      directPhoneNumber = PhoneNumber(isoCode: 'US', phoneNumber: number);
      directPhoneController.text = number;
      notifyListeners();
    }
  }

  Future<void> showAttachmentOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  pickProfileImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  pickProfileImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void pickProfileImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }


}

class PlatformEntry {
  final String platform;
  final String numberOrId;

  PlatformEntry({required this.platform, required this.numberOrId});
}

