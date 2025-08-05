// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import '../../../../models/rank_model.dart';
// import '../../../../network/app_url.dart';
// import '../../../../network/network_helper.dart';
// import '../../../../network/network_services.dart';
//
//
// // Enums for dropdown values
// enum RankType {
//   captain('Captain'),
//   chiefOfficer('Chief Officer'),
//   secondOfficer('Second Officer'),
//   thirdOfficer('Third Officer'),
//   engineer('Engineer'),
//   other('Other');
//
//   const RankType(this.value);
//   final String value;
// }
//
// enum ContractType {
//   voyage('Voyage'),
//   permanent('Permanent');
//
//   const ContractType(this.value);
//   final String value;
// }
//
// enum AvailabilityStatus {
//   available('Available'),
//   onboard('Onboard'),
//   onLeave('On Leave'),
//   other('Other');
//
//   const AvailabilityStatus(this.value);
//   final String value;
// }
//
// class JobConditionsAndPreferencesProvider with ChangeNotifier {
//   bool isLoading = false;
//   bool hasError = false;
//   String errorMessage = '';
//
//   final formKey = GlobalKey<FormState>();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
//
//   String? currentRank;
//   String? alternateRank;
//   List<String> preferredVesselTypes = [];
//   String? preferredContractType;
//   String? preferredPosition;
//   String? manningAgency;
//   String? currentAvailabilityStatus;
//   DateTime? availableFrom;
//   TextEditingController minOnBoardDurationController = TextEditingController();
//   TextEditingController maxOnBoardDurationController = TextEditingController();
//   TextEditingController minAtHomeDurationController = TextEditingController();
//   TextEditingController maxAtHomeDurationController = TextEditingController();
//   String? preferredRotationPattern;
//   List<String> tradingAreaExclusions = [];
//   TextEditingController lastJobSalaryController = TextEditingController();
//   String? lastRankJoined;
//   DateTime? lastPromotedDate;
//   String? currency;
//   File? justificationDocument;
//
//   // // Dynamic lists from API
//   List<RankData> _ranks = [];
//
//   // Getter for ranks list
//   List<RankData> get ranks => _ranks;
//
//   // Setter for ranks list
//   set ranks(List<RankData>? newRanks) {
//     _ranks = newRanks ?? [];
//     notifyListeners();
//   }
//
//
//
//   // List<String> vesselTypes = ["Tanker", "Bulker", "Container", "Gas Carrier", "Offshore"];
//   // List<String> manningAgencies = ["Maersk", "MSC", "CMA CGM", "Cosco", "Hapag-Lloyd"];
//   // List<String> rotationPatterns = ["3/3", "4/2", "6/6"];
//   // List<String> tradingAreas = ["Worldwide", "Europe", "Asia", "America"];
//   // List<String> currencies = ["USD", "EUR", "GBP"];
//
//   // Enum-based lists
//   List<String> get rankTypes => RankType.values.map((e) => e.value).toList();
//   List<String> get contractTypes => ContractType.values.map((e) => e.value).toList();
//   List<String> get availabilityStatuses => AvailabilityStatus.values.map((e) => e.value).toList();
//
//   // Helper methods to validate enum values
//   bool isValidRank(String? value) {
//     if (value == null || value.isEmpty) return true; // Allow empty values
//     return rankTypes.contains(value);
//   }
//
//   bool isValidContractType(String? value) {
//     if (value == null || value.isEmpty) return true; // Allow empty values
//     return contractTypes.contains(value);
//   }
//
//   bool isValidAvailabilityStatus(String? value) {
//     if (value == null || value.isEmpty) return true; // Allow empty values
//     return availabilityStatuses.contains(value);
//   }
//
//   void setCurrentRank(String value) {
//     currentRank = value;
//     notifyListeners();
//   }
//
//   void setAlternateRank(String value) {
//     alternateRank = value;
//     notifyListeners();
//   }
//
//   void setPreferredVesselTypes(List<String> values) {
//     preferredVesselTypes = values;
//     notifyListeners();
//   }
//
//   void setPreferredContractType(String value) {
//     preferredContractType = value;
//     notifyListeners();
//   }
//
//   void setPreferredPosition(String value) {
//     preferredPosition = value;
//     notifyListeners();
//   }
//
//   void setManningAgency(String value) {
//     manningAgency = value;
//     notifyListeners();
//   }
//
//   void setCurrentAvailabilityStatus(String value) {
//     currentAvailabilityStatus = value;
//     notifyListeners();
//   }
//
//   void setAvailableFrom(DateTime date) {
//     availableFrom = date;
//     notifyListeners();
//   }
//
//   void setPreferredRotationPattern(String value) {
//     preferredRotationPattern = value;
//     notifyListeners();
//   }
//
//   void setTradingAreaExclusions(List<String> values) {
//     tradingAreaExclusions = values;
//     notifyListeners();
//   }
//
//   void setLastRankJoined(String value) {
//     lastRankJoined = value;
//     notifyListeners();
//   }
//
//   void setLastPromotedDate(DateTime date) {
//     lastPromotedDate = date;
//     notifyListeners();
//   }
//
//   void setCurrency(String value) {
//     currency = value;
//     notifyListeners();
//   }
//
//   void setJustificationDocument(File? file) {
//     justificationDocument = file;
//     notifyListeners();
//   }
//
//   void removeJustificationDocument() {
//     justificationDocument = null;
//     notifyListeners();
//   }
//
//   // File Picker
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> showAttachmentOptions(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Choose from gallery'),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text('Take a picture'),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.description),
//                 title: Text('Choose a document'),
//                 onTap: () {
//                   _pickDocument();
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _pickDocument() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//     if (result != null) {
//       final file = File(result.files.single.path!);
//       setJustificationDocument(file);
//     }
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       setJustificationDocument(file);
//     }
//   }
//
//
//   Future<void> GetAllRank(BuildContext context) async {
//     try {
//       var response = await NetworkService().getResponse(
//         getAllRank,
//         false,
//         context,
//         () {},
//       );
//       print("RESPONSE ++>>> $response");
//       if (response.isNotEmpty) {
//         final profileData = GetAllRankModel.fromJson(response);
//         if (profileData.statusCode == 200) {
//           ranks = profileData.data ?? []; // Use setter to update ranks
//         } else {
//           ranks = []; // Clear ranks on error
//           print("Error: Status code ${profileData.statusCode}, Message: ${profileData.message}");
//         }
//       } else {
//         ranks = []; // Clear ranks if response is empty
//         print("Error: Empty response from server");
//       }
//       notifyListeners();
//     } catch (e) {
//       ranks = []; // Clear ranks on exception
//       print("Error in getAllRank: $e");
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchJobConditionsData(BuildContext context) async {
//     isLoading = true;
//     hasError = false;
//     errorMessage = '';
//     notifyListeners();
//
//     try {
//       // First fetch ranks
//       await GetAllRank(context);
//
//       String userId = NetworkHelper.loggedInUserId;
//       if (userId.isEmpty) {
//         hasError = true;
//         errorMessage = 'User ID not found';
//         isLoading = false;
//         notifyListeners();
//         return;
//       }
//
//       final response = await NetworkService().getResponse(
//         getJobConditionsByUserId + userId,
//         false,
//         context,
//         () => notifyListeners(),
//       );
//
//       if (response['statusCode'] == 200 && response['data'] != null && response['data'].isNotEmpty) {
//         _populateFormData(response['data'][0]);
//       } else {
//         hasError = true;
//         errorMessage = response['message'] ?? 'Failed to fetch job conditions';
//       }
//     } catch (e) {
//       hasError = true;
//       errorMessage = 'Network error: ${e.toString()}';
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//   void _populateFormData(Map<String, dynamic> data) {
//     // Handle rank fields - use API data if available, fallback to enum validation
//     currentRank = data['currentRank'] ?? '';
//     if (currentRank!.isNotEmpty && !ranks.contains(currentRank)) {
//       // If API rank is not in our fetched ranks, check if it's a valid enum value
//       if (!isValidRank(currentRank)) {
//         currentRank = ''; // Reset if not valid
//       }
//     }
//
//     alternateRank = data['alternateRank'] ?? '';
//     if (alternateRank!.isNotEmpty && !ranks.contains(alternateRank)) {
//       if (!isValidRank(alternateRank)) {
//         alternateRank = '';
//       }
//     }
//
//     preferredPosition = data['preferredPosition'] ?? '';
//     if (preferredPosition!.isNotEmpty && !ranks.contains(preferredPosition)) {
//       if (!isValidRank(preferredPosition)) {
//         preferredPosition = '';
//       }
//     }
//
//     lastRankJoined = data['lastRankJoined'] ?? '';
//     if (lastRankJoined!.isNotEmpty && !ranks.contains(lastRankJoined)) {
//       if (!isValidRank(lastRankJoined)) {
//         lastRankJoined = '';
//       }
//     }
//
//     // Handle enum-based fields
//     preferredContractType = data['preferredContractType'] ?? '';
//     if (preferredContractType!.isNotEmpty && !isValidContractType(preferredContractType)) {
//       preferredContractType = '';
//     }
//
//     currentAvailabilityStatus = data['currentAvailabilityStatus'] ?? '';
//     if (currentAvailabilityStatus!.isNotEmpty && !isValidAvailabilityStatus(currentAvailabilityStatus)) {
//       currentAvailabilityStatus = '';
//     }
//
//     // Handle other fields
//     preferredVesselTypes = (data['preferredVesselType'] as List?)?.map((e) => e.toString()).toList() ?? [];
//     manningAgency = data['manningAgency'] ?? '';
//     availableFrom = data['availableFrom'] != null ? DateTime.tryParse(data['availableFrom']) : null;
//     minOnBoardDurationController.text = data['minOnBoardDuration']?.toString() ?? '';
//     maxOnBoardDurationController.text = data['maxOnBoardDuration']?.toString() ?? '';
//     minAtHomeDurationController.text = data['minAtHomeDuration']?.toString() ?? '';
//     maxAtHomeDurationController.text = data['maxAtHomeDuration']?.toString() ?? '';
//     preferredRotationPattern = data['preferredRotationPattern'] ?? '';
//
//     // Handle both string and list for tradingAreaExclusions
//     if (data['tradingAreaExclusions'] is List) {
//       tradingAreaExclusions = (data['tradingAreaExclusions'] as List).map((e) => e.toString()).toList();
//     } else if (data['tradingAreaExclusions'] is String) {
//       tradingAreaExclusions = [data['tradingAreaExclusions']];
//     } else {
//       tradingAreaExclusions = [];
//     }
//
//     lastJobSalaryController.text = data['lastJobSalary']?.toString() ?? '';
//     lastPromotedDate = data['lastPromotedDate'] != null ? DateTime.tryParse(data['lastPromotedDate']) : null;
//     currency = data['currency'] ?? '';
//
//     print("Populated form data:");
//     print("Current Rank: $currentRank (valid: ${isValidRank(currentRank)})");
//     print("Alternate Rank: $alternateRank (valid: ${isValidRank(alternateRank)})");
//     print("Preferred Contract Type: $preferredContractType (valid: ${isValidContractType(preferredContractType)})");
//     print("Current Availability Status: $currentAvailabilityStatus (valid: ${isValidAvailabilityStatus(currentAvailabilityStatus)})");
//     print("Available Ranks from API: $ranks");
//
//     notifyListeners();
//   }
// }


import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../../../../custom-component/globalComponent.dart';
import '../../../../models/getAll_agencies_model.dart';
import '../../../../models/rank_model.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../Utils/helper.dart';

// Enums for dropdown values
enum RankType {
  captain('Captain'),
  chiefOfficer('Chief Officer'),
  secondOfficer('Second Officer'),
  thirdOfficer('Third Officer'),
  engineer('Engineer'),
  other('Other');

  const RankType(this.value);
  final String value;
}

enum ContractType {
  voyage('Voyage'),
  permanent('Permanent');

  const ContractType(this.value);
  final String value;
}

enum AvailabilityStatus {
  available('Available'),
  onboard('Onboard'),
  onLeave('On Leave'),
  other('Other');

  const AvailabilityStatus(this.value);
  final String value;
}

enum PreferredVesselType {
  bulkCarrier('Bulk Carrier'),
  tanker('Tanker'),
  container('Container'),
  generalCargo('General Cargo'),
  lng('LNG'),
  lpg('LPG'),
  other('Other');

  const PreferredVesselType(this.value);
  final String value;
}

enum RotationPattern {
  fourWeeksOnTwoWeeksOff('4 weeks on, 2 weeks off'),
  sixWeeksOnTwoWeeksOff('6 weeks on, 2 weeks off'),
  twoWeeksOnTwoWeeksOff('2 weeks on, 2 weeks off'),
  oneMonthOnOneMonthOff('1 month on, 1 month off');

  const RotationPattern(this.value);
  final String value;
}

enum TradingArea {
  arcticRegion('Arctic Region'),
  middleEast('Middle East'),
  africa('Africa'),
  asia('Asia'),
  europe('Europe');

  const TradingArea(this.value);
  final String value;
}

enum Currency {
  usd('USD'),
  eur('EUR'),
  gbp('GBP');

  const Currency(this.value);
  final String value;
}

class JobConditionsAndPreferencesProvider with ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  RankType? currentRank;
  RankType? alternateRank;
  List<String> preferredVesselTypes = [];
  ContractType? preferredContractType;
  RankType? preferredPosition;
  String? manningAgency;
  AvailabilityStatus? currentAvailabilityStatus;
  DateTime? availableFrom;
  TextEditingController minOnBoardDurationController = TextEditingController();
  TextEditingController maxOnBoardDurationController = TextEditingController();
  TextEditingController minAtHomeDurationController = TextEditingController();
  TextEditingController maxAtHomeDurationController = TextEditingController();
  RotationPattern? preferredRotationPattern; // Updated to enum
  List<TradingArea> tradingAreaExclusions = []; // Updated to enum list
  TextEditingController lastJobSalaryController = TextEditingController();
  RankData? _lastRankJoined;
  DateTime? lastPromotedDate;
  Currency? currency; // Updated to enum
  File? justificationDocument;

  // Constructor to ensure proper initialization
  JobConditionsAndPreferencesProvider() {
    _lastRankJoined = null;
  }
  
  RankData? get lastRankJoined => _lastRankJoined;

  // Dynamic lists from API
  List<RankData> _ranks = [];

  // Getter for ranks list
  List<RankData> get ranks => _ranks;

  // Setter for ranks list
  set ranks(List<RankData>? newRanks) {
    _ranks = newRanks ?? [];
    notifyListeners();
  }

  List<AgenciesData> _agencyData = [];

  // Getter for agency list
  List<AgenciesData> get agencyData => _agencyData;

  // Setter for agency list
  set agencyData(List<AgenciesData>? newRanks) {
    _agencyData = newRanks ?? [];
    notifyListeners();
  }

  // Enum-based lists
  List<String> get rankTypes => RankType.values.map((e) => e.value).toList();
  List<String> get contractTypes => ContractType.values.map((e) => e.value).toList();
  List<String> get availabilityStatuses => AvailabilityStatus.values.map((e) => e.value).toList();
  List<String> get vesselTypes => PreferredVesselType.values.map((e) => e.value).toList();
  List<String> get rotationPatterns => RotationPattern.values.map((e) => e.value).toList();
  List<String> get tradingAreas => TradingArea.values.map((e) => e.value).toList();
  List<String> get currencies => Currency.values.map((e) => e.value).toList();

  // Helper methods to validate enum values
  bool isValidRank(String? value) {
    if (value == null || value.isEmpty) return true;
    return rankTypes.contains(value);
  }

  bool isValidContractType(String? value) {
    if (value == null || value.isEmpty) return true;
    return contractTypes.contains(value);
  }

  bool isValidAvailabilityStatus(String? value) {
    if (value == null || value.isEmpty) return true;
    return availabilityStatuses.contains(value);
  }

  // Setters
  void setCurrentRank(RankType? value) {
    currentRank = value;
    notifyListeners();
  }

  void setAlternateRank(RankType? value) {
    alternateRank = value;
    notifyListeners();
  }

  void setPreferredVesselTypes(List<String> values) {
    preferredVesselTypes = values;
    notifyListeners();
  }

  void setPreferredContractType(ContractType? value) {
    preferredContractType = value;
    notifyListeners();
  }

  void setPreferredPosition(RankType? value) {
    preferredPosition = value;
    notifyListeners();
  }

  void setManningAgency(String? value) {
    manningAgency = value;
    notifyListeners();
  }

  void setCurrentAvailabilityStatus(AvailabilityStatus? value) {
    currentAvailabilityStatus = value;
    notifyListeners();
  }

  void setAvailableFrom(DateTime? date) {
    availableFrom = date;
    notifyListeners();
  }

  void setPreferredRotationPattern(RotationPattern? value) {
    preferredRotationPattern = value;
    notifyListeners();
  }

  void setTradingAreaExclusions(List<TradingArea> values) {
    tradingAreaExclusions = values;
    notifyListeners();
  }

  void setLastRankJoined(RankData? value) {
    _lastRankJoined = value;
    notifyListeners();
  }

  void setLastPromotedDate(DateTime? date) {
    lastPromotedDate = date;
    notifyListeners();
  }

  void setCurrency(Currency? value) {
    currency = value;
    notifyListeners();
  }

  void setJustificationDocument(File? file) {
    justificationDocument = file;
    notifyListeners();
  }

  void removeJustificationDocument() {
    justificationDocument = null;
    notifyListeners();
  }

  // File Picker
  final ImagePicker _picker = ImagePicker();

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
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () {
                  _pickDocument();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      setJustificationDocument(file);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setJustificationDocument(file);
    }
  }

  // Helper method to determine MIME type based on file extension
  String _getMimeType(String filePath) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  Future<void> GetAllRank(BuildContext context) async {
    try {
      var response = await NetworkService().getResponse(
        getAllRank,
        false,
        context,
            () {},
      );
      print("RESPONSE ++>>> $response");
      if (response.isNotEmpty) {
        final profileData = GetAllRankModel.fromJson(response);
        if (profileData.statusCode == 200) {
          ranks = profileData.data ?? [];
        } else {
          ranks = [];
          print("Error: Status code ${profileData.statusCode}, Message: ${profileData.message}");
        }
      } else {
        ranks = [];
        print("Error: Empty response from server");
      }
      notifyListeners();
    } catch (e) {
      ranks = [];
      print("Error in getAllRank: $e");
      notifyListeners();
    }
  }

  Future<void> fetchAgencyData(BuildContext context) async {
    try {
      var response = await NetworkService().getResponse(
        getAllAgency,
        false,
        context,
            () {},
      );
      print("RESPONSE ++>>> $response");
      if (response.isNotEmpty) {
        final profileData = GetAllAgenciesModel.fromJson(response);
        if (profileData.statusCode == 200) {
          agencyData = profileData.data ?? [];
        } else {
          agencyData = [];
          print("Error: Status code ${profileData.statusCode}, Message: ${profileData.message}");
        }
      } else {
        agencyData = [];
        print("Error: Empty response from server");
      }
      notifyListeners();
    } catch (e) {
      agencyData = [];
      print("Error in getAllAgency: $e");
      notifyListeners();
    }
  }

  // Method to reset all form fields to their initial state
  void _resetAllFields() {
    currentRank = null;
    alternateRank = null;
    preferredVesselTypes.clear();
    preferredContractType = null;
    preferredPosition = null;
    manningAgency = null;
    currentAvailabilityStatus = null;
    availableFrom = null;
    minOnBoardDurationController.clear();
    maxOnBoardDurationController.clear();
    minAtHomeDurationController.clear();
    maxAtHomeDurationController.clear();
    preferredRotationPattern = null;
    tradingAreaExclusions.clear();
    lastJobSalaryController.clear();
    _lastRankJoined = null;
    lastPromotedDate = null;
    currency = null;
    justificationDocument = null;
    
    print("All form fields have been reset to initial state");
  }

  Future<void> fetchJobConditionsData(BuildContext context) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    
    // Reset all fields before fetching new data
    _resetAllFields();
    notifyListeners();

    try {
      await GetAllRank(context);
      await fetchAgencyData(context);

      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        hasError = true;
        errorMessage = 'User ID not found';
        isLoading = false;
        notifyListeners();
        return;
      }

      final response = await NetworkService().getResponse(
        getJobConditionsByUserId + userId,
        false,
        context,
            () => notifyListeners(),
      );

      if (response['statusCode'] == 200 && response['data'] != null && response['data'].isNotEmpty) {
        _populateFormData(response['data'][0]);
      } else {
        hasError = true;
        errorMessage = response['message'] ?? 'Failed to fetch job conditions';
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _populateFormData(Map<String, dynamic> data) {
    String? currentRankValue = data['currentRank'] as String?;
    currentRank = currentRankValue != null && isValidRank(currentRankValue)
        ? RankType.values.firstWhere((e) => e.value == currentRankValue)
        : null;

    String? alternateRankValue = data['alternateRank'] as String?;
    alternateRank = alternateRankValue != null && isValidRank(alternateRankValue)
        ? RankType.values.firstWhere((e) => e.value == alternateRankValue)
        : null;

    String? preferredPositionValue = data['preferredPosition'] as String?;
    preferredPosition = preferredPositionValue != null && isValidRank(preferredPositionValue)
        ? RankType.values.firstWhere((e) => e.value == preferredPositionValue)
        : null;

    String? lastRankJoinedValue = data['lastRankJoined'] as String?;
    if (lastRankJoinedValue != null && lastRankJoinedValue.isNotEmpty && ranks.isNotEmpty) {
      print("Trying to match lastRankJoined: '$lastRankJoinedValue'");
      print("Available ranks: ${ranks.map((r) => r.rankName).toList()}");
      
      // Create a mapping for common variations
      Map<String, List<String>> rankMappings = {
        'engineer': ['CHIEF ENGINEER', 'SECOND ENGINEER', 'THIRD ENGINEER', 'FOURTH ENGINEER'],
        'officer': ['CHIEF OFFICER', 'SECOND OFFICER', 'THIRD OFFICER'],
        'master': ['MASTER', 'CAPTAIN'],
        'captain': ['MASTER', 'CAPTAIN'],
      };
      
      try {
        // First try exact match (case insensitive)
        _lastRankJoined = ranks.firstWhere(
          (rank) => rank.rankName?.toLowerCase() == lastRankJoinedValue.toLowerCase(),
        );
        print("Found exact match for last rank joined: ${_lastRankJoined?.rankName}");
      } catch (e) {
        // Try mapping-based matching
        String searchKey = lastRankJoinedValue.toLowerCase();
        List<String>? possibleMatches = rankMappings[searchKey];
        
        if (possibleMatches != null) {
          try {
            _lastRankJoined = ranks.firstWhere(
              (rank) => possibleMatches.contains(rank.rankName?.toUpperCase()),
            );
            print("Found mapping match for last rank joined: ${_lastRankJoined?.rankName} (searched for: $lastRankJoinedValue)");
          } catch (e2) {
            _lastRankJoined = null;
            print("No mapping match found for '$lastRankJoinedValue'");
          }
        } else {
          // If no mapping, try partial matching as fallback
          try {
            _lastRankJoined = ranks.firstWhere(
              (rank) => rank.rankName?.toLowerCase().contains(lastRankJoinedValue.toLowerCase()) == true,
            );
            print("Found partial match for last rank joined: ${_lastRankJoined?.rankName} (searched for: $lastRankJoinedValue)");
          } catch (e3) {
            _lastRankJoined = null;
            print("Last rank joined '$lastRankJoinedValue' not found in ranks list. Available ranks: ${ranks.map((r) => r.rankName).toList()}");
          }
        }
      }
    } else {
      _lastRankJoined = null;
    }

    String? preferredContractTypeValue = data['preferredContractType'] as String?;
    preferredContractType = preferredContractTypeValue != null && isValidContractType(preferredContractTypeValue)
        ? ContractType.values.firstWhere((e) => e.value == preferredContractTypeValue)
        : null;

    String? currentAvailabilityStatusValue = data['currentAvailabilityStatus'] as String?;
    currentAvailabilityStatus = currentAvailabilityStatusValue != null && isValidAvailabilityStatus(currentAvailabilityStatusValue)
        ? AvailabilityStatus.values.firstWhere((e) => e.value == currentAvailabilityStatusValue)
        : null;

    preferredVesselTypes = (data['preferredVesselType'] as List?)?.map((e) => e.toString()).toList() ?? [];
    manningAgency = data['manningAgency'] as String?;
    availableFrom = data['availableFrom'] != null ? DateTime.tryParse(data['availableFrom'] as String) : null;
    minOnBoardDurationController.text = (data['minOnBoardDuration'] as num?)?.toString() ?? '';
    maxOnBoardDurationController.text = (data['maxOnBoardDuration'] as num?)?.toString() ?? '';
    minAtHomeDurationController.text = (data['minAtHomeDuration'] as num?)?.toString() ?? '';
    maxAtHomeDurationController.text = (data['maxAtHomeDuration'] as num?)?.toString() ?? '';

    String? rotationPatternValue = data['preferredRotationPattern'] as String?;
    preferredRotationPattern = rotationPatternValue != null && rotationPatterns.contains(rotationPatternValue)
        ? RotationPattern.values.firstWhere((e) => e.value == rotationPatternValue)
        : null;

    if (data['tradingAreaExclusions'] is List) {
      tradingAreaExclusions = (data['tradingAreaExclusions'] as List)
          .map((e) => e.toString())
          .where((e) => tradingAreas.contains(e))
          .map((e) => TradingArea.values.firstWhere((ta) => ta.value == e))
          .toList();
    } else if (data['tradingAreaExclusions'] is String) {
      tradingAreaExclusions = [TradingArea.values.firstWhere((ta) => ta.value == data['tradingAreaExclusions'] as String)];
    } else {
      tradingAreaExclusions = [];
    }

    lastJobSalaryController.text = (data['lastJobSalary'] as num?)?.toString() ?? '';
    lastPromotedDate = data['lastPromotedDate'] != null ? DateTime.tryParse(data['lastPromotedDate'] as String) : null;

    String? currencyValue = data['currency'] as String?;
    currency = currencyValue != null && currencies.contains(currencyValue)
        ? Currency.values.firstWhere((e) => e.value == currencyValue)
        : null;

    notifyListeners();
  }

  Future<bool> createOrUpdateJobConditionsAPI(BuildContext context) async {
    try {
      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        print('User ID not found');
        ShowToast("Error", "User session not found. Please login again.");
        return false;
      }

      // Prepare the data object - send as individual form fields, not JSON
      Map<String, dynamic> dioFieldData = {
        'userId': userId,
        'currentRank': currentRank?.value ?? '',
        'alternateRank': alternateRank?.value ?? '',
        'preferredContractType': preferredContractType?.value ?? '',
        'preferredPosition': preferredPosition?.value ?? '',
        'manningAgency': manningAgency ?? '',
        'currentAvailabilityStatus': currentAvailabilityStatus?.value ?? '',
        'availableFrom': availableFrom != null ? DateFormat('yyyy-MM-dd').format(availableFrom!) : '',
        'minOnBoardDuration': minOnBoardDurationController.text.isNotEmpty ? int.tryParse(minOnBoardDurationController.text) : null,
        'maxOnBoardDuration': maxOnBoardDurationController.text.isNotEmpty ? int.tryParse(maxOnBoardDurationController.text) : null,
        'minAtHomeDuration': minAtHomeDurationController.text.isNotEmpty ? int.tryParse(minAtHomeDurationController.text) : null,
        'maxAtHomeDuration': maxAtHomeDurationController.text.isNotEmpty ? int.tryParse(maxAtHomeDurationController.text) : null,
        'preferredRotationPattern': preferredRotationPattern?.value ?? '',
        'tradingAreaExclusions': tradingAreaExclusions.map((e) => e.value).join(','),
        'lastJobSalary': lastJobSalaryController.text.isNotEmpty ? double.tryParse(lastJobSalaryController.text) : null,
        'lastRankJoined': _lastRankJoined?.rankName ?? '',
        'lastPromotedDate': lastPromotedDate != null ? DateFormat('yyyy-MM-dd').format(lastPromotedDate!) : '',
        'currency': currency?.value ?? '',
      };

      // Add preferredVesselType array elements individually
      for (int i = 0; i < preferredVesselTypes.length; i++) {
        dioFieldData['preferredVesselType[$i]'] = preferredVesselTypes[i];
      }

      print("Job Conditions Payload: $dioFieldData");

      // Prepare file list for justification document
      List<Map<String, dynamic>> dioFileList = [];
      if (justificationDocument != null) {
        dioFileList.add({
          'fieldName': 'justificationDocument',
          'filePath': justificationDocument!.path,
          'fileName': justificationDocument!.path.split('/').last,
          'mimeType': _getMimeType(justificationDocument!.path),
        });
      }

      print("File List: $dioFileList");

      // Make the API call
      final response = await multipartDocumentsDio(
        context,
        postJobConditionsByUserId,
        dioFieldData,
        dioFileList,
        true,
      );

      print("Job Conditions Save Response: $response");

      if (response != null && response['statusCode'] == 200) {
        print("Job conditions saved successfully");
        return true;
      } else {
        String errorMessage = response?['message'] ?? 'Failed to save job conditions';
        print("Job Conditions Save Error: $errorMessage");
        ShowToast("Error", errorMessage);
        return false;
      }
    } catch (e) {
      print("Job Conditions Save Exception: $e");
      ShowToast("Error", "Something went wrong while saving job conditions");
      return false;
    }
  }
}