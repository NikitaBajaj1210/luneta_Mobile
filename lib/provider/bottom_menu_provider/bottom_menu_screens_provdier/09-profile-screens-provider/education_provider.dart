import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../models/education_model.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../Utils/helper.dart';
import '../../../../custom-component/globalComponent.dart';


class EducationProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final academicQualificationFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeAcademic = AutovalidateMode.disabled;

  final certificationFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeCertification = AutovalidateMode.disabled;

  final languagesSpokenFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeLanguages = AutovalidateMode.disabled;

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
  String? academicDocumentPath_temp;
  String? academicDocumentOriginalName_temp;

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
    // When adding a new qualification, set documentPath to the document's path if it exists
    AcademicQualification newQualification = AcademicQualification(
      educationalDegree: qualification.educationalDegree,
      fieldOfStudy: qualification.fieldOfStudy,
      educationalInstitution: qualification.educationalInstitution,
      country: qualification.country,
      graduationDate: qualification.graduationDate,
      document: qualification.document,
      documentPath: qualification.document?.path ?? '',
    );
    academicQualificationList.add(newQualification);
    notifyListeners();
  }
  
  void addAcademicQualificationWithDocument(AcademicQualification qualification, File? document) {
    AcademicQualification qual = AcademicQualification(
      educationalDegree: qualification.educationalDegree,
      fieldOfStudy: qualification.fieldOfStudy,
      educationalInstitution: qualification.educationalInstitution,
      country: qualification.country,
      graduationDate: qualification.graduationDate,
      document: document,
    );
    academicQualificationList.add(qual);
    notifyListeners();
  }

  void updateAcademicQualification(int index, AcademicQualification qualification) {
    // Preserve existing document if no new document is provided
    File? existingDocument = academicQualificationList[index].document;
    File? newDocument = qualification.document ?? existingDocument;
    
    // Preserve existing documentPath if no new document is provided
    String? existingDocumentPath = academicQualificationList[index].documentPath;
    String? newDocumentPath = qualification.document != null
        ? qualification.document!.path
        : (qualification.documentPath ?? existingDocumentPath);
    
    AcademicQualification updatedQual = AcademicQualification(
      educationalDegree: qualification.educationalDegree,
      fieldOfStudy: qualification.fieldOfStudy,
      educationalInstitution: qualification.educationalInstitution,
      country: qualification.country,
      graduationDate: qualification.graduationDate,
      document: newDocument,
      documentPath: newDocumentPath,
    );
    
    academicQualificationList[index] = updatedQual;
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
  String? certificationDocumentPath_temp;
  String? certificationDocumentOriginalName_temp;

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
    // When adding a new certification, set documentPath to the document's path if it exists
    Certification newCertification = Certification(
      typeOfCertification: certification.typeOfCertification,
      issuingAuthority: certification.issuingAuthority,
      issueDate: certification.issueDate,
      expiryDate: certification.expiryDate,
      document: certification.document,
      documentPath: certification.document?.path ?? '',
    );
    certificationList.add(newCertification);
    notifyListeners();
  }
  
  void addCertificationWithDocument(Certification certification, File? document) {
    Certification cert = Certification(
      typeOfCertification: certification.typeOfCertification,
      issuingAuthority: certification.issuingAuthority,
      issueDate: certification.issueDate,
      expiryDate: certification.expiryDate,
      document: document,
    );
    certificationList.add(cert);
    notifyListeners();
  }

  void updateCertification(int index, Certification certification) {
    // Preserve existing document if no new document is provided
    File? existingDocument = certificationList[index].document;
    File? newDocument = certification.document ?? existingDocument;
    
    // Preserve existing documentPath if no new document is provided
    String? existingDocumentPath = certificationList[index].documentPath;
    String? newDocumentPath = certification.document != null
        ? certification.document!.path
        : (certification.documentPath ?? existingDocumentPath);
    
    Certification updatedCert = Certification(
      typeOfCertification: certification.typeOfCertification,
      issuingAuthority: certification.issuingAuthority,
      issueDate: certification.issueDate,
      expiryDate: certification.expiryDate,
      document: newDocument,
      documentPath: newDocumentPath,
    );
    
    certificationList[index] = updatedCert;
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
      if (type == 'academic') {
        setAcademicDocument(file);
      } else if (type == 'certification') {
        setCertificationDocument(file);
      }
    }
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (type == 'academic') {
        setAcademicDocument(file);
      } else if (type == 'certification') {
        setCertificationDocument(file);
      }
    }
  }

  void removeAttachment(String type) {
    if (type == 'academic') {
      setAcademicDocument(null);
      academicDocumentPath_temp = null;
      academicDocumentOriginalName_temp = null;
    } else if (type == 'certification') {
      setCertificationDocument(null);
      certificationDocumentPath_temp = null;
      certificationDocumentOriginalName_temp = null;
    }
    notifyListeners();
  }

  bool hasExistingAcademicQualificationDocument(int? index) {
    if (index != null &&
        academicQualificationList.length > index &&
        academicQualificationList[index].documentPath != null &&
        academicQualificationList[index].documentPath!.isNotEmpty) {
      return true;
    }
    return academicDocumentPath_temp != null && academicDocumentPath_temp!.isNotEmpty;
  }

  void removeExistingAcademicQualificationAttachment(int index) {
    if (index < academicQualificationList.length) {
      academicQualificationList[index] = AcademicQualification(
        educationalDegree: academicQualificationList[index].educationalDegree,
        fieldOfStudy: academicQualificationList[index].fieldOfStudy,
        educationalInstitution: academicQualificationList[index].educationalInstitution,
        country: academicQualificationList[index].country,
        graduationDate: academicQualificationList[index].graduationDate,
        document: null,
        documentPath: null, // Mark as removed
      );
      academicDocumentPath_temp = null;
      academicDocumentOriginalName_temp = null;
      notifyListeners();
    }
  }

  bool hasExistingCertificationDocument(int? index) {
    if (index != null &&
        certificationList.length > index &&
        certificationList[index].documentPath != null &&
        certificationList[index].documentPath!.isNotEmpty) {
      return true;
    }
    return certificationDocumentPath_temp != null && certificationDocumentPath_temp!.isNotEmpty;
  }

  void removeExistingCertificationAttachment(int index) {
    if (index < certificationList.length) {
      certificationList[index] = Certification(
        typeOfCertification: certificationList[index].typeOfCertification,
        issuingAuthority: certificationList[index].issuingAuthority,
        issueDate: certificationList[index].issueDate,
        expiryDate: certificationList[index].expiryDate,
        document: null,
        documentPath: null, // Mark as removed
      );
      certificationDocumentPath_temp = null;
      certificationDocumentOriginalName_temp = null;
      notifyListeners();
    }
  }
  
  // Remove document from an existing academic qualification
  void removeAcademicQualificationDocument(int index) {
    AcademicQualification qualification = academicQualificationList[index];
    AcademicQualification updatedQual = AcademicQualification(
      educationalDegree: qualification.educationalDegree,
      fieldOfStudy: qualification.fieldOfStudy,
      educationalInstitution: qualification.educationalInstitution,
      country: qualification.country,
      graduationDate: qualification.graduationDate,
      document: null,
      documentPath: '', // Set to empty string to indicate removal
    );
    academicQualificationList[index] = updatedQual;
    notifyListeners();
  }
  
  // Remove document from an existing certification
  void removeCertificationDocument(int index) {
    Certification certification = certificationList[index];
    Certification updatedCert = Certification(
      typeOfCertification: certification.typeOfCertification,
      issuingAuthority: certification.issuingAuthority,
      issueDate: certification.issueDate,
      expiryDate: certification.expiryDate,
      document: null,
      documentPath: '', // Set to empty string to indicate removal
    );
    certificationList[index] = updatedCert;
    notifyListeners();
  }

  // API Methods
  bool isLoading = false;
  String errorMessage = '';
  bool hasError = false;
  EducationData? educationData;

  // Fetch education data from API
  Future<void> fetchEducationData(BuildContext context) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        hasError = true;
        errorMessage = 'User ID not found';
        isLoading = false;
        NetworkService.loading = 1; // Set error state
        notifyListeners();
        return;
      }

      final response = await NetworkService().getResponse(
        getEducationByUserId + userId,
        false, // showLoading
        context,
        () => notifyListeners(),
      );

      print("Education API Response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        EducationResponse educationResponse = EducationResponse.fromJson(response);
        
        if (educationResponse.data != null) {
          educationData = educationResponse.data;
          _populateFormData(educationResponse.data!);
          print("Education data loaded successfully");
        } else {
          print("No education data found");
        }
        NetworkService.loading = 2; // Set success state
      } else {
        hasError = true;
        errorMessage = response['message'] ?? 'Failed to fetch education data';
        NetworkService.loading = 1; // Set error state
        print("Education API Error: $errorMessage");
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
      NetworkService.loading = 1; // Set error state
      print("Education API Exception: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Populate form data from API response
  void _populateFormData(EducationData data) {
    // Clear existing data
    academicQualificationList.clear();
    certificationList.clear();
    nativeLanguages.clear();
    additionalLanguage = null;
    additionalLanguageLevel = null;

    // Populate Academic Qualifications
    if (data.academicQualification != null) {
      for (var qualification in data.academicQualification!) {
        AcademicQualification academicQual = AcademicQualification(
          educationalDegree: qualification.educationalDegree ?? '',
          fieldOfStudy: qualification.fieldOfStudy ?? '',
          educationalInstitution: qualification.educationalInstitution ?? '',
          country: qualification.country ?? '',
          graduationDate: qualification.graduationDate ?? '',
          document: null, // Document file would need to be handled separately
          documentPath: qualification.document, // Store the document path from API
        );
        academicQualificationList.add(academicQual);
      }
    }

    // Populate Certifications
    if (data.certificationsAndTrainings != null) {
      for (var certification in data.certificationsAndTrainings!) {
        Certification cert = Certification(
          typeOfCertification: certification.certificationType ?? '',
          issuingAuthority: certification.issuingAuthority ?? '',
          issueDate: certification.issueDate ?? '',
          expiryDate: certification.expiryDate ?? '',
          document: null, // Document file would need to be handled separately
          documentPath: certification.document, // Store the document path from API
        );
        certificationList.add(cert);
      }
    }

    // Populate Languages
    if (data.languagesSpoken != null && data.languagesSpoken!.isNotEmpty) {
      var languageData = data.languagesSpoken!.first;
      if (languageData.native != null) {
        nativeLanguages = List<String>.from(languageData.native!);
      }
      additionalLanguage = languageData.additionalLanguage;
      additionalLanguageLevel = languageData.level;
    }

    notifyListeners();
  }

  // Create or update education data
  Future<bool> createOrUpdateEducationAPI(BuildContext context) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        hasError = true;
        errorMessage = 'User ID not found';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Prepare the data object
      Map<String, dynamic> educationPayload = {
        'userId': userId,
        'academicQualification': academicQualificationList.map((qual) => {
          'educationalDegree': qual.educationalDegree,
          'fieldOfStudy': qual.fieldOfStudy,
          'educationalInstitution': qual.educationalInstitution,
          'country': qual.country,
          'graduationDate': qual.graduationDate,
          'document': qual.document?.path.split('/').last ?? (qual.documentPath == '' ? null : qual.documentPath),
        }).toList(),
        'certificationsAndTrainings': certificationList.map((cert) => {
          'certificationType': cert.typeOfCertification,
          'issuingAuthority': cert.issuingAuthority,
          'issueDate': cert.issueDate,
          'expiryDate': cert.expiryDate,
          'neverExpire': false, // Default value
          'document': cert.document?.path.split('/').last ?? (cert.documentPath == '' ? null : cert.documentPath),
        }).toList(),
        'languagesSpoken': [
          {
            'native': nativeLanguages,
            'additionalLanguage': additionalLanguage ?? '',
            'level': additionalLanguageLevel ?? '',
          }
        ],
      };

      // Convert data to the format expected by Dio function
      Map<String, dynamic> dioFieldData = {
        'data': jsonEncode(educationPayload), // API expects a single object
      };

      // Convert fileList to the format expected by Dio function
      List<Map<String, dynamic>> dioFileList = [];

      // Add academic qualification files
      for (int i = 0; i < academicQualificationList.length; i++) {
        // Only add files that are not marked for removal
        if (academicQualificationList[i].document != null && academicQualificationList[i].documentPath != '') {
          dioFileList.add({
            'fieldName': 'academicQualificationFiles${i}',
            'filePath': academicQualificationList[i].document!.path,
            'fileName': academicQualificationList[i].document!.path.split('/').last,
          });
        }
      }

      // Add certification files
      for (int i = 0; i < certificationList.length; i++) {
        // Only add files that are not marked for removal
        if (certificationList[i].document != null && certificationList[i].documentPath != '') {
          dioFileList.add({
            'fieldName': 'certificationsAndTrainingsFiles${i}',
            'filePath': certificationList[i].document!.path,
            'fileName': certificationList[i].document!.path.split('/').last,
          });
        }
      }

      print("Education API Field Data: $dioFieldData");
      print("Education API File List: $dioFileList");

      // Call the Dio-based multipart function from globalComponent
      final response = await multipartDocumentsDio(
        context,
        createOrUpdateEducation,
        dioFieldData,
        dioFileList,
        false, // showLoading
      );

      print("Education Create/Update Response: $response");

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        ShowToast("Success", "Education data saved successfully");
        return true;
      } else {
        hasError = true;
        errorMessage = response['message'] ?? 'Failed to save education data';
        ShowToast("Error", errorMessage);
        return false;
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
      ShowToast("Error", errorMessage);
      print("Education Create/Update Exception: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Reset form data
  void resetForm() {
    academicQualificationList.clear();
    certificationList.clear();
    nativeLanguages.clear();
    additionalLanguage = null;
    additionalLanguageLevel = null;
    educationData = null;
    hasError = false;
    errorMessage = '';
    autovalidateMode = AutovalidateMode.disabled;
    autovalidateModeAcademic = AutovalidateMode.disabled;
    autovalidateModeCertification = AutovalidateMode.disabled;
    autovalidateModeLanguages = AutovalidateMode.disabled;
    notifyListeners();
  }
}

class AcademicQualification {
  final String educationalDegree;
  final String fieldOfStudy;
  final String educationalInstitution;
  final String country;
  final String graduationDate;
  final File? document;
  final String? documentPath;

  AcademicQualification({
    required this.educationalDegree,
    required this.fieldOfStudy,
    required this.educationalInstitution,
    required this.country,
    required this.graduationDate,
    this.document,
    this.documentPath,
  });
}

class Certification {
  final String typeOfCertification;
  final String issuingAuthority;
  final String issueDate;
  final String expiryDate;
  final File? document;
  final String? documentPath;

  Certification({
    required this.typeOfCertification,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expiryDate,
    this.document,
    this.documentPath,
  });
}
