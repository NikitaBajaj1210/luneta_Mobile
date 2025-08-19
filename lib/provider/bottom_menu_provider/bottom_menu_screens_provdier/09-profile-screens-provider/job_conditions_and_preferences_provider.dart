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
  gbp('GBP'),
  inr('INR'),
  aud('AUD'),
  cad('CAD'),
  chf('CHF'),
  nzd('NZD'),
  sgd('SGD'),
  zar('ZAR');

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
  String? tradingAreaExclusions ; // Updated to enum list
  TextEditingController lastJobSalaryController = TextEditingController();
  RankData? _lastRankJoined;
  DateTime? lastPromotedDate;
  Currency? currency; // Updated to enum
  File? justificationDocument;
  String? justificationDocumentPath;

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

  void setTradingAreaExclusions(String? values) {
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

  Future<void> setJustificationDocument(File? file, BuildContext? context) async {
    // Add file size validation (20MB limit)
    if (file != null) {
      final maxSize = 20 * 1024 * 1024; // 20MB in bytes
      final size = await file.length();
      if (size > maxSize) {
        // Show error message
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File size exceeds 20MB limit'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          print('File size exceeds 20MB limit');
        }
        return;
      }
    }
    justificationDocument = file;
    notifyListeners();
  }

  Future<void> removeJustificationDocument(BuildContext? context) async {
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
                onTap: () async {
                  await _pickImage(ImageSource.gallery,context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () async {
                  await _pickImage(ImageSource.camera,context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () async {
                  await _pickDocument(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      await setJustificationDocument(file, context);
    }
  }

  Future<void> _pickImage(ImageSource source,BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      await setJustificationDocument(file, context);
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
  Future<void> _resetAllFields() async {
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
    tradingAreaExclusions=null;
    lastJobSalaryController.clear();
    _lastRankJoined = null;
    lastPromotedDate = null;
    currency = null;
    await removeJustificationDocument(null);
    justificationDocumentPath = null;
    autovalidateMode=AutovalidateMode.disabled;
    
    print("All form fields have been reset to initial state");
  }

  Future<void> fetchJobConditionsData(BuildContext context) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    
    // Reset all fields before fetching new data
    await _resetAllFields();
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

    // Match lastRankJoined by id from API response
    String? lastRankJoinedId = data['lastRankJoined'] as String?;
    print("Attempting to match lastRankJoinedId: $lastRankJoinedId");
    if (lastRankJoinedId != null && lastRankJoinedId.isNotEmpty && ranks.isNotEmpty) {
      _lastRankJoined = ranks.firstWhere(
            (rank) => rank.id == lastRankJoinedId,
        orElse: () => ranks[0], // Default to first rank if no match (adjust as needed)
      );
      if (_lastRankJoined != null) {
        print("Matched lastRankJoined: ${_lastRankJoined!.rankName} (ID: ${_lastRankJoined!.id})");
      } else {
        print("No match found for ID: $lastRankJoinedId in ranks: ${ranks.map((r) => r.id).join(', ')}");
        _lastRankJoined = null; // Explicitly set to null if no match
      }
    } else {
      _lastRankJoined = null;
      print("No valid lastRankJoinedId or ranks list empty");
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
    minOnBoardDurationController.text = data['minOnBoardDuration'];
    maxOnBoardDurationController.text = data['maxOnBoardDuration'];
    minAtHomeDurationController.text = data['minAtHomeDuration'];
    maxAtHomeDurationController.text = data['maxAtHomeDuration'];

    String? rotationPatternValue = data['preferredRotationPattern'] as String?;
    preferredRotationPattern = rotationPatternValue != null && rotationPatterns.contains(rotationPatternValue)
        ? RotationPattern.values.firstWhere((e) => e.value == rotationPatternValue)
        : null;

    // if (data['tradingAreaExclusions'] is List) {
    //   tradingAreaExclusions = (data['tradingAreaExclusions'] as List)
    //       .map((e) => e.toString())
    //       .where((e) => tradingAreas.contains(e))
    //       .map((e) => TradingArea.values.firstWhere((ta) => ta.value == e))
    //       .toList();
    // } else if (data['tradingAreaExclusions'] is String) {
    //   tradingAreaExclusions = [TradingArea.values.firstWhere((ta) => ta.value == data['tradingAreaExclusions'] as String)];
    // } else {
    //   tradingAreaExclusions = [];
    // }
    tradingAreaExclusions=data['tradingAreaExclusions'];


    lastJobSalaryController.text = (data['lastJobSalary'] as num?)?.toString() ?? '';
    lastPromotedDate = data['lastPromotedDate'] != null ? DateTime.tryParse(data['lastPromotedDate'] as String) : null;

    String? currencyValue = data['currency'] as String?;
    currency = currencyValue != null && currencies.contains(currencyValue)
        ? Currency.values.firstWhere((e) => e.value == currencyValue)
        : null;
    
    // Handle justificationDocumentPath
    justificationDocumentPath = data['justificationDocumentPath'] as String?;

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
        'tradingAreaExclusions': tradingAreaExclusions,
        'lastJobSalary': lastJobSalaryController.text.isNotEmpty ? double.tryParse(lastJobSalaryController.text) : null,
        'lastRankJoined': _lastRankJoined?.id ?? '',
        'lastPromotedDate': lastPromotedDate != null ? DateFormat('yyyy-MM-dd').format(lastPromotedDate!) : '',
        'currency': currency?.value ?? '',
        'justificationDocumentPath':justificationDocument==null?justificationDocumentPath:'',
      };

      if(justificationDocumentPath==''||justificationDocumentPath==null) {
        dioFieldData['justificationDocumentOriginalName'] = '';
      }
      // Add preferredVesselType array elements individually
      for (int i = 0; i < preferredVesselTypes.length; i++) {
        dioFieldData['preferredVesselType[$i]'] = preferredVesselTypes[i];
      }


      // Prepare file list for justification document
      List<Map<String, dynamic>> dioFileList = [];
      if (justificationDocument != null) {
        dioFieldData['justificationDocumentOriginalName'] = justificationDocument!.path.split('/').last;
    dioFileList.add({
          'fieldName': 'justificationDocument',
          'filePath': justificationDocument!.path,
          'fileName': justificationDocument!.path.split('/').last,
          'mimeType': _getMimeType(justificationDocument!.path),
        });
      }
      print("Job Conditions Payload: $dioFieldData");
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