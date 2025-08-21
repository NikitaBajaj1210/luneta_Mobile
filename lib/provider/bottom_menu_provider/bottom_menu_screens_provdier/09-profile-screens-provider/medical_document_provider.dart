// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:country_picker/country_picker.dart';
// import 'dart:convert';
// import '../../../../models/medical_document_model.dart';
// import '../../../../network/app_url.dart';
// import '../../../../network/network_helper.dart';
// import '../../../../network/network_services.dart';
// import '../../../../custom-component/globalComponent.dart';
//
// class MedicalDocumentProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//   final medicalFitnessFormKey = GlobalKey<FormState>();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
//   AutovalidateMode autovalidateModeMedical = AutovalidateMode.disabled;
//
//   // Loading states
//   bool isLoading = false;
//   bool hasError = false;
//   String errorMessage = '';
//   MedicalDocument? medicalDocumentData;
//
//   List<String> countries = [];
//   List<String> medicalFitnessDocumentTypes = ["PEME", "HMO", "Standard Medical Exam"];
//   List<String> drugAndAlcoholTestDocumentTypes = ["Type A", "Type B", "Type C"];
//   List<String> vaccinationCertificateDocumentTypes = ["COVID 19", "Yellow Fever", "Tetanus", "Diphtheria", "Hepatitis A", "Hepatitis B", "Cholera"];
//
//   MedicalDocumentProvider() {
//     countries = CountryService().getAll().map((country) => country.name).toList();
//   }
//
//   // API call to fetch medical document data
//   Future<void> fetchMedicalDocuments(String userId, BuildContext context) async {
//     // If no userId provided, try to get from NetworkHelper
//     if (userId.isEmpty) {
//       userId = NetworkHelper.loggedInUserId;
//       print("LOGIN USER ID ${NetworkHelper.loggedInUserId}");
//     }
//
//     if (userId.isEmpty) {
//       hasError = true;
//       errorMessage = 'User ID not found. Please login again.';
//       isLoading = false;
//       notifyListeners();
//       return;
//     }
//
//     isLoading = true;
//     hasError = false;
//     errorMessage = '';
//     notifyListeners();
//
//     // try {
//       final response = await NetworkService().getResponse(
//         '$getMedicalDocumentsByUserId$userId',
//         false, // showLoading - let the provider handle loading
//         context,
//         () {}, // notify callback
//       );
//
//       print('Medical Documents Response: $response');
//
//       if (response.isNotEmpty) {
//         final medicalDocumentResponse = MedicalDocumentResponse.fromJson(response);
//
//         medicalDocumentData = medicalDocumentResponse.data;
//         _populateFormData();
//
//         ShowToast("Success", "Medical documents fetched successfully");
//       } else {
//         hasError = true;
//         ShowToast("Error", "Failed to load medical documents");
//       }
//     // } catch (e) {
//     //   hasError = true;
//     //   errorMessage = 'Network error: ${e.toString()}';
//     //   ShowToast("Error", "Network error: ${e.toString()}");
//     // } finally {
//     //   isLoading = false;
//     //   notifyListeners();
//     // }
//   }
//
//   // Populate form data from API response
//   void _populateFormData() {
//     if (medicalDocumentData == null) return;
//
//     // Populate Medical Fitness data
//     if (medicalDocumentData!.medicalFitness!.isNotEmpty) {
//       for (var fitness in medicalDocumentData!.medicalFitness!) {
//         MedicalFitness localFitness = MedicalFitness(
//           documentType: fitness.documentType!,
//           certificateNo: fitness.certificateNo!,
//           issuingCountry: fitness.issuingCountry!,
//           issuingAuthority: fitness.issuingAuthority!,
//           issueDate: fitness.issuingDate!,
//           expiryDate: fitness.expDate!,
//           neverExpire: fitness.neverExpire!,
//           document: null, // We don't have the actual file, just the path
//         );
//         medicalFitnessList.add(localFitness);
//       }
//     }
//
//     // Populate Drug & Alcohol Test data
//     if (medicalDocumentData!.drugAlcoholTest!.isNotEmpty) {
//       for (var test in medicalDocumentData!.drugAlcoholTest!) {
//         // Set the first drug & alcohol test data to the form fields
//         drugAndAlcoholTestDocumentType = test.documentType;
//         drugAndAlcoholTestCertificateNoController.text = test.certificateNo!;
//         drugAndAlcoholTestIssuingCountry = test.issuingCountry;
//         drugAndAlcoholTestIssuingAuthorityController.text = test.issuingAuthority!;
//         drugAndAlcoholTestIssueDateController.text = test.issuingDate!;
//         if (test.expDate != null) {
//           drugAndAlcoholTestExpiryDateController.text = test.expDate!;
//         }
//         break; // Only populate the first one for now
//       }
//     }
//
//     // Populate Vaccination Certificate data
//     if (medicalDocumentData!.vaccinationCertificates!.isNotEmpty) {
//       for (var cert in medicalDocumentData!.vaccinationCertificates!) {
//         // Set the first vaccination certificate data to the form fields
//         vaccinationCertificateDocumentType = cert.documentType;
//         vaccinationCertificateIssuingCountry = cert.issuingCountry;
//         vaccinationCertificateIssuingAuthorityController.text = cert.issuingAuthority!;
//         vaccinationCertificateIssueDateController.text = cert.issuingDate!;
//         vaccinationCertificateExpiryDateController.text = cert.expDate!;
//         vaccinationCertificateNeverExpire = cert.neverExpire!;
//         break; // Only populate the first one for now
//       }
//     }
//   }
//   // Controllers
//   final TextEditingController medicalFitnessCertificateNoController = TextEditingController();
//   final TextEditingController medicalFitnessIssuingAuthorityController = TextEditingController();
//   final TextEditingController medicalFitnessIssueDateController = TextEditingController();
//   final TextEditingController medicalFitnessExpiryDateController = TextEditingController();
//   File? medicalFitnessDocument;
//   final TextEditingController drugAndAlcoholTestCertificateNoController = TextEditingController();
//   final TextEditingController drugAndAlcoholTestIssuingAuthorityController = TextEditingController();
//   final TextEditingController drugAndAlcoholTestIssueDateController = TextEditingController();
//   final TextEditingController drugAndAlcoholTestExpiryDateController = TextEditingController();
//   File? drugAndAlcoholTestDocument;
//   final TextEditingController vaccinationCertificateCertificateNoController = TextEditingController();
//   final TextEditingController vaccinationCertificateIssuingAuthorityController = TextEditingController();
//   final TextEditingController vaccinationCertificateIssueDateController = TextEditingController();
//   final TextEditingController vaccinationCertificateExpiryDateController = TextEditingController();
//   File? vaccinationCertificateDocument;
//
//   // Focus Nodes
//   final FocusNode medicalFitnessCertificateNoFocusNode = FocusNode();
//   final FocusNode medicalFitnessIssuingAuthorityFocusNode = FocusNode();
//   final FocusNode medicalFitnessIssueDateFocusNode = FocusNode();
//   final FocusNode medicalFitnessExpiryDateFocusNode = FocusNode();
//   final FocusNode drugAndAlcoholTestCertificateNoFocusNode = FocusNode();
//   final FocusNode drugAndAlcoholTestIssuingAuthorityFocusNode = FocusNode();
//   final FocusNode drugAndAlcoholTestIssueDateFocusNode = FocusNode();
//   final FocusNode drugAndAlcoholTestExpiryDateFocusNode = FocusNode();
//   final FocusNode vaccinationCertificateIssuingAuthorityFocusNode = FocusNode();
//   final FocusNode vaccinationCertificateIssueDateFocusNode = FocusNode();
//   final FocusNode vaccinationCertificateExpiryDateFocusNode = FocusNode();
//
//   // Medical Fitness
//   List<MedicalFitness> medicalFitnessList = [];
//   bool showAddSection_medicalFitness = false;
//   int? medicalFitness_Edit_Index;
//   bool medicalFitness_IsEdit = false;
//
//   void setMedicalFitnessVisibility(bool value) {
//     showAddSection_medicalFitness = value;
//     notifyListeners();
//   }
//
//   void addMedicalFitness(MedicalFitness medicalFitness) {
//     medicalFitnessList.add(medicalFitness);
//     notifyListeners();
//   }
//
//   void updateMedicalFitness(int index, MedicalFitness medicalFitness) {
//     medicalFitnessList[index] = medicalFitness;
//     notifyListeners();
//   }
//
//   void removeMedicalFitness(int index) {
//     medicalFitnessList.removeAt(index);
//     notifyListeners();
//   }
//
//   bool medicalFitnessNeverExpire = false;
//   String? medicalFitnessDocumentType;
//   String? medicalFitnessIssuingCountry;
//
//   void setMedicalFitnessNeverExpire(bool value) {
//     medicalFitnessNeverExpire = value;
//     notifyListeners();
//   }
//
//   void setMedicalFitnessDocumentType(String value) {
//     medicalFitnessDocumentType = value;
//     notifyListeners();
//   }
//
//   void setMedicalFitnessIssuingCountry(String value) {
//     medicalFitnessIssuingCountry = value;
//     notifyListeners();
//   }
//
//   void setMedicalFitnessIssueDate(DateTime date) {
//     medicalFitnessIssueDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   void setMedicalFitnessExpiryDate(DateTime date) {
//     medicalFitnessExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   // Drug & Alcohol Test
//   String? drugAndAlcoholTestDocumentType;
//   String? drugAndAlcoholTestIssuingCountry;
//   bool? drugAndAlcoholTestNeverExpire;
//
//   void setDrugAndAlcoholTestDocumentType(String value) {
//     drugAndAlcoholTestDocumentType = value;
//     notifyListeners();
//   }
//
//   void setDrugAndAlcoholTestIssuingCountry(String value) {
//     drugAndAlcoholTestIssuingCountry = value;
//     notifyListeners();
//   }
//
//   void setDrugAndAlcoholTestIssueDate(DateTime date) {
//     drugAndAlcoholTestIssueDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   void setDrugAndAlcoholTestExpiryDate(DateTime date) {
//     drugAndAlcoholTestExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   void setDrugAndAlcoholTestNeverExpire(bool value) {
//     drugAndAlcoholTestNeverExpire = value;
//     notifyListeners();
//   }
//
//   // Vaccination Certificates
//   bool vaccinationCertificateNeverExpire = false;
//   String? vaccinationCertificateDocumentType;
//   String? vaccinationCertificateIssuingCountry;
//
//   void setVaccinationCertificateNeverExpire(bool value) {
//     vaccinationCertificateNeverExpire = value;
//     notifyListeners();
//   }
//
//   void setVaccinationCertificateDocumentType(String value) {
//     vaccinationCertificateDocumentType = value;
//     notifyListeners();
//   }
//
//   void setVaccinationCertificateIssuingCountry(String value) {
//     vaccinationCertificateIssuingCountry = value;
//     notifyListeners();
//   }
//
//   void setVaccinationCertificateIssueDate(DateTime date) {
//     vaccinationCertificateIssueDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   void setVaccinationCertificateExpiryDate(DateTime date) {
//     vaccinationCertificateExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
//     notifyListeners();
//   }
//
//   final picker = ImagePicker();
//
//   Future<void> showAttachmentOptions(BuildContext context, String type) async {
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
//                   _pickImage(ImageSource.gallery, type);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text('Take a picture'),
//                 onTap: () {
//                   _pickImage(ImageSource.camera, type);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.description),
//                 title: Text('Choose a document'),
//                 onTap: () {
//                   _pickDocument(type);
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
//   Future<void> _pickDocument(String type) async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//     if (result != null) {
//       final file = File(result.files.single.path!);
//       switch (type) {
//         case 'medical_fitness':
//           medicalFitnessDocument = file;
//           break;
//         case 'drug_alcohol_test':
//           drugAndAlcoholTestDocument = file;
//           break;
//         case 'vaccination_certificate':
//           vaccinationCertificateDocument = file;
//           break;
//       }
//       notifyListeners();
//     }
//   }
//
//   Future<void> _pickImage(ImageSource source, String type) async {
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       switch (type) {
//         case 'medical_fitness':
//           medicalFitnessDocument = file;
//           break;
//         case 'drug_alcohol_test':
//           drugAndAlcoholTestDocument = file;
//           break;
//         case 'vaccination_certificate':
//           vaccinationCertificateDocument = file;
//           break;
//       }
//       notifyListeners();
//     }
//   }
//
//   void removeAttachment(String type) {
//     switch (type) {
//       case 'medical_fitness':
//         medicalFitnessDocument = null;
//         break;
//       case 'drug_alcohol_test':
//         drugAndAlcoholTestDocument = null;
//         break;
//       case 'vaccination_certificate':
//         vaccinationCertificateDocument = null;
//         break;
//     }
//     notifyListeners();
//   }
//
//   // API call to create or update medical documents
//   Future<bool> createOrUpdateMedicalDocumentsAPI(BuildContext context) async {
//     hasError = false;
//     errorMessage = '';
//     notifyListeners();
//
//     try {
//       // Prepare the data object
//       Map<String, dynamic> medicalDocument = {
//         'userId': NetworkHelper.loggedInUserId,
//         'medicalFitness': medicalFitnessList.map((fitness) => {
//           'documentType': fitness.documentType,
//           'certificateNo': fitness.certificateNo,
//           'issuingCountry': fitness.issuingCountry,
//           'issuingAuthority': fitness.issuingAuthority,
//           'issuingDate': fitness.issueDate,
//           'expDate': fitness.expiryDate,
//           'neverExpiry': fitness.neverExpire,
//         }).toList(),
//         'drugAlcoholTest': [{
//           'documentType': drugAndAlcoholTestDocumentType ?? '',
//           'certificateNo': drugAndAlcoholTestCertificateNoController.text,
//           'issuingCountry': drugAndAlcoholTestIssuingCountry ?? '',
//           'issuingAuthority': drugAndAlcoholTestIssuingAuthorityController.text,
//           'issuingDate': drugAndAlcoholTestIssueDateController.text,
//           'expDate': drugAndAlcoholTestExpiryDateController.text,
//           'neverExpiry': drugAndAlcoholTestNeverExpire ?? false,
//         }],
//         'vaccinationCertificates': [{
//           'documentType': vaccinationCertificateDocumentType ?? '',
//           'certificateNo': vaccinationCertificateCertificateNoController.text,
//           'issuingCountry': vaccinationCertificateIssuingCountry ?? '',
//           'issuingAuthority': vaccinationCertificateIssuingAuthorityController.text,
//           'issuingDate': vaccinationCertificateIssueDateController.text,
//           'expDate': vaccinationCertificateExpiryDateController.text,
//           'neverExpiry': vaccinationCertificateNeverExpire,
//         }],
//       };
//
//       // Convert data to the format expected by Dio function
//       Map<String, dynamic> dioFieldData = {
//         'data': jsonEncode(medicalDocument), // API expects an array
//       };
//
//       // Convert fileList to the format expected by Dio function
//       List<Map<String, dynamic>> dioFileList = [];
//
//       // Add medical fitness files
//       for (int i = 0; i < medicalFitnessList.length; i++) {
//         if (medicalFitnessList[i].document != null) {
//           dioFileList.add({
//             'fieldName': 'medicalFitnessFiles',
//             'filePath': medicalFitnessList[i].document!.path,
//             'fileName': medicalFitnessList[i].document!.path.split('/').last,
//           });
//         }
//       }
//
//       // Add drug & alcohol test file
//       if (drugAndAlcoholTestDocument != null) {
//         dioFileList.add({
//           'fieldName': 'drugAlcoholTestFiles',
//           'filePath': drugAndAlcoholTestDocument!.path,
//           'fileName': drugAndAlcoholTestDocument!.path.split('/').last,
//         });
//       }
//
//       // Add vaccination certificate file
//       if (vaccinationCertificateDocument != null) {
//         dioFileList.add({
//           'fieldName': 'vaccinationCertificatesFiles',
//           'filePath': vaccinationCertificateDocument!.path,
//           'fileName': vaccinationCertificateDocument!.path.split('/').last,
//         });
//       }
//
//       // Call the Dio-based multipart function from globalComponent
//       final response = await multipartDocumentsDio(
//         context,
//         createOrUpdateMedicalDocuments,
//         dioFieldData,
//         dioFileList,
//         true, // showLoading
//       );
//
//       if (response['statusCode'] == 200 || response['statusCode'] == 201) {
//         // Success - refresh the data
//         String userId = NetworkHelper.loggedInUserId.isNotEmpty
//             ? NetworkHelper.loggedInUserId
//             : '';
//         if (userId.isNotEmpty) {
//           await fetchMedicalDocuments(userId, context);
//         }
//         ShowToast("Success","Medical Document found successfully");
//         return true;
//       } else {
//         hasError = true;
//         // errorMessage = response['message'] ?? 'Failed to save medical documents';
//         ShowToast("Error",'Failed to save medical documents');
//         return false;
//       }
//     } catch (e) {
//       hasError = true;
//       print(e);
//       errorMessage = 'Network error: ${e.toString()}';
//       ShowToast("Error","Network error");
//       return false;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
//
// class MedicalFitness {
//   String documentType;
//   String certificateNo;
//   String issuingCountry;
//   String issuingAuthority;
//   String issueDate;
//   String expiryDate;
//   bool neverExpire;
//   File? document;
//
//   MedicalFitness({
//     required this.documentType,
//     required this.certificateNo,
//     required this.issuingCountry,
//     required this.issuingAuthority,
//     required this.issueDate,
//     required this.expiryDate,
//     required this.neverExpire,
//     this.document,
//   });
// }



import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import '../../../../Utils/helper.dart';
import '../../../../models/medical_document_model.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../custom-component/globalComponent.dart';

class MedicalDocumentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final medicalFitnessFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode autovalidateModeMedical = AutovalidateMode.disabled;

  // Loading states
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  MedicalDocument? medicalDocumentData; // Optional, can be null

  // List<String> countries = [];
  List<String> medicalFitnessDocumentTypes = ["PEME", "HMO", "Standard Medical Exam","Other"];
  List<String> drugAndAlcoholTestDocumentTypes = ["Standard", "Random", "Other"];
  List<String> vaccinationCertificateDocumentTypes = [
    "COVID 19",
    "Yellow Fever",
    "Tetanus",
    "Diphtheria",
    "Hepatitis A",
    "Hepatitis B",
    "Cholera",
    "Other"
  ];

  // Reset all form data
  void resetForm() {
    // Reset error states
    hasError = false;
    errorMessage = '';

    // Reset validation modes
    autovalidateMode = AutovalidateMode.disabled;
    autovalidateModeMedical = AutovalidateMode.disabled;

    // Clear data
    medicalDocumentData = null;

    // Clear lists
    medicalFitnessList.clear();

    // Clear Drug & Alcohol Test fields
    drugAndAlcoholTestDocumentType = null;
    drugAndAlcoholTestCertificateNoController.clear();
    drugAndAlcoholTestIssuingCountry = null;
    drugAndAlcoholTestIssuingAuthorityController.clear();
    drugAndAlcoholTestIssueDateController.clear();
    drugAndAlcoholTestExpiryDateController.clear();
    drugAndAlcoholTestNeverExpire = false;
    drugAndAlcoholTestDocument = null;
    drugAndAlcoholTestDocumentPath = null;
    drugAndAlcoholTestDocumentOriginalName = null;

    // Clear Vaccination Certificate fields
    vaccinationCertificateDocumentType = null;
    vaccinationCertificateCertificateNoController.clear();
    vaccinationCertificateIssuingCountry = null;
    vaccinationCertificateIssuingAuthorityController.clear();
    vaccinationCertificateIssueDateController.clear();
    vaccinationCertificateExpiryDateController.clear();
    vaccinationCertificateNeverExpire = false;
    vaccinationCertificateDocument = null;
    vaccinationCertificateDocumentPath = null;
    vaccinationCertificateDocumentOriginalName = null;

    // Clear medical fitness form fields
    medicalFitnessDocumentType = null;
    medicalFitnessCertificateNoController.clear();
    medicalFitnessIssuingCountry = null;
    medicalFitnessIssuingAuthorityController.clear();
    medicalFitnessIssueDateController.clear();
    medicalFitnessExpiryDateController.clear();
    medicalFitnessNeverExpire = false;
    medicalFitnessDocument = null;
    showAddSection_medicalFitness = false;
    medicalFitness_Edit_Index = null;
    medicalFitness_IsEdit = false;

    notifyListeners();
  }

  // API call to fetch medical document data
  Future<void> fetchMedicalDocuments(String userId, BuildContext context) async {
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
        '$getMedicalDocumentsByUserId$userId',
        false, // showLoading - let the provider handle loading
        context,
            () {},
      );

      print('Medical Documents Response: $response');

      if (response.isNotEmpty) {
        final medicalDocumentResponse = MedicalDocumentResponse.fromJson(response);
        medicalDocumentData = medicalDocumentResponse.data; // Can be null
        _populateFormData();
        ShowToast("Success", "Medical documents fetched successfully");
      } else {
        hasError = true;
        ShowToast("Error", "Failed to load medical documents");
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

  bool hasExistingVaccinationCertificateDocument() {
    return medicalDocumentData != null &&
        medicalDocumentData!.vaccinationCertificates != null &&
        medicalDocumentData!.vaccinationCertificates!.isNotEmpty &&
        medicalDocumentData!
                .vaccinationCertificates!.first.documentPath !=
            null &&
        medicalDocumentData!
            .vaccinationCertificates!.first.documentPath!.isNotEmpty;
  }

  void removeExistingVaccinationCertificateAttachment() {
    if (medicalDocumentData != null &&
        medicalDocumentData!.vaccinationCertificates != null &&
        medicalDocumentData!.vaccinationCertificates!.isNotEmpty) {
      medicalDocumentData!.vaccinationCertificates!.first.documentPath =
          '';
      medicalDocumentData!.vaccinationCertificates!.first
          .documentOriginalName = '';
      vaccinationCertificateDocumentPath = null;
      vaccinationCertificateDocumentOriginalName = null;
      notifyListeners();
    }
  }

  bool hasExistingDrugAndAlcoholTestDocument() {
    return medicalDocumentData != null &&
        medicalDocumentData!.drugAlcoholTest != null &&
        medicalDocumentData!.drugAlcoholTest!.isNotEmpty &&
        medicalDocumentData!.drugAlcoholTest!.first.documentPath != null &&
        medicalDocumentData!.drugAlcoholTest!.first.documentPath!.isNotEmpty;
  }

  void removeExistingDrugAndAlcoholTestAttachment() {
    if (medicalDocumentData != null &&
        medicalDocumentData!.drugAlcoholTest != null &&
        medicalDocumentData!.drugAlcoholTest!.isNotEmpty) {
      medicalDocumentData!.drugAlcoholTest!.first.documentPath = '';
      medicalDocumentData!.drugAlcoholTest!.first.documentOriginalName = '';
      drugAndAlcoholTestDocumentPath = null;
      drugAndAlcoholTestDocumentOriginalName = null;
      notifyListeners();
    }
  }

  // Populate form data from API response
  void _populateFormData() {
    if (medicalDocumentData == null) return;

    // Populate Medical Fitness data
    if (medicalDocumentData!.medicalFitness != null &&
        medicalDocumentData!.medicalFitness!.isNotEmpty) {
      for (var fitness in medicalDocumentData!.medicalFitness!) {
        MedicalFitness localFitness = MedicalFitness(
          documentType: fitness.documentType ?? '',
          certificateNo: fitness.certificateNo ?? '',
          issuingCountry: fitness.issuingCountry ?? '',
          issuingAuthority: fitness.issuingAuthority ?? '',
          issueDate: fitness.issuingDate ?? '',
          expiryDate: fitness.expDate ?? '',
          neverExpire: fitness.neverExpire ?? false,
          document: null, // We don't have the actual file, just the path
          documentPath: fitness.documentPath,
          documentOriginalName: fitness.documentOriginalName,
        );
        medicalFitnessList.add(localFitness);
      }
    }

    // Populate Drug & Alcohol Test data
    if (medicalDocumentData!.drugAlcoholTest != null &&
        medicalDocumentData!.drugAlcoholTest!.isNotEmpty) {
      var test = medicalDocumentData!.drugAlcoholTest!.first; // Take the first entry
      drugAndAlcoholTestDocumentType = test.documentType ?? '';
      drugAndAlcoholTestCertificateNoController.text = test.certificateNo ?? '';
      drugAndAlcoholTestIssuingCountry = test.issuingCountry ?? '';
      drugAndAlcoholTestIssuingAuthorityController.text =
          test.issuingAuthority ?? '';
      drugAndAlcoholTestIssueDateController.text = test.issuingDate ?? '';
      drugAndAlcoholTestExpiryDateController.text = test.expDate ?? '';
      drugAndAlcoholTestDocumentPath = test.documentPath;
      drugAndAlcoholTestDocumentOriginalName = test.documentOriginalName;
    }

    // Populate Vaccination Certificate data
    if (medicalDocumentData!.vaccinationCertificates != null &&
        medicalDocumentData!.vaccinationCertificates!.isNotEmpty) {
      var cert = medicalDocumentData!
          .vaccinationCertificates!.first; // Take the first entry
      vaccinationCertificateDocumentType = cert.documentType ?? '';
      vaccinationCertificateIssuingCountry = cert.issuingCountry ?? '';
      vaccinationCertificateCertificateNoController.text =
          cert.certificateNo ?? '';
      vaccinationCertificateIssuingAuthorityController.text =
          cert.issuingAuthority ?? '';
      vaccinationCertificateIssueDateController.text = cert.issuingDate ?? '';
      vaccinationCertificateExpiryDateController.text = cert.expDate ?? '';
      vaccinationCertificateNeverExpire = cert.neverExpire ?? false;
      vaccinationCertificateDocumentPath = cert.documentPath;
      vaccinationCertificateDocumentOriginalName = cert.documentOriginalName;
    }
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
  final TextEditingController vaccinationCertificateCertificateNoController = TextEditingController();
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
  final FocusNode vaccinationCertificateCertificateNoFocusNode = FocusNode();
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
  String? medicalFitnessDocumentPath_temp;
  String? medicalFitnessDocumentOriginalName_temp;

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
  bool? drugAndAlcoholTestNeverExpire;
  String? drugAndAlcoholTestDocumentPath;
  String? drugAndAlcoholTestDocumentOriginalName;

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

  void setDrugAndAlcoholTestNeverExpire(bool value) {
    drugAndAlcoholTestNeverExpire = value;
    notifyListeners();
  }

  // Vaccination Certificates
  bool? vaccinationCertificateNeverExpire=false; // Made optional
  String? vaccinationCertificateDocumentType;
  String? vaccinationCertificateIssuingCountry;
  String? vaccinationCertificateDocumentPath;
  String? vaccinationCertificateDocumentOriginalName;

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
    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.first.path!);
      switch (type) {
        case 'medical_fitness':
          medicalFitnessDocument = file;
          medicalFitnessDocumentPath_temp = null;
          medicalFitnessDocumentOriginalName_temp = null;
          break;
        case 'drug_alcohol_test':
          drugAndAlcoholTestDocument = file;
          drugAndAlcoholTestDocumentPath = null;
          drugAndAlcoholTestDocumentOriginalName = null;
          break;
        case 'vaccination_certificate':
          vaccinationCertificateDocument = file;
          vaccinationCertificateDocumentPath = null;
          vaccinationCertificateDocumentOriginalName = null;
          break;
      }
      notifyListeners();
    }
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File? file;

      File imageFile = File(pickedFile.path);
      int originalLength = await imageFile.length();

      if (originalLength <= 20971520) {
        XFile? compressedFile = await compressFile(imageFile);
        if (compressedFile != null) {
          file = File(compressedFile.path);
          notifyListeners();
        }
      } else {
        showToast('File size must be less than 20 MB');
      }
      if (file != null) {
        switch (type) {
          case 'medical_fitness':
            medicalFitnessDocument = file;
            medicalFitnessDocumentPath_temp = null;
            medicalFitnessDocumentOriginalName_temp = null;
            break;
          case 'drug_alcohol_test':
            drugAndAlcoholTestDocument = file;
            drugAndAlcoholTestDocumentPath = null;
            drugAndAlcoholTestDocumentOriginalName = null;
            break;
          case 'vaccination_certificate':
            vaccinationCertificateDocument = file;
            vaccinationCertificateDocumentPath = null;
            vaccinationCertificateDocumentOriginalName = null;
            break;
        }
        notifyListeners();
      }
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

  bool hasExistingMedicalFitnessDocument(int? index) {
    if (index != null &&
        medicalDocumentData != null &&
        medicalDocumentData!.medicalFitness != null &&
        index < medicalDocumentData!.medicalFitness!.length) {
      return medicalDocumentData!.medicalFitness![index].documentPath != null &&
          medicalDocumentData!.medicalFitness![index].documentPath!.isNotEmpty;
    }
    return false;
  }

  void removeExistingMedicalFitnessAttachment(int index) {
    if (medicalDocumentData != null &&
        medicalDocumentData!.medicalFitness != null &&
        index < medicalDocumentData!.medicalFitness!.length) {
      medicalDocumentData!.medicalFitness![index].documentPath = '';
      medicalDocumentData!.medicalFitness![index].documentOriginalName = '';
      notifyListeners();
    }
  }

  // API call to create or update medical documents
  Future<bool> createOrUpdateMedicalDocumentsAPI(BuildContext context) async {
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      // Prepare the data object
      Map<String, dynamic> medicalDocument = {
        'userId': NetworkHelper.loggedInUserId,
        'medicalFitness': medicalFitnessList.map((fitness) => {
              'documentType': fitness.documentType ?? '',
              'certificateNo': fitness.certificateNo ?? '',
              'issuingCountry': fitness.issuingCountry ?? '',
              'issuingAuthority': fitness.issuingAuthority ?? '',
              'issuingDate': fitness.issueDate ?? '',
              'expDate': fitness.expiryDate ?? '',
              'neverExpiry': fitness.neverExpire ?? false,
              'documentPath': fitness.document==null?fitness.documentPath:null,
              'documentOriginalName': fitness.document==null?fitness.documentOriginalName:fitness.document!.path.split('/').last,
            }).toList(),
        'drugAlcoholTest': [
          {
            'documentType': drugAndAlcoholTestDocumentType ?? '',
            'certificateNo': drugAndAlcoholTestCertificateNoController.text,
            'issuingCountry': drugAndAlcoholTestIssuingCountry ?? '',
            'issuingAuthority':
                drugAndAlcoholTestIssuingAuthorityController.text,
            'issuingDate': drugAndAlcoholTestIssueDateController.text,
            'expDate': drugAndAlcoholTestExpiryDateController.text.isEmpty
                ? null
                : drugAndAlcoholTestExpiryDateController.text,
            'neverExpiry': drugAndAlcoholTestNeverExpire ?? false,
            'documentPath': drugAndAlcoholTestDocument==null?drugAndAlcoholTestDocumentPath:null,
            'documentOriginalName': drugAndAlcoholTestDocument==null?drugAndAlcoholTestDocumentOriginalName:drugAndAlcoholTestDocument!.path.split('/').last,
          }
        ],
        'vaccinationCertificates': [
          {
            'documentType': vaccinationCertificateDocumentType ?? '',
            'certificateNo':
                vaccinationCertificateCertificateNoController.text,
            'issuingCountry': vaccinationCertificateIssuingCountry ?? '',
            'issuingAuthority':
                vaccinationCertificateIssuingAuthorityController.text,
            'issuingDate': vaccinationCertificateIssueDateController.text,
            'expDate':
                vaccinationCertificateExpiryDateController.text.isEmpty
                    ? null
                    : vaccinationCertificateExpiryDateController.text,
            'neverExpiry': vaccinationCertificateNeverExpire ?? false,
            'documentPath': vaccinationCertificateDocument==null?vaccinationCertificateDocumentPath:null,
            'documentOriginalName':
            vaccinationCertificateDocument==null?vaccinationCertificateDocumentOriginalName:vaccinationCertificateDocument!.path.split('/').last,
          }
        ],
      };

      // Convert data to the format expected by Dio function
      Map<String, dynamic> dioFieldData = {
        'data': jsonEncode(medicalDocument), // API expects a single object
      };



      // Convert fileList to the format expected by Dio function
      List<Map<String, dynamic>> dioFileList = [];

      // Add medical fitness files
      for (int i = 0; i < medicalFitnessList.length; i++) {
        if (medicalFitnessList[i].document != null) {
          dioFileList.add({
            'fieldName': 'medicalFitnessFiles[${i}]',
            'filePath': medicalFitnessList[i].document!.path,
            'fileName': medicalFitnessList[i].document!.path.split('/').last,
          });
        }
      }

      // Add drug & alcohol test file
      if (drugAndAlcoholTestDocument != null) {
        dioFileList.add({
          'fieldName': 'drugAlcoholTestFiles',
          'filePath': drugAndAlcoholTestDocument!.path,
          'fileName': drugAndAlcoholTestDocument!.path.split('/').last,
        });
      }

      // Add vaccination certificate file
      if (vaccinationCertificateDocument != null) {
        dioFileList.add({
          'fieldName': 'vaccinationCertificatesFiles',
          'filePath': vaccinationCertificateDocument!.path,
          'fileName': vaccinationCertificateDocument!.path.split('/').last,
        });
      }

      // Call the Dio-based multipart function from globalComponent
      final response = await multipartDocumentsDio(
        context,
        createOrUpdateMedicalDocuments,
        dioFieldData,
        dioFileList,
        true, // showLoading
      );

      print("Medical Document API Response: $response");
      print("Medical Document Field Data: $dioFieldData");
      print("Medical Document File List: $dioFileList");
      
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Success - refresh the data
        // String userId =
        // NetworkHelper.loggedInUserId.isNotEmpty ? NetworkHelper.loggedInUserId : '';
        // if (userId.isNotEmpty) {
        //   await fetchMedicalDocuments(userId, context);
        // }
        resetForm();
        ShowToast("Success", "Medical documents saved successfully");
        return true;
      } else {
        hasError = true;
        ShowToast("Error", response['message'] ?? 'Failed to save medical documents');
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
    // Dispose Focus Nodes
    medicalFitnessCertificateNoFocusNode.dispose();
    medicalFitnessIssuingAuthorityFocusNode.dispose();
    medicalFitnessIssueDateFocusNode.dispose();
    medicalFitnessExpiryDateFocusNode.dispose();
    drugAndAlcoholTestCertificateNoFocusNode.dispose();
    drugAndAlcoholTestIssuingAuthorityFocusNode.dispose();
    drugAndAlcoholTestIssueDateFocusNode.dispose();
    drugAndAlcoholTestExpiryDateFocusNode.dispose();
    vaccinationCertificateCertificateNoFocusNode.dispose();
    vaccinationCertificateIssuingAuthorityFocusNode.dispose();
    vaccinationCertificateIssueDateFocusNode.dispose();
    vaccinationCertificateExpiryDateFocusNode.dispose();
    
    // Dispose Text Controllers
    medicalFitnessCertificateNoController.dispose();
    medicalFitnessIssuingAuthorityController.dispose();
    medicalFitnessIssueDateController.dispose();
    medicalFitnessExpiryDateController.dispose();
    drugAndAlcoholTestCertificateNoController.dispose();
    drugAndAlcoholTestIssuingAuthorityController.dispose();
    drugAndAlcoholTestIssueDateController.dispose();
    drugAndAlcoholTestExpiryDateController.dispose();
    vaccinationCertificateCertificateNoController.dispose();
    vaccinationCertificateIssuingAuthorityController.dispose();
    vaccinationCertificateIssueDateController.dispose();
    vaccinationCertificateExpiryDateController.dispose();
    
    super.dispose();
  }
}

class MedicalFitness {
  String? documentType; // Made optional
  String? certificateNo; // Made optional
  String? issuingCountry; // Made optional
  String? issuingAuthority; // Made optional
  String? issueDate; // Made optional
  String? expiryDate; // Made optional
  bool? neverExpire; // Made optional
  File? document; // Already optional
  String? documentPath;
  String? documentOriginalName;

  MedicalFitness({
    this.documentType = '', // Default to empty string
    this.certificateNo = '', // Default to empty string
    this.issuingCountry = '', // Default to empty string
    this.issuingAuthority = '', // Default to empty string
    this.issueDate = '', // Default to empty string
    this.expiryDate, // Optional
    this.neverExpire = false, // Default to false
    this.document,
    this.documentPath,
    this.documentOriginalName,
  });
}