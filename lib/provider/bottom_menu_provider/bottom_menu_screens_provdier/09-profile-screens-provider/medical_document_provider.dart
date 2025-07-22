import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';

class MedicalDocumentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  List<String> countries = [];
  List<String> medicalFitnessDocumentTypes = ["PEME", "HMO", "Standard Medical Exam"];
  List<String> drugAndAlcoholTestDocumentTypes = ["Type A", "Type B", "Type C"];
  List<String> vaccinationCertificateDocumentTypes = ["COVID 19", "Yellow Fever", "Tetanus", "Diphtheria", "Hepatitis A", "Hepatitis B", "Cholera"];

  MedicalDocumentProvider() {
    countries = CountryService().getAll().map((country) => country.name).toList();
  }
  // Controllers
  final TextEditingController medicalFitnessCertificateNoController = TextEditingController();
  final TextEditingController medicalFitnessIssuingAuthorityController = TextEditingController();
  final TextEditingController medicalFitnessIssueDateController = TextEditingController();
  final TextEditingController medicalFitnessExpiryDateController = TextEditingController();
  File? medicalFitnessDocument;
  final TextEditingController drugAndAlcoholTestCertificateNoController = TextEditingController();
  final TextEditingController drugAndAlcoholTestIssuingAuthorityController = TextEditingController();
  final TextEditingController drugAndAlcoholTestIssueDateController = TextEditingController();
  final TextEditingController drugAndAlcoholTestExpiryDateController = TextEditingController();
  File? drugAndAlcoholTestDocument;
  final TextEditingController vaccinationCertificateIssuingAuthorityController = TextEditingController();
  final TextEditingController vaccinationCertificateIssueDateController = TextEditingController();
  final TextEditingController vaccinationCertificateExpiryDateController = TextEditingController();
  File? vaccinationCertificateDocument;

  // Focus Nodes
  final FocusNode medicalFitnessCertificateNoFocusNode = FocusNode();
  final FocusNode medicalFitnessIssuingAuthorityFocusNode = FocusNode();
  final FocusNode medicalFitnessIssueDateFocusNode = FocusNode();
  final FocusNode medicalFitnessExpiryDateFocusNode = FocusNode();
  final FocusNode drugAndAlcoholTestCertificateNoFocusNode = FocusNode();
  final FocusNode drugAndAlcoholTestIssuingAuthorityFocusNode = FocusNode();
  final FocusNode drugAndAlcoholTestIssueDateFocusNode = FocusNode();
  final FocusNode drugAndAlcoholTestExpiryDateFocusNode = FocusNode();
  final FocusNode vaccinationCertificateIssuingAuthorityFocusNode = FocusNode();
  final FocusNode vaccinationCertificateIssueDateFocusNode = FocusNode();
  final FocusNode vaccinationCertificateExpiryDateFocusNode = FocusNode();

  // Medical Fitness
  List<MedicalFitness> medicalFitnessList = [];
  bool showAddSection_medicalFitness = false;
  int? medicalFitness_Edit_Index;
  bool medicalFitness_IsEdit = false;

  void setMedicalFitnessVisibility(bool value) {
    showAddSection_medicalFitness = value;
    notifyListeners();
  }

  void addMedicalFitness(MedicalFitness medicalFitness) {
    medicalFitnessList.add(medicalFitness);
    notifyListeners();
  }

  void updateMedicalFitness(int index, MedicalFitness medicalFitness) {
    medicalFitnessList[index] = medicalFitness;
    notifyListeners();
  }

  void removeMedicalFitness(int index) {
    medicalFitnessList.removeAt(index);
    notifyListeners();
  }

  bool medicalFitnessNeverExpire = false;
  String? medicalFitnessDocumentType;
  String? medicalFitnessIssuingCountry;

  void setMedicalFitnessNeverExpire(bool value) {
    medicalFitnessNeverExpire = value;
    notifyListeners();
  }

  void setMedicalFitnessDocumentType(String value) {
    medicalFitnessDocumentType = value;
    notifyListeners();
  }

  void setMedicalFitnessIssuingCountry(String value) {
    medicalFitnessIssuingCountry = value;
    notifyListeners();
  }

  void setMedicalFitnessIssueDate(DateTime date) {
    medicalFitnessIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setMedicalFitnessExpiryDate(DateTime date) {
    medicalFitnessExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  // Drug & Alcohol Test
  String? drugAndAlcoholTestDocumentType;
  String? drugAndAlcoholTestIssuingCountry;

  void setDrugAndAlcoholTestDocumentType(String value) {
    drugAndAlcoholTestDocumentType = value;
    notifyListeners();
  }

  void setDrugAndAlcoholTestIssuingCountry(String value) {
    drugAndAlcoholTestIssuingCountry = value;
    notifyListeners();
  }

  void setDrugAndAlcoholTestIssueDate(DateTime date) {
    drugAndAlcoholTestIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setDrugAndAlcoholTestExpiryDate(DateTime date) {
    drugAndAlcoholTestExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  // Vaccination Certificates
  bool vaccinationCertificateNeverExpire = false;
  String? vaccinationCertificateDocumentType;
  String? vaccinationCertificateIssuingCountry;

  void setVaccinationCertificateNeverExpire(bool value) {
    vaccinationCertificateNeverExpire = value;
    notifyListeners();
  }

  void setVaccinationCertificateDocumentType(String value) {
    vaccinationCertificateDocumentType = value;
    notifyListeners();
  }

  void setVaccinationCertificateIssuingCountry(String value) {
    vaccinationCertificateIssuingCountry = value;
    notifyListeners();
  }

  void setVaccinationCertificateIssueDate(DateTime date) {
    vaccinationCertificateIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setVaccinationCertificateExpiryDate(DateTime date) {
    vaccinationCertificateExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  final picker = ImagePicker();

  Future<void> showAttachmentOptions(BuildContext context, String type) async {
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
                  _pickImage(ImageSource.gallery, type);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera, type);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () {
                  _pickDocument(type);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDocument(String type) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      switch (type) {
        case 'medical_fitness':
          medicalFitnessDocument = file;
          break;
        case 'drug_alcohol_test':
          drugAndAlcoholTestDocument = file;
          break;
        case 'vaccination_certificate':
          vaccinationCertificateDocument = file;
          break;
      }
      notifyListeners();
    }
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      switch (type) {
        case 'medical_fitness':
          medicalFitnessDocument = file;
          break;
        case 'drug_alcohol_test':
          drugAndAlcoholTestDocument = file;
          break;
        case 'vaccination_certificate':
          vaccinationCertificateDocument = file;
          break;
      }
      notifyListeners();
    }
  }

  void removeAttachment(String type) {
    switch (type) {
      case 'medical_fitness':
        medicalFitnessDocument = null;
        break;
      case 'drug_alcohol_test':
        drugAndAlcoholTestDocument = null;
        break;
      case 'vaccination_certificate':
        vaccinationCertificateDocument = null;
        break;
    }
    notifyListeners();
  }
}

class MedicalFitness {
  String documentType;
  String certificateNo;
  String issuingCountry;
  String issuingAuthority;
  String issueDate;
  String expiryDate;
  bool neverExpire;
  File? document;

  MedicalFitness({
    required this.documentType,
    required this.certificateNo,
    required this.issuingCountry,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expiryDate,
    required this.neverExpire,
    this.document,
  });
}
