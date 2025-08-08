import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../../models/professional_experience_model.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../custom-component/globalComponent.dart';
import '../../../../Utils/helper.dart';

class ProfessionalExperienceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // Loading states
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  ProfessionalExperience? professionalExperienceData;

  List<File?> employmentHistoryDocuments = [];
  List<File?> referenceDocuments = [];

  // Controllers for text fields
  final TextEditingController companyController = TextEditingController();
  final TextEditingController responsibilitiesController = TextEditingController();
  final TextEditingController referenceVesselController = TextEditingController();
  String? referenceIssuedBy;
  final TextEditingController referenceDocumentController = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController referenceIssuedDate = TextEditingController();

  final FocusNode companyFocusNode = FocusNode();
  final FocusNode responsibilitiesFocusNode = FocusNode();
  final FocusNode startDateFocusNode = FocusNode();
  final FocusNode endDateFocusNode = FocusNode();
  final FocusNode referenceVesselFocusNode = FocusNode();
  final FocusNode referenceIssuedByFocusNode = FocusNode();
  final FocusNode referenceIssuedDateFocusNode = FocusNode();
  final FocusNode referenceDocumentFocusNode = FocusNode();

  // Employment History List (Repeater) - Using API models
  List<ProfessionalEmploymentHistory> _employmentHistory = [];

  List<ProfessionalEmploymentHistory> get employmentHistory => _employmentHistory;

  // References List (Repeater) - Using API models
  List<Reference> _references = [];

  List<Reference> get references => _references;

  // Positions Held (Multiselect)
  List<String> _positionsHeld = [];

  List<String> get positionsHeld => _positionsHeld;

  String? _empHis_positionsHeld;

  String? get empHisPositionsHeld => _empHis_positionsHeld;

  // Vessel Type Experience (Multiselect)
  List<String> _vesselTypeExperience = [];

  List<String> get vesselTypeExperience => _vesselTypeExperience;

  bool _showAddSection_employmentHistory = false;

  bool get showAddSection_employmentHistory =>
      _showAddSection_employmentHistory;
  bool employment_IsEdit = false;
  int? employment_Edit_Index;

  bool _showAddSection_reference = false;

  bool get showAddSection_reference => _showAddSection_reference;
  bool reference_IsEdit = false;
  int? reference_Edit_Index;

  // Set Positions Held (Multiselect)
  void setPositionsHeld(List<String> positions) {
    _positionsHeld = positions;
    notifyListeners();
  }

  void setEmpHisPositionsHeld(String? positions) {
    _empHis_positionsHeld = positions;
    print("_empHis_positionsHeld => ${_empHis_positionsHeld}");
    notifyListeners();
  }

  void setEmploymentHistoryVisibility(bool value) {
    _showAddSection_employmentHistory = value;
    notifyListeners();
  }

  void setReferenceVisibility(bool value) {
    _showAddSection_reference = value;
    notifyListeners();
  }

  void setReferenceIssuedBy(String? value) {
    referenceIssuedBy = value;
    notifyListeners();
  }

  // Date validation method
  String? validateDateRange(String? startDate, String? endDate) {
    if (startDate == null || startDate.isEmpty || endDate == null || endDate.isEmpty) {
      return null; // Let other validators handle empty fields
    }

    try {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      
      if (end.isBefore(start)) {
        return 'End date must be after start date';
      }
      
      return null; // Valid date range
    } catch (e) {
      return 'Invalid date format';
    }
  }

  // Check if current employment history dates are valid
  bool isCurrentEmploymentHistoryValid() {
    return validateDateRange(startDate.text, endDate.text) == null;
  }

  // Trigger UI update for date validation
  void updateDateValidation() {
    notifyListeners();
  }

  // Clear date fields
  void clearDateFields() {
    startDate.clear();
    endDate.clear();
    updateDateValidation();
  }

  // Reset all form data
  void resetForm() {
    // Clear text controllers
    companyController.clear();
    responsibilitiesController.clear();
    referenceVesselController.clear();
    referenceDocumentController.clear();
    startDate.clear();
    endDate.clear();
    referenceIssuedDate.clear();
    
    // Clear dropdown selections
    referenceIssuedBy = null;
    
    // Clear lists
    _employmentHistory.clear();
    _references.clear();
    _positionsHeld.clear();
    setEmpHisPositionsHeld(null);
    _vesselTypeExperience.clear();
    
    // Reset visibility states
    _showAddSection_employmentHistory = false;
    _showAddSection_reference = false;
    
    // Reset edit states
    employment_IsEdit = false;
    employment_Edit_Index = null;
    reference_IsEdit = false;
    reference_Edit_Index = null;
    
    // Clear file
    employmentHistoryDocuments.clear();
    referenceDocuments.clear();
    
    // Reset error states
    hasError = false;
    errorMessage = '';
    
    // Reset validation mode
    autovalidateMode = AutovalidateMode.disabled;
    
    notifyListeners();
  }


  void setReferenceIssuingDate(DateTime date) {
    referenceIssuedDate.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  final picker = ImagePicker();

  String? positionsHeldError;
  String? vesselTypeExperienceError;

  Future<void> showAttachmentOptions(BuildContext context, String type, int index) async {
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
                  _pickImage(ImageSource.gallery, type, index);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera, type, index);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () {
                  _pickDocument(type, index);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, String type, int index) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (type == 'employment') {
        if (index < _employmentHistory.length) {
          _employmentHistory[index].documentPath = '';
          _employmentHistory[index].documentOriginalName = '';
        }
        while (employmentHistoryDocuments.length <= index) {
          employmentHistoryDocuments.add(null);
        }
        employmentHistoryDocuments[index] = File(pickedFile.path);
      } else if (type == 'reference') {
        if (index < _references.length) {
          _references[index].experienceDocumentPath = '';
          _references[index].experienceDocumentOriginalName = '';
        }
        while (referenceDocuments.length <= index) {
          referenceDocuments.add(null);
        }
        referenceDocuments[index] = File(pickedFile.path);
      }
      notifyListeners();
    }
  }

  Future<void> _pickDocument(String type, int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      if (type == 'employment') {
        if (index < _employmentHistory.length) {
          _employmentHistory[index].documentPath = '';
          _employmentHistory[index].documentOriginalName = '';
        }
        while (employmentHistoryDocuments.length <= index) {
          employmentHistoryDocuments.add(null);
        }
        employmentHistoryDocuments[index] = File(result.files.single.path!);
      } else if (type == 'reference') {
        if (index < _references.length) {
          _references[index].experienceDocumentPath = '';
          _references[index].experienceDocumentOriginalName = '';
        }
        while (referenceDocuments.length <= index) {
          referenceDocuments.add(null);
        }
        referenceDocuments[index] = File(result.files.single.path!);
      }
      notifyListeners();
    }
  }

  void removeExistingAttachment(String type, int index) {
    if (type == 'employment') {
      if (index < _employmentHistory.length) {
        _employmentHistory[index].documentPath = '';
        _employmentHistory[index].documentOriginalName = '';
      }
    } else if (type == 'reference') {
      if (index < _references.length) {
        _references[index].experienceDocumentPath = '';
        _references[index].experienceDocumentOriginalName = '';
      }
    }
    notifyListeners();
  }

  void removeAttachment(String type, int index) {
    if (type == 'employment') {
      if (index < employmentHistoryDocuments.length) {
        employmentHistoryDocuments[index] = null;
      }
    } else if (type == 'reference') {
      if (index < referenceDocuments.length) {
        referenceDocuments[index] = null;
      }
    }
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate.text = "${date.toLocal()}".split(' ')[0];
    updateDateValidation();
  }

  void setEndDate(DateTime date) {
    endDate.text = "${date.toLocal()}".split(' ')[0];
    updateDateValidation();
  }

  // Set Vessel Type Experience (Multiselect)
   setVesselTypeExperience(List<String> vessels) {
    _vesselTypeExperience = vessels;
    notifyListeners();
  }

    // Add Employment History
         addEmploymentHistory(ProfessionalEmploymentHistory historyRecord) {
    _employmentHistory.add(historyRecord);
    notifyListeners();
  }

  // Update Employment History
         updateEmploymentHistory(int index, ProfessionalEmploymentHistory updatedHistory) {
    _employmentHistory[index] = updatedHistory;
    notifyListeners();
  }

  // Remove Employment History
   removeEmploymentHistory(int index) {
    _employmentHistory.removeAt(index);
    notifyListeners();
  }

    // Add Reference
         addReference(Reference reference) {
    _references.add(reference);
    notifyListeners();
  }

  // Update Reference
         updateReference(int index, Reference updatedReference) {
    _references[index] = updatedReference;
    notifyListeners();
  }

  // Remove Reference
  void removeReference(int index) {
    _references.removeAt(index);
    notifyListeners();
  }

  // API call to fetch professional experience data
  Future<void> fetchProfessionalExperience(String userId,
      BuildContext context) async {
    if (userId.isEmpty) {
      userId = NetworkHelper.loggedInUserId;
      print("LOGIN USER ID ${NetworkHelper.loggedInUserId}");
    }

    if (userId.isEmpty) {
      hasError = true;
      errorMessage = 'User ID not found. Please login again.';
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      final response = await NetworkService().getResponse(
        '$getProfessionalExperienceByUserId$userId',
        false, // showLoading - let the provider handle loading
        context,
            () {},
      );

      print('Professional Experience Response: $response');

      if (response.isNotEmpty) {
        final professionalExperienceResponse = ProfessionalExperienceResponse
            .fromJson(response);

        if (professionalExperienceResponse.data.isNotEmpty) {
          professionalExperienceData =
              professionalExperienceResponse.data.first;
          _populateFormData();
        }

        ShowToast("Success", "Professional experience fetched successfully");
      } else {
        hasError = true;
        ShowToast("Error", "Failed to load professional experience");
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
      ShowToast("Error", "Network error: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    hasError = false;
  }

  // Populate form data from API response
  void _populateFormData() {
    if (professionalExperienceData == null) return;
    
    print('Populating form data...');
    print('Employment history type: ${professionalExperienceData!.employmentHistory.runtimeType}');
    print('Employment history data: ${professionalExperienceData!.employmentHistory}');

    // Populate Positions Held
    if (professionalExperienceData!.positionsHeld != null &&
        professionalExperienceData!.positionsHeld!.isNotEmpty) {
      // Map API values to dropdown keys
      List<String> mappedPositions = [];
      for (String position in professionalExperienceData!.positionsHeld!) {
        switch (position) {
          case 'Captain':
            mappedPositions.add('CAPTAIN');
            break;
          case 'Chief Engineer':
            mappedPositions.add('CHIEF_ENGINEER');
            break;
          case 'Second Officer':
            mappedPositions.add('SECOND_OFFICER');
            break;
          default:
            mappedPositions.add('OTHER');
            break;
        }
      }
      setPositionsHeld(mappedPositions);
    }

    // Populate Vessel Type Experience
    if (professionalExperienceData!.vesselTypeExperience != null &&
        professionalExperienceData!.vesselTypeExperience!.isNotEmpty) {
      // Map API values to dropdown keys
      List<String> mappedVessels = [];
      for (String vessel in professionalExperienceData!.vesselTypeExperience!) {
        switch (vessel) {
          case 'Bulk Carrier':
            mappedVessels.add('BULK_CARRIER');
            break;
          case 'Container Ship':
            mappedVessels.add('CONTAINER_SHIP');
            break;
          case 'Tanker':
            mappedVessels.add('TANKER');
            break;
          case 'Passenger Ship':
            mappedVessels.add('PASSENGER_SHIP');
            break;
          default:
            mappedVessels.add('OTHER');
            break;
        }
      }
      setVesselTypeExperience(mappedVessels);
    }

    // Populate Employment History
    _employmentHistory.clear(); // Clear the list first
    if (professionalExperienceData!.employmentHistory != null &&
        professionalExperienceData!.employmentHistory!.isNotEmpty) {
      try {
        for (var history in professionalExperienceData!.employmentHistory!) {
          print('Processing history item: ${history.runtimeType}');
          
          // Map position to dropdown key
          String mappedPosition = 'OTHER';
          if (history.position != null) {
            switch (history.position!) {
              case 'Captain':
                mappedPosition = 'CAPTAIN';
                break;
              case 'Chief Engineer':
                mappedPosition = 'CHIEF_ENGINEER';
                break;
              case 'Second Officer':
                mappedPosition = 'SECOND_OFFICER';
                break;
              default:
                mappedPosition = 'OTHER';
                break;
            }
          }

          // Create a new ProfessionalEmploymentHistory object with the mapped data
          ProfessionalEmploymentHistory localHistory = ProfessionalEmploymentHistory(
            companyName: history.companyName ?? '',
            position: history.position ?? '',
            startDate: history.startDate ?? '',
            endDate: history.endDate ?? '',
            responsibilities: history.responsibilities ?? '',
          );
          _employmentHistory.add(localHistory);
        }
      } catch (e) {
        print('Error processing employment history: $e');
        // If there's a type mismatch, we'll just skip this section
      }
    }

    // Populate References
    _references.clear(); // Clear the list first
    if (professionalExperienceData!.references != null &&
        professionalExperienceData!.references!.isNotEmpty) {
      try {
        for (var reference in professionalExperienceData!.references!) {
          print('Processing reference item: ${reference.runtimeType}');
          
          // Create a new Reference object with the mapped data
          Reference localReference = Reference(
            issuedBy: reference.issuedBy ?? '',
            issuingDate: reference.issuingDate ?? '',
            vesselOrCompanyName: reference.vesselOrCompanyName ?? '',
            experienceDocumentOriginalName: reference.experienceDocumentOriginalName ?? '',
          );
          _references.add(localReference);
        }
      } catch (e) {
        print('Error processing references: $e');
        // If there's a type mismatch, we'll just skip this section
      }
    }
  }

  // Create or Update Professional Experience API
  Future<bool> createOrUpdateProfessionalExperienceAPI(
      BuildContext context) async {
    hasError = false;
    errorMessage = '';
    notifyListeners();

    // Sync user data from SharedPreferences
    await NetworkHelper.syncUserData();
    
    print('NetworkHelper.loggedInUserId: "${NetworkHelper.loggedInUserId}"');
    print('NetworkHelper.loggedInUserId type: ${NetworkHelper.loggedInUserId.runtimeType}');
    print('NetworkHelper.loggedInUserId isEmpty: ${NetworkHelper.loggedInUserId.isEmpty}');
    
    // Check if userId is valid
    if (NetworkHelper.loggedInUserId.isEmpty) {
      hasError = true;
      errorMessage = 'User ID is empty. Please login again.';
      ShowToast("Error", "User ID is empty. Please login again.");
      return false;
    }
    
    // Check if we have at least some data to send
    // if (positionsHeld.isEmpty && vesselTypeExperience.isEmpty &&
    //     employmentHistory.isEmpty && references.isEmpty) {
    //   hasError = true;
    //   errorMessage = 'Please add at least one position, vessel type, employment history, or reference.';
    //   ShowToast("Error", "Please add at least one position, vessel type, employment history, or reference.");
    //   return false;
    // }

    // Validate date ranges for all employment history entries
    for (int i = 0; i < employmentHistory.length; i++) {
      var history = employmentHistory[i];
      String? dateError = validateDateRange(history.startDate, history.endDate);
      if (dateError != null) {
        hasError = true;
        errorMessage = 'Employment History ${i + 1}: $dateError';
        ShowToast("Error", errorMessage);
        return false;
      }
    }
    
    try {
      // Prepare the data object
      Map<String, dynamic> professionalExperience = {
        'userId': NetworkHelper.loggedInUserId,
        'positionsHeld': positionsHeld.map((position) {
          // Convert dropdown keys back to API values
          switch (position) {
            case 'CAPTAIN':
              return 'Captain';
            case 'CHIEF_ENGINEER':
              return 'Chief Engineer';
            case 'SECOND_OFFICER':
              return 'Second Officer';
            default:
              return 'Other';
          }
        }).toList(),
        'vesselTypeExperience': vesselTypeExperience.map((vessel) {
          // Convert dropdown keys back to API values
          switch (vessel) {
            case 'BULK_CARRIER':
              return 'Bulk Carrier';
            case 'CONTAINER_SHIP':
              return 'Container Ship';
            case 'TANKER':
              return 'Tanker';
            case 'PASSENGER_SHIP':
              return 'Passenger Ship';
            default:
              return 'Other';
          }
        }).toList(),
        'employmentHistory': employmentHistory.map((history) => {
          'companyName': history.companyName ?? '',
          'position': history.position ?? '',
          'startDate': history.startDate ?? '',
          'endDate': history.endDate ?? '',
          'responsibilities': history.responsibilities ?? '',
        }).toList(),
        'references': references.map((reference) => {
          'issuedBy': reference.issuedBy ?? '',
          'issuingDate': reference.issuingDate ?? '',
          'vesselOrCompanyName': reference.vesselOrCompanyName ?? '',
        }).toList(),
      };

      // Convert data to the format expected by Dio function
      Map<String, dynamic> dioFieldData = {
        'userId': NetworkHelper.loggedInUserId,
        'positionsHeld': jsonEncode(professionalExperience['positionsHeld'] ?? []),
        'vesselTypeExperience': jsonEncode(professionalExperience['vesselTypeExperience'] ?? []),
        'employmentHistory': jsonEncode(professionalExperience['employmentHistory'] ?? []),
        'references': jsonEncode(professionalExperience['references'] ?? []),
      };

      // Convert fileList to the format expected by Dio function
      List<Map<String, dynamic>> dioFileList = [];

      // Add employment history documents if available
      for (int i = 0; i < employmentHistoryDocuments.length; i++) {
        if (employmentHistoryDocuments[i] != null) {
          dioFileList.add({
            'fieldName': 'employmentHistoryDocuments[$i]',
            'filePath': employmentHistoryDocuments[i]!.path,
            'fileName': employmentHistoryDocuments[i]!.path.split('/').last,
          });
        }
      }

      // Add references documents if available
      for (int i = 0; i < referenceDocuments.length; i++) {
        if (referenceDocuments[i] != null) {
          dioFileList.add({
            'fieldName': 'referenceDocuments[$i]',
            'filePath': referenceDocuments[i]!.path,
            'fileName': referenceDocuments[i]!.path.split('/').last,
          });
        }
      }


      // Call the Dio-based multipart function from globalComponent
      final response = await multipartDocumentsDio(
        context,
        createOrUpdateProfessionalExperience,
        dioFieldData,
        dioFileList,
        false, // showLoading
      );

      print("POST DATA PayLoad ====> ${dioFieldData}");
      print("POST DATA PayLoad 2====> ${dioFileList}");
      print("Original professionalExperience ====> ${professionalExperience}");
      print("POST DATA ====> ${response}");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Success - refresh the data
        ShowToast("Success", "Professional experience saved successfully");
        return true;
      } else {
        hasError = true;
        ShowToast("Error", 'Failed to save professional experience');
        return false;
      }
    } catch (e) {
      hasError = true;
      print(e);
      errorMessage = 'Network error: ${e.toString()}';
      ShowToast("Error", "Network error");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

    @override
    void dispose() {
      companyController.dispose();
      // positionController.dispose();
      responsibilitiesController.dispose();
      // referenceCompanyController.dispose();
      // referencePositionController.dispose();
      super.dispose();
    }
  }

