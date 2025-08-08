import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/helper.dart';
import '../../../../custom-component/globalComponent.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../route/route_constants.dart';
import '../../../authentication-provider/login_provider.dart';
import '../profile_bottommenu_provider.dart';

class PersonalInformationProvider extends ChangeNotifier {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? _errorText;

// Getter
  String? get errorText => _errorText;

// Setter
  set errorText(String? value) {
    _errorText = value;
notifyListeners();
  }


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
  String? _profileImage_network;
  String? get profileImage_network => _profileImage_network;

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

  void updateProfileImage(String? url) {
    _profileImage_network= url;
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
      File imageFile = File(pickedFile.path);
      int originalLength = await imageFile.length();

      if (originalLength <= 20971520) {
        XFile? compressedFile = await compressFile(imageFile);
        if (compressedFile != null) {
          _profileImage = File(compressedFile.path);
          notifyListeners();
        }
      } else {
        showToast('File size must be less than 20 MB');
      }
    }
  }

  void setDOB(DateTime date) {
    dobController.text = formatToMMDDYYYYString("${date.toLocal()}".split(' ')[0]);
    print('dob controller => ${dobController.text}');
    notifyListeners();
  }

  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    countryOfBirthController.clear();
    religionController.clear();
    nationalityController.clear();
    emailController.clear();
    addressController.clear();
    NumberOrIDController.clear();
    phoneController.clear();
    directPhoneController.clear();
    _profileImage = null;
    _communicationList.clear();
    setcommunicationVisibility(false);
    notifyListeners();
  }

  Future<void> getPersonalInfo(BuildContext context) async {
    resetForm(); // Reset form before fetching new data
    try {
      var response = await NetworkService().getResponse(
        '$getPersonalInfoProfile${NetworkHelper.loggedInUserId}',
        true,
        context,
        notifyListeners,
      );

      if (response != null && response['statusCode'] == 200) {
        final profileData = response['data'];
        if (profileData != null) {
          firstNameController.text = profileData['firstName'] ?? '';
          lastNameController.text = profileData['lastName'] ?? '';
          emailController.text = profileData['contactEmail'] ?? '';
          phoneController.text = profileData['mobilePhone'] ?? '';
          directPhoneController.text = profileData['directLinePhone'] ?? '';
          sex = profileData['sex'] ?? 'Male';
          nationalityController.text = profileData['nationality'] ?? '';
          religionController.text = profileData['religion'] ?? '';
          countryOfBirthController.text = profileData['countryOfBirth'] ?? '';
          maritalStatus = profileData['maritalStatus'] ?? 'Single';
          numberOfChildren = profileData['numberOfChildren'] ?? 0;
          addressController.text = profileData['homeAddress']==null?'':profileData['homeAddress']['street'] ?? '';
          nearestAirport = profileData['nearestAirport'] ?? '';

          updateProfileImage(profileData['profileURl']);

          if (profileData['dateOfBirth'] != null) {
            final dob = DateTime.parse(profileData['dateOfBirth']);
            setDOB(dob);
          }

          if (profileData['onlineCommunication'] != null) {
            for (var item in profileData['onlineCommunication']) {
              _communicationList.add(PlatformEntry(
                  platform: item['platform'], numberOrId: item['id']));
            }
          }
        }
      } else {
        // Handle error
        ShowToast(
            "Error", response['message'] ?? "Failed to fetch profile data");
      }
    } catch (e) {
      print("Error in getPersonalInfo: $e");
      ShowToast("Error", "An error occurred while fetching profile data.");
    } finally {
      notifyListeners();
    }
  }

  Future<void> updatePersonalInfo(BuildContext context) async {
    if (context.mounted) startLoading(context);

    try {
      NetworkHelper.debugTokenStatus();
      await NetworkHelper.forceSyncUserData();

      var dio = Dio();
      var headers = {
        'Authorization': 'Bearer ${NetworkHelper.token}',
        'Accept': 'application/json',
      };

      var formData = FormData.fromMap({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'dateOfBirth':formatDateForAPI(dobController.text),
        'countryOfBirth': countryOfBirthController.text,
        'contactEmail':emailController.text,
        'religion': religionController.text,
        'sex': sex,
        'currentCountry':'',
        'nationality': nationalityController.text,
        'mobilePhone': phoneController.text,
        'directLinePhone': directPhoneController.text,
        'homeAddress':
        {"street":addressController.text,"city":"","state":"","postalCode":"","country":""},
        'nearestAirport': nearestAirport ?? '',
        'maritalStatus': maritalStatus,
        'numberOfChildren': numberOfChildren.toString(),
        'onlineCommunication': _communicationList.map((e) => {'platform': e.platform, 'id': e.numberOrId}).toList(),
        'userId': NetworkHelper.loggedInUserId,
      });
      print(formatDateForAPI(dobController.text));

      if (profileImage != null) {
        String? mimeType = lookupMimeType(profileImage!.path);
        if (mimeType == null || !mimeType.startsWith('image/')) {
          if (context.mounted) {
            stopLoading(context);
            ShowToast("Error", "Invalid file type. Please select an image file.");
          }
          return;
        }

        formData.files.add(
          MapEntry(
            'profilePhoto',
            await MultipartFile.fromFile(
              profileImage!.path,
              filename: profileImage!.path.split('/').last,
              contentType: MediaType.parse(mimeType),
            ),
          ),
        );
      }
      var response = await dio.post(
        seafarerProfileBasicInfo,
        data: formData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          ShowToast("Success", response.data['message'] ?? "Personal Information updated successfully");
          if (context.mounted) stopLoading(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<ProfileBottommenuProvider>(
                context,
                listen: false).getProfileInfo(context);
          });
          Navigator.of(context).pushNamed(bottomMenu);
          resetForm();
        }
      } else {
        if (context.mounted) {
          ShowToast("Error", response.data['message'] ?? "Something went wrong");
          if (context.mounted) stopLoading(context);
        }
      }

    } on DioException catch (e) {
      if (context.mounted) {
        if (context.mounted) stopLoading(context);

        if (e.response?.statusCode == 401) {
          ShowToast("Error", "Session expired. Please log in again.");
          var loginProvider = Provider.of<LoginProvider>(context, listen: false);
          await loginProvider.clearStoredLoginData();
          NetworkHelper().removeToken(context);
          Navigator.of(context).pushReplacementNamed(login);
        } else if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          ShowToast("Error", e.response?.data['message'] ?? "Bad request");
        } else {
          ShowToast("Error", "Something went wrong");
        }
      }
    } catch (e) {
      print("Seafarer personal info Update Error: $e");
      if (context.mounted) {
        if (context.mounted) stopLoading(context);
        ShowToast("Error", "Something went wrong");
      }
    }
    notifyListeners();
  }
}

class PlatformEntry {
  final String platform;
  final String numberOrId;

  PlatformEntry({required this.platform, required this.numberOrId});
}
