import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfessionalExperienceProvider extends ChangeNotifier {
  // Controllers for text fields
  final TextEditingController companyController = TextEditingController();
  // final TextEditingController positionController = TextEditingController();
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

  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      referenceDocumentController.text = pickedFile.path.split('/').last;
      notifyListeners();
    } else {
      print('No image selected.');
    }
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
