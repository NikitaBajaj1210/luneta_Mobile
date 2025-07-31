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

class ProfessionalExperienceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // Loading states
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  ProfessionalExperience? professionalExperienceData;

  File? referenceDocument;
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

  // Employment History List (Repeater)
  List<EmploymentHistory> _employmentHistory = [];
  List<EmploymentHistory> get employmentHistory => _employmentHistory;

  // References List (Repeater)
  List<Reference> _references = [];
  List<Reference> get references => _references;

  // Positions Held (Multiselect)
  List<String> _positionsHeld = [];
  List<String> get positionsHeld => _positionsHeld;

  List<String> _empHis_positionsHeld = [];
  List<String> get empHisPositionsHeld => _empHis_positionsHeld;

  // Vessel Type Experience (Multiselect)
  List<String> _vesselTypeExperience = [];
  List<String> get vesselTypeExperience => _vesselTypeExperience;

  bool _showAddSection_employmentHistory=false;
  bool get showAddSection_employmentHistory=>_showAddSection_employmentHistory;
  bool employment_IsEdit=false;
  int? employment_Edit_Index;

  bool _showAddSection_reference=false;
  bool get showAddSection_reference=>_showAddSection_reference;
  bool reference_IsEdit=false;
  int? reference_Edit_Index;

  // Set Positions Held (Multiselect)
  void setPositionsHeld(List<String> positions) {
    _positionsHeld = positions;
    notifyListeners();
  }

  void setEmpHisPositionsHeld(List<String> positions) {
    _empHis_positionsHeld = positions;
    print("_empHis_positionsHeld => ${_empHis_positionsHeld}");
    notifyListeners();
  }

  void setEmploymentHistoryVisibility(bool value){
    _showAddSection_employmentHistory=value;
    notifyListeners();
  }

  void setReferenceVisibility(bool value){
    _showAddSection_reference=value;
    notifyListeners();
  }

  void setReferenceIssuedBy(String value) {
    referenceIssuedBy = value;
    notifyListeners();
  }

  void setReferenceIssuingDate(DateTime date) {
    referenceIssuedDate.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  final picker = ImagePicker();

  String? positionsHeldError;
  String? vesselTypeExperienceError;

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      referenceDocument = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      referenceDocument = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void removeAttachment() {
    referenceDocument = null;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  // Set Vessel Type Experience (Multiselect)
  void setVesselTypeExperience(List<String> vessels) {
    _vesselTypeExperience = vessels;
    notifyListeners();
  }

  // Add Employment History
   addEmploymentHistory(EmploymentHistory historyRecord) {
    _employmentHistory.add(historyRecord);
    notifyListeners();
  }

  // Update Employment History
   updateEmploymentHistory(int index, EmploymentHistory updatedHistory) {
    _employmentHistory[index] = updatedHistory;
    notifyListeners();
  }

  // Remove Employment History
  void removeEmploymentHistory(int index) {
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
  Future<void> fetchProfessionalExperience(String userId, BuildContext context) async {
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
        final professionalExperienceResponse = ProfessionalExperienceResponse.fromJson(response);

        if (professionalExperienceResponse.data.isNotEmpty) {
          professionalExperienceData = professionalExperienceResponse.data.first;
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
  }

  // Populate form data from API response
  void _populateFormData() {
    if (professionalExperienceData == null) return;

    // Populate Positions Held
    if (professionalExperienceData!.positionsHeld != null && 
        professionalExperienceData!.positionsHeld!.isNotEmpty) {
      setPositionsHeld(professionalExperienceData!.positionsHeld!);
    }

    // Populate Vessel Type Experience
    if (professionalExperienceData!.vesselTypeExperience != null && 
        professionalExperienceData!.vesselTypeExperience!.isNotEmpty) {
      setVesselTypeExperience(professionalExperienceData!.vesselTypeExperience!);
    }

    // Populate Employment History
    if (professionalExperienceData!.employmentHistory != null && 
        professionalExperienceData!.employmentHistory!.isNotEmpty) {
      for (var history in professionalExperienceData!.employmentHistory!) {
        EmploymentHistory localHistory = EmploymentHistory(
          companyName: history.companyName ?? '',
          position: [history.position ?? ''],
          startDate: history.startDate ?? '',
          endDate: history.endDate ?? '',
          responsibilities: history.responsibilities ?? '',
        );
        _employmentHistory.add(localHistory);
      }
    }

    // Populate References
    if (professionalExperienceData!.references != null && 
        professionalExperienceData!.references!.isNotEmpty) {
      for (var reference in professionalExperienceData!.references!) {
        Reference localReference = Reference(
          issuedBy: reference.issuedBy ?? '',
          issuingDate: reference.issuingDate ?? '',
          vesselOrCompanyName: reference.vesselOrCompanyName ?? '',
          documentUrl: reference.experienceDocumentOriginalName ?? '',
        );
        _references.add(localReference);
      }
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

class EmploymentHistory {
  String companyName;
  List<String> position;
  String startDate;
  String endDate;
  String responsibilities;

  EmploymentHistory({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.responsibilities,
  });
}

class Reference {
  String issuedBy;
  String issuingDate;
  String vesselOrCompanyName;
  String documentUrl;

  Reference({
    required this.issuedBy,
    required this.issuingDate,
    required this.vesselOrCompanyName,
    required this.documentUrl,
  });
}
