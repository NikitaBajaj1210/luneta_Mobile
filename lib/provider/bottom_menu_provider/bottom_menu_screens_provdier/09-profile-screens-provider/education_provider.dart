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

  // Comprehensive list of languages
  List<String> allLanguages = [
    "English", "Spanish", "French", "German", "Italian", "Portuguese", 
    "Russian", "Chinese", "Japanese", "Korean", "Arabic", "Hindi", 
    "Bengali", "Urdu", "Turkish", "Dutch", "Swedish", "Norwegian", 
    "Danish", "Finnish", "Polish", "Czech", "Hungarian", "Romanian", 
    "Bulgarian", "Greek", "Hebrew", "Thai", "Vietnamese", "Indonesian", 
    "Malay", "Filipino", "Swahili", "Yoruba", "Zulu", "Afrikaans"
  ];
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

  // Get selected native languages for display
  List<String> getSelectedNativeLanguages() {
    return nativeLanguages;
  }

  // Check if a language is selected as native
  bool isNativeLanguageSelected(String language) {
    return nativeLanguages.contains(language);
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
    } else if (type == 'certification') {
      setCertificationDocument(null);
    }
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
      } else {
        hasError = true;
        errorMessage = response['message'] ?? 'Failed to fetch education data';
        print("Education API Error: $errorMessage");
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
      print("Education API Exception: $e");
          } finally {
        isLoading = false;
        notifyListeners();
      }
  }

  // Populate form data from API response
  void _populateFormData(dynamic data) {
    try {
      // Clear existing data
      academicQualificationList.clear();
      certificationList.clear();
      nativeLanguages.clear();
      additionalLanguage = null;
      additionalLanguageLevel = null;

      // Handle both EducationData model and raw Map response
      Map<String, dynamic> responseData;
      if (data is EducationData) {
        // Handle EducationData model
        responseData = {
          'academicQualification': data.academicQualification?.map((q) => {
            'educationalDegree': q.educationalDegree,
            'fieldOfStudy': q.fieldOfStudy,
            'educationalInstitution': q.educationalInstitution,
            'country': q.country,
            'graduationDate': q.graduationDate,
          }).toList(),
          'certificationsAndTrainings': data.certificationsAndTrainings?.map((c) => {
            'certificationType': c.certificationType,
            'issuingAuthority': c.issuingAuthority,
            'issueDate': c.issueDate,
            'expiryDate': c.expiryDate,
          }).toList(),
          'languagesSpoken': data.languagesSpoken?.map((l) => {
            'native': l.native,
            'additionalLanguage': l.additionalLanguage,
            'level': l.level,
          }).toList(),
        };
      } else if (data is Map<String, dynamic>) {
        // Handle raw Map response
        responseData = data;
      } else {
        print("Unknown data type for _populateFormData: ${data.runtimeType}");
        return;
      }

      // Populate academic qualifications
      if (responseData['academicQualification'] != null) {
        List<dynamic> academicData = responseData['academicQualification'];
        for (var item in academicData) {
          AcademicQualification qualification = AcademicQualification(
            educationalDegree: item['educationalDegree'] ?? '',
            fieldOfStudy: item['fieldOfStudy'] ?? '',
            educationalInstitution: item['educationalInstitution'] ?? '',
            country: item['country'] ?? '',
            graduationDate: item['graduationDate'] ?? '',
            document: null, // We don't have file object from API response
          );
          academicQualificationList.add(qualification);
        }
      }

      // Populate certifications
      if (responseData['certificationsAndTrainings'] != null) {
        List<dynamic> certificationData = responseData['certificationsAndTrainings'];
        for (var item in certificationData) {
          Certification certification = Certification(
            typeOfCertification: item['certificationType'] ?? '',
            issuingAuthority: item['issuingAuthority'] ?? '',
            issueDate: item['issueDate'] ?? '',
            expiryDate: item['expiryDate'] ?? '',
            document: null, // We don't have file object from API response
          );
          certificationList.add(certification);
        }
      }

      // Populate languages
      if (responseData['languagesSpoken'] != null && responseData['languagesSpoken'].isNotEmpty) {
        var languageData = responseData['languagesSpoken'][0];
        print("Language data from API: $languageData");
        
        if (languageData['native'] != null) {
          nativeLanguages = List<String>.from(languageData['native']);
          print("Native languages populated: $nativeLanguages");
        } else {
          print("No native languages found in API response");
        }
        
        additionalLanguage = languageData['additionalLanguage'];
        additionalLanguageLevel = languageData['level'];
        print("Additional language: $additionalLanguage, Level: $additionalLanguageLevel");
      } else {
        print("No languages data found in API response");
      }

      print("Form data populated successfully");
      print("Academic qualifications: ${academicQualificationList.length}");
      print("Certifications: ${certificationList.length}");
      print("Native languages: $nativeLanguages");
      print("Additional language: $additionalLanguage");
      print("Language level: $additionalLanguageLevel");
      
      notifyListeners();
    } catch (e) {
      print("Error populating form data: $e");
    }
  }

    // Create or update education data
  Future<bool> createOrUpdateEducationAPI(BuildContext context) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      String userId = NetworkHelper.loggedInUserId;
      // if (userId.isEmpty) {
      //   hasError = true;
      //   errorMessage = 'User ID not found';
      //   isLoading = false;
      //   notifyListeners();
      //   return false;
      // }

      // Prepare the data object
      Map<String, dynamic> educationPayload = {
        'userId': userId,
        'academicQualification': academicQualificationList.map((qual) => {
          'educationalDegree': qual.educationalDegree,
          'fieldOfStudy': qual.fieldOfStudy,
          'educationalInstitution': qual.educationalInstitution,
          'country': qual.country,
          'graduationDate': qual.graduationDate,
          'document': qual.document?.path.split('/').last ?? '',
        }).toList(),
        'certificationsAndTrainings': certificationList.map((cert) => {
          'certificationType': cert.typeOfCertification,
          'issuingAuthority': cert.issuingAuthority,
          'issueDate': cert.issueDate,
          'expiryDate': cert.expiryDate,
          'neverExpire': false, // Default value
          'document': cert.document?.path.split('/').last ?? '',
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
        'data': jsonEncode(educationPayload), // API expects a JSON string
      };

      // Convert fileList to the format expected by Dio function
      List<Map<String, dynamic>> dioFileList = [];

      // Add academic qualification files
      for (int i = 0; i < academicQualificationList.length; i++) {
        if (academicQualificationList[i].document != null) {
          dioFileList.add({
            'fieldName': 'academicQualificationFiles',
            'filePath': academicQualificationList[i].document!.path,
            'fileName': academicQualificationList[i].document!.path.split('/').last,
          });
        }
      }

      // Add certification files
      for (int i = 0; i < certificationList.length; i++) {
        if (certificationList[i].document != null) {
          dioFileList.add({
            'fieldName': 'certificationsAndTrainingsFiles',
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
