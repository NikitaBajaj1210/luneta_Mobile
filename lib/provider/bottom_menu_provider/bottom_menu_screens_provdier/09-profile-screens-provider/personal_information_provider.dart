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
import '../../../../network/network_service_dio.dart';
import '../../../../network/network_services.dart';
import '../../../../route/route_constants.dart';
import '../../../authentication-provider/login_provider.dart';

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
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setDOB(DateTime date) {
    dobController.text = formatToMMDDYYYYString("${date.toLocal()}".split(' ')[0]);
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

      bool isSessionValid = await NetworkHelper.validateSession();
      if (!isSessionValid) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "Session expired. Please log in again.");
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            login,
                (route) => false,
          );
        }
        return;
      }

      String? userId = NetworkHelper.loggedInUserId;
      String? token = NetworkHelper.token;
      if (token == null || token.isEmpty) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "Session expired. Please log in again.");
        if (context.mounted) NetworkHelper().removeToken(context);
        return;
      }

      if (userId == null || userId.isEmpty) {
        if (context.mounted) stopLoading(context);
        if (context.mounted) ShowToast("Error", "User ID not found. Please log in again.");
        return;
      }

      var dio = Dio();
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Language': 'en'
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
      if (context.mounted) stopLoading(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          ShowToast("Success", response.data['message'] ?? "Personal Information updated successfully");
          if (context.mounted) stopLoading(context);
          Navigator.of(context).pushNamed(bottomMenu);
          resetForm();
        }
      } else {
        if (context.mounted) {
          if (context.mounted) stopLoading(context);
          ShowToast("Error", response.data['message'] ?? "Something went wrong");
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



//   Future<bool> updatePersonalInfo(BuildContext context) async {
//     try {
//       Map<String, String> fieldData = {
//         'firstName': firstNameController.text,
//         'lastName': lastNameController.text,
//         'dateOfBirth':formatDateForAPI(dobController.text),
//         'countryOfBirth': countryOfBirthController.text,
//         'contactEmail':emailController.text,
//         'religion': religionController.text,
//         'sex': sex,
//         'currentCountry':'',
//         'nationality': nationalityController.text,
//         'mobilePhone': phoneController.text,
//         'directLinePhone': directPhoneController.text,
//         'homeAddress':
//         jsonEncode({"street":addressController.text,"city":"","state":"","postalCode":"","country":""}),
//         'nearestAirport': nearestAirport ?? '',
//         'maritalStatus': maritalStatus,
//         'numberOfChildren': numberOfChildren.toString(),
//         'onlineCommunication': jsonEncode(_communicationList.map((e) => {'platform': e.platform, 'id': e.numberOrId}).toList()),
//         'userId': NetworkHelper.loggedInUserId,
//       };
//
//       List<http.MultipartFile> fileList = [];
//
//       if (_profileImage != null) {
//         String? mimeType = lookupMimeType(_profileImage!.path);
//         fileList.add(
//           await http.MultipartFile.fromPath(
//             'profilePhoto',
//             _profileImage!.path,
//             contentType: MediaType.parse(mimeType!),
//           ),
//         );
//       }
//
// // Convert http.MultipartFile to dio.MultipartFile
//       List<dio.MultipartFile> dioFileList = await convertHttpToDioFiles(fileList);
//
//       var response = await NetworkServiceDio().multipartSeafarerProfile(
//         context,
//         postUpdatePersonalInfo,
//         fieldData,
//         dioFileList,
//         true,
//         notifyListeners,
//       );
//
//       if (response['statusCode'] == 200 || response['statusCode'] == 201) {
//         ShowToast("Success", response['message'] ?? "Profile updated successfully");
//         await getPersonalInfo(context);
//         return true;
//       } else {
//         ShowToast("Error", response['message'] ?? "Failed to update profile");
//         return false;
//       }
//     } catch (e) {
//       print("Error in updatePersonalInfo: $e");
//       ShowToast("Error", "An error occurred while updating profile.");
//       return false;
//     }
//   }
//
//
//   Future<List<dio.MultipartFile>> convertHttpToDioFiles(List<http.MultipartFile> fileList) async {
//     List<dio.MultipartFile> dioFiles = [];
//
//     for (var file in fileList) {
//       final bytes = await _readStreamBytes(file.finalize());
//       final filename = file.filename ?? 'upload.jpg';
//       dio.MultipartFile dioFile = dio.MultipartFile.fromBytes(
//         bytes,
//         filename: filename,
//         contentType: file.contentType,
//       );
//       dioFiles.add(dioFile);
//     }
//
//     return dioFiles;
//   }
//
//   Future<List<int>> _readStreamBytes(Stream<List<int>> stream) async {
//     final completer = Completer<List<int>>();
//     final collected = <int>[];
//
//     stream.listen(
//       collected.addAll,
//       onDone: () => completer.complete(collected),
//       onError: (e) => completer.completeError(e),
//       cancelOnError: true,
//     );
//
//     return completer.future;
//   }




}

class PlatformEntry {
  final String platform;
  final String numberOrId;

  PlatformEntry({required this.platform, required this.numberOrId});
}
