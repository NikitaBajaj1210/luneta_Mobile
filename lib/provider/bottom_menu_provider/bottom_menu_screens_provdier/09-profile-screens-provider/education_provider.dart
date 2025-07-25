import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EducationProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final academicQualificationFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeAcademic = AutovalidateMode.disabled;

  final certificationFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeCertification = AutovalidateMode.disabled;

  // Academic Qualification
  List<AcademicQualification> academicQualificationList = [];
  bool showAddSection_academicQualification = false;
  int? academicQualification_Edit_Index;
  bool academicQualification_IsEdit = false;

  String? educationalDegree;
  final fieldOfStudyController = TextEditingController();
  final educationalInstitutionController = TextEditingController();
  String? country;
  final graduationDateController = TextEditingController();
  File? academicDocument;

  List<String> educationalDegrees = ["Bachelor's", "Master's", "PhD"];
  List<String> countries = ["USA", "UK", "Canada", "Australia"]; // Example list

  void setEducationalDegree(String value) {
    educationalDegree = value;
    notifyListeners();
  }

  void setCountry(String value) {
    country = value;
    notifyListeners();
  }

  void setGraduationDate(DateTime date) {
    graduationDateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void setAcademicDocument(File? file) {
    academicDocument = file;
    notifyListeners();
  }

  void addAcademicQualification(AcademicQualification qualification) {
    academicQualificationList.add(qualification);
    notifyListeners();
  }

  void updateAcademicQualification(int index, AcademicQualification qualification) {
    academicQualificationList[index] = qualification;
    notifyListeners();
  }

  void removeAcademicQualification(int index) {
    academicQualificationList.removeAt(index);
    notifyListeners();
  }

  void setAcademicQualificationVisibility(bool value) {
    showAddSection_academicQualification = value;
    notifyListeners();
  }

  // Certifications and Trainings
  List<Certification> certificationList = [];
  bool showAddSection_certification = false;
  int? certification_Edit_Index;
  bool certification_IsEdit = false;

  String? typeOfCertification;
  final issuingAuthorityController = TextEditingController();
  final issueDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  File? certificationDocument;

  List<String> certificationTypes = ["Certificate A", "Certificate B", "Certificate C"];

  void setTypeOfCertification(String value) {
    typeOfCertification = value;
    notifyListeners();
  }

  void setIssueDate(DateTime date) {
    issueDateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void setExpiryDate(DateTime date) {
    expiryDateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void setCertificationDocument(File? file) {
    certificationDocument = file;
    notifyListeners();
  }

  void addCertification(Certification certification) {
    certificationList.add(certification);
    notifyListeners();
  }

  void updateCertification(int index, Certification certification) {
    certificationList[index] = certification;
    notifyListeners();
  }

  void removeCertification(int index) {
    certificationList.removeAt(index);
    notifyListeners();
  }

  void setCertificationVisibility(bool value) {
    showAddSection_certification = value;
    notifyListeners();
  }


  // Languages Spoken
  List<String> nativeLanguages = [];
  String? additionalLanguage;
  String? additionalLanguageLevel;

  List<String> allLanguages = ["English", "Spanish", "French", "German"]; // Example list
  List<String> languageLevels = ["Fair", "Good", "Very Good", "Excellent"];

  void setNativeLanguages(List<String> languages) {
    nativeLanguages = languages;
    notifyListeners();
  }

  void setAdditionalLanguage(String language) {
    additionalLanguage = language;
    notifyListeners();
  }

  void setAdditionalLanguageLevel(String level) {
    additionalLanguageLevel = level;
    notifyListeners();
  }

  // File Picker
  final ImagePicker _picker = ImagePicker();

  Future<void> showAttachmentOptions(BuildContext context, String type) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery, type);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, type);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (type == 'academic') {
        setAcademicDocument(File(pickedFile.path));
      } else if (type == 'certification') {
        setCertificationDocument(File(pickedFile.path));
      }
    }
  }

  void removeAttachment(String type) {
    if (type == 'academic') {
      setAcademicDocument(null);
    } else if (type == 'certification') {
      setCertificationDocument(null);
    }
  }
}

class AcademicQualification {
  final String educationalDegree;
  final String fieldOfStudy;
  final String educationalInstitution;
  final String country;
  final String graduationDate;
  final File? document;

  AcademicQualification({
    required this.educationalDegree,
    required this.fieldOfStudy,
    required this.educationalInstitution,
    required this.country,
    required this.graduationDate,
    this.document,
  });
}

class Certification {
  final String typeOfCertification;
  final String issuingAuthority;
  final String issueDate;
  final String expiryDate;
  final File? document;

  Certification({
    required this.typeOfCertification,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expiryDate,
    this.document,
  });
}
