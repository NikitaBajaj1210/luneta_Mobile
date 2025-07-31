import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import '../../../../Utils/helper.dart';
import '../../../../models/travel_document_model.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import 'package:luneta/custom-component/globalComponent.dart';
import 'package:luneta/network/network_services.dart';

class TravelDocumentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  List<String> countries = [];
  
  // Loading states
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  TravelDocument? travelDocumentData;

  // Track existing documents
  bool hasExistingPassportDocument = false;
  bool hasExistingSeamanDocument = false;
  bool hasExistingSeafarerVisaDocument = false;
  bool hasExistingVisaDocument = false;
  bool hasExistingResidencePermitDocument = false;

  TravelDocumentProvider() {
    countries = CountryService().getAll().map((country) => country.name).toList();
  }

  // API call to fetch travel document data
  Future<void> fetchTravelDocuments(String userId, BuildContext context) async {
    // If no userId provided, try to get from NetworkHelper
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
        '$getTravelDocumentsByUserId$userId',
        false, // showLoading - let the provider handle loading
        context,
        () {}, // notify callback
      );

      print('Travel Documents Response: $response');

      if (response.isNotEmpty) {
        final travelDocumentResponse = TravelDocumentResponse.fromJson(response);
        
        if (travelDocumentResponse.data.isNotEmpty) {
          travelDocumentData = travelDocumentResponse.data.first;
          _populateFormData();
        }
        ShowToast("Success", travelDocumentResponse.message ?? "Fetch Data successfully");
      } else {
        hasError = true;
        ShowToast("Error", "Failed to load travel documents");
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

  // API call to create or update travel document data
  Future<bool> createOrUpdateTravelDocumentsAPI(BuildContext context) async {
    // isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      // Prepare the data object
      Map<String, dynamic> data = {
        'seafarerRegNo': seafarerRegistrationNoController.text,
        'passportNo': passportNoController.text,
        'passportCountry': passportCountry ?? '',
        'passportIssueDate': passportIssueDateController.text,
        'passportExpDate': passportExpiryDateController.text,
        'passportDocumentOriginalName': passportDocument?.path.split('/').last ?? getDocumentOriginalName('passport'),
        'seamansBookNo': seamanBookNoController.text,
        'seamansBookIssuingCountry': seamanIssuingCountry ?? '',
        'seamansBookIssuingAuthority': seamanIssuingAuthorityController.text,
        'seamansBookIssueDate': seamanIssueDateController.text,
        'seamansBookExpDate': seamanExpiryDateController.text,
        'seamansBookNeverExpire': seamanNeverExpire,
        'seamansBookNationality': seamanNationality ?? '',
        'seamansBookDocumentOriginalName': seamanDocument?.path.split('/').last ?? getDocumentOriginalName('seaman'),
        'validSeafarerVisa': validSeafarerVisa,
        'seafarerVisaIssuingCountry': seafarerVisaIssuingCountry ?? '',
        'seafarerVisaNo': seafarerVisaNoController.text,
        'seafarerVisaIssuingDate': seafarerVisaIssueDateController.text,
        'seafarerVisaExpDate': seafarerVisaExpiryDateController.text,
        'seafarerVisaDocumentOriginalName': seafarerVisaDocument?.path.split('/').last ?? getDocumentOriginalName('seafarer_visa'),
        'visaIssuingCountry': visaIssuingCountry ?? '',
        'visaNo': visaNoController.text,
        'visaIssuingDate': visaIssueDateController.text,
        'visaExpDate': visaExpiryDateController.text,
        'visaDocumentOriginalName': visaDocument?.path.split('/').last ?? getDocumentOriginalName('visa'),
        'residencePermitIssuingCountry': residencePermitIssuingCountry ?? '',
        'residencePermitNo': residencePermitNoController.text,
        'residencePermitIssuingDate': residencePermitIssueDateController.text,
        'residencePermitExpDate': residencePermitExpiryDateController.text,
        'residencePermitDocumentOriginalName': residencePermitDocument?.path.split('/').last ?? getDocumentOriginalName('residence_permit'),
        'userId': NetworkHelper.loggedInUserId,
        // 'id': travelDocumentData?.id, // Use existing ID if updating
      };

      // If no new files are uploaded but we have existing documents, 
      // we need to include the existing document paths in the data
      if (passportDocument == null && travelDocumentData?.passportDocumentPath.isNotEmpty == true) {
        data['passportDocumentPath'] = travelDocumentData!.passportDocumentPath;
      }
      if (seamanDocument == null && travelDocumentData?.seamansBookDocumentPath.isNotEmpty == true) {
        data['seamansBookDocumentPath'] = travelDocumentData!.seamansBookDocumentPath;
      }
      if (seafarerVisaDocument == null && travelDocumentData?.seafarerVisaDocumentPath.isNotEmpty == true) {
        data['seafarerVisaDocumentPath'] = travelDocumentData!.seafarerVisaDocumentPath;
      }
      if (visaDocument == null && travelDocumentData?.visaDocumentPath.isNotEmpty == true) {
        data['visaDocumentPath'] = travelDocumentData!.visaDocumentPath;
      }
      if (residencePermitDocument == null && travelDocumentData?.residencePermitDocumentPath.isNotEmpty == true) {
        data['residencePermitDocumentPath'] = travelDocumentData!.residencePermitDocumentPath;
      }



      // Call the Dio-based multipart function from globalComponent
      
      // Convert fieldData to the format expected by Dio function
      Map<String, dynamic> dioFieldData = {
        'data': jsonEncode([data]), // API expects an array
      };
      
      // Convert fileList to the format expected by Dio function
      List<Map<String, dynamic>> dioFileList = [];
      
      if (passportDocument != null) {
        dioFileList.add({
          'fieldName': 'passportDocument',
          'filePath': passportDocument!.path,
          'fileName': passportDocument!.path.split('/').last,
        });
      }
      
      if (seamanDocument != null) {
        dioFileList.add({
          'fieldName': 'seamansBookDocument',
          'filePath': seamanDocument!.path,
          'fileName': seamanDocument!.path.split('/').last,
        });
      }
      
      if (seafarerVisaDocument != null) {
        dioFileList.add({
          'fieldName': 'seafarerVisaDocument',
          'filePath': seafarerVisaDocument!.path,
          'fileName': seafarerVisaDocument!.path.split('/').last,
        });
      }
      
      if (visaDocument != null) {
        dioFileList.add({
          'fieldName': 'visaDocument',
          'filePath': visaDocument!.path,
          'fileName': visaDocument!.path.split('/').last,
        });
      }
      
      if (residencePermitDocument != null) {
        dioFileList.add({
          'fieldName': 'residencePermitDocument',
          'filePath': residencePermitDocument!.path,
          'fileName': residencePermitDocument!.path.split('/').last,
        });
      }
      
      final response = await multipartDocumentsDio(
        context,
        createOrUpdateTravelDocuments,
        dioFieldData,
        dioFileList,
        true, // showLoading
      );

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Success - refresh the data
        String userId = NetworkHelper.loggedInUserId.isNotEmpty 
            ? NetworkHelper.loggedInUserId 
            : '';
        if (userId.isNotEmpty) {
          await fetchTravelDocuments(userId,context);
        }
        return true;
      } else {
        hasError = true;
        errorMessage = response['message'] ?? 'Failed to save travel documents';
        return false;
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Network error: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Populate form data from API response
  void _populateFormData() {
    if (travelDocumentData == null) return;

    // Seafarer Registration No
    seafarerRegistrationNoController.text = travelDocumentData!.seafarerRegNo;
    
    // Passport data
    passportNoController.text = travelDocumentData!.passportNo;
    passportCountry = travelDocumentData!.passportCountry;
    passportIssueDateController.text = travelDocumentData!.passportIssueDate;
    passportExpiryDateController.text = travelDocumentData!.passportExpDate;
    
    // Seaman's Book data
    seamanBookNoController.text = travelDocumentData!.seamansBookNo;
    seamanIssuingCountry = travelDocumentData!.seamansBookIssuingCountry;
    seamanIssuingAuthorityController.text = travelDocumentData!.seamansBookIssuingAuthority;
    seamanIssueDateController.text = travelDocumentData!.seamansBookIssueDate;
    seamanExpiryDateController.text = travelDocumentData!.seamansBookExpDate;
    seamanNeverExpire = travelDocumentData!.seamansBookNeverExpire;
    seamanNationality = travelDocumentData!.seamansBookNationality;
    
    // Valid Seafarer Visa data
    validSeafarerVisa = travelDocumentData!.validSeafarerVisa;
    seafarerVisaIssuingCountry = travelDocumentData!.seafarerVisaIssuingCountry;
    seafarerVisaNoController.text = travelDocumentData!.seafarerVisaNo;
    seafarerVisaIssueDateController.text = travelDocumentData!.seafarerVisaIssuingDate;
    seafarerVisaExpiryDateController.text = travelDocumentData!.seafarerVisaExpDate;
    
    // Visa data
    visaIssuingCountry = travelDocumentData!.visaIssuingCountry;
    visaNoController.text = travelDocumentData!.visaNo;
    visaIssueDateController.text = travelDocumentData!.visaIssuingDate;
    visaExpiryDateController.text = travelDocumentData!.visaExpDate;
    
    // Residence Permit data
    _residencePermitIssuingCountry = travelDocumentData!.residencePermitIssuingCountry;
    residencePermitNoController.text = travelDocumentData!.residencePermitNo;
    residencePermitIssueDateController.text = travelDocumentData!.residencePermitIssuingDate;
    residencePermitExpiryDateController.text = travelDocumentData!.residencePermitExpDate;

    // Set existing document flags
    hasExistingPassportDocument = travelDocumentData!.passportDocumentPath.isNotEmpty;
    hasExistingSeamanDocument = travelDocumentData!.seamansBookDocumentPath.isNotEmpty;
    hasExistingSeafarerVisaDocument = travelDocumentData!.seafarerVisaDocumentPath.isNotEmpty;
    hasExistingVisaDocument = travelDocumentData!.visaDocumentPath.isNotEmpty;
    hasExistingResidencePermitDocument = travelDocumentData!.residencePermitDocumentPath.isNotEmpty;
  }

  // Get document original name for API
  String getDocumentOriginalName(String documentType) {
    switch (documentType) {
      case 'passport':
        return travelDocumentData?.passportDocumentOriginalName ?? '';
      case 'seaman':
        return travelDocumentData?.seamansBookDocumentOriginalName ?? '';
      case 'seafarer_visa':
        return travelDocumentData?.seafarerVisaDocumentOriginalName ?? '';
      case 'visa':
        return travelDocumentData?.visaDocumentOriginalName ?? '';
      case 'residence_permit':
        return travelDocumentData?.residencePermitDocumentOriginalName ?? '';
      default:
        return '';
    }
  }

  // Controllers
  final TextEditingController seafarerRegistrationNoController = TextEditingController();
  final TextEditingController passportNoController = TextEditingController();
  final TextEditingController passportIssueDateController = TextEditingController();
  final TextEditingController passportExpiryDateController = TextEditingController();
  File? passportDocument;
  File? seamanDocument;
  File? seafarerVisaDocument;
  File? visaDocument;
  File? residencePermitDocument;

  final TextEditingController passportDocumentController = TextEditingController();
  final TextEditingController seamanBookNoController = TextEditingController();
  final TextEditingController seamanIssuingAuthorityController = TextEditingController();
  final TextEditingController seamanIssueDateController = TextEditingController();
  final TextEditingController seamanExpiryDateController = TextEditingController();
  final TextEditingController seamanDocumentController = TextEditingController();
  final TextEditingController seafarerVisaNoController = TextEditingController();
  final TextEditingController seafarerVisaIssueDateController = TextEditingController();
  final TextEditingController seafarerVisaExpiryDateController = TextEditingController();
  final TextEditingController seafarerVisaDocumentController = TextEditingController();
  final TextEditingController visaNoController = TextEditingController();
  final TextEditingController visaIssueDateController = TextEditingController();
  final TextEditingController visaExpiryDateController = TextEditingController();
  final TextEditingController visaDocumentController = TextEditingController();
  final TextEditingController residencePermitNoController = TextEditingController();
  final TextEditingController residencePermitIssueDateController = TextEditingController();
  final TextEditingController residencePermitExpiryDateController = TextEditingController();
  final TextEditingController residencePermitDocumentController = TextEditingController();

  // Focus Nodes
  final FocusNode seafarerRegistrationNoFocusNode = FocusNode();
  final FocusNode passportNoFocusNode = FocusNode();
  final FocusNode passportIssueDateFocusNode = FocusNode();
  final FocusNode passportExpiryDateFocusNode = FocusNode();
  final FocusNode passportDocumentFocusNode = FocusNode();
  final FocusNode seamanBookNoFocusNode = FocusNode();
  final FocusNode seamanIssuingAuthorityFocusNode = FocusNode();
  final FocusNode seamanIssueDateFocusNode = FocusNode();
  final FocusNode seamanExpiryDateFocusNode = FocusNode();
  final FocusNode seamanDocumentFocusNode = FocusNode();
  final FocusNode seafarerVisaNoFocusNode = FocusNode();
  final FocusNode seafarerVisaIssueDateFocusNode = FocusNode();
  final FocusNode seafarerVisaExpiryDateFocusNode = FocusNode();
  final FocusNode seafarerVisaDocumentFocusNode = FocusNode();
  final FocusNode visaNoFocusNode = FocusNode();
  final FocusNode visaIssueDateFocusNode = FocusNode();
  final FocusNode visaExpiryDateFocusNode = FocusNode();
  final FocusNode visaDocumentFocusNode = FocusNode();
  final FocusNode residencePermitNoFocusNode = FocusNode();
  final FocusNode residencePermitIssueDateFocusNode = FocusNode();
  final FocusNode residencePermitExpiryDateFocusNode = FocusNode();
  final FocusNode residencePermitDocumentFocusNode = FocusNode();

  // Seaman's Book
  bool seamanNeverExpire = false;
  bool validSeafarerVisa = false;

  void setSeamanNeverExpire(bool value) {
    seamanNeverExpire = value;
    notifyListeners();
  }

  void setValidSeafarerVisa(bool value) {
    validSeafarerVisa = value;
    notifyListeners();
  }

  void setPassportIssueDate(DateTime date) {
    passportIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setPassportExpiryDate(DateTime date) {
    passportExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setSeamanIssueDate(DateTime date) {
    seamanIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setSeamanExpiryDate(DateTime date) {
    seamanExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setSeafarerVisaIssueDate(DateTime date) {
    seafarerVisaIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setSeafarerVisaExpiryDate(DateTime date) {
    seafarerVisaExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setVisaIssueDate(DateTime date) {
    visaIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setVisaExpiryDate(DateTime date) {
    visaExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  void setResidencePermitIssueDate(DateTime date) {
    residencePermitIssueDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  String? passportCountry;
  String? seamanIssuingCountry;
  String? seamanNationality;
  String? seafarerVisaIssuingCountry;
  String? visaIssuingCountry;

  String? _residencePermitIssuingCountry;
  String? get residencePermitIssuingCountry=>_residencePermitIssuingCountry;

  void setPassportCountry(String country) {
    passportCountry = country;
    notifyListeners();
  }

  void setSeamanIssuingCountry(String country) {
    seamanIssuingCountry = country;
    notifyListeners();
  }

  void setSeamanNationality(String country) {
    seamanNationality = country;
    notifyListeners();
  }

  void setSeafarerVisaIssuingCountry(String country) {
    seafarerVisaIssuingCountry = country;
    notifyListeners();
  }

  void setVisaIssuingCountry(String country) {
    visaIssuingCountry = country;
    notifyListeners();
  }

  void setResidencePermitIssuingCountry(String country) {
    _residencePermitIssuingCountry = country;
    notifyListeners();
  }

  void setResidencePermitExpiryDate(DateTime date) {
    residencePermitExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  String? validateManual() {
    if (seafarerRegistrationNoController.text.isEmpty) {
      return 'Seafarer\'s Registration No. is required';
    }
    if (passportNoController.text.isEmpty) {
      return 'Passport No. is required';
    }
    if (passportIssueDateController.text.isEmpty) {
      return 'Passport Issue Date is required';
    }
    if (passportExpiryDateController.text.isEmpty) {
      return 'Passport Expiry Date is required';
    }
    // Only validate passport document if no existing document and no new document
    if (passportDocument == null && !hasExistingPassportDocument) {
      return 'Passport Document is required';
    }
    if (seamanBookNoController.text.isEmpty) {
      return 'Seaman\'s Book No. is required';
    }
    if (seamanIssuingAuthorityController.text.isEmpty) {
      return 'Seaman\'s Book Issuing Authority is required';
    }
    if (seamanIssueDateController.text.isEmpty) {
      return 'Seaman\'s Book Issue Date is required';
    }
    if (seamanExpiryDateController.text.isEmpty && !seamanNeverExpire) {
      return 'Seaman\'s Book Expiry Date is required';
    }
    // Only validate seaman document if no existing document and no new document
    if (seamanDocument == null && !hasExistingSeamanDocument) {
      return 'Seaman\'s Book Document is required';
    }
    if (validSeafarerVisa) {
      if (seafarerVisaNoController.text.isEmpty) {
        return 'Seafarer\'s Visa No. is required';
      }
      if (seafarerVisaIssueDateController.text.isEmpty) {
        return 'Seafarer\'s Visa Issue Date is required';
      }
      if (seafarerVisaExpiryDateController.text.isEmpty) {
        return 'Seafarer\'s Visa Expiry Date is required';
      }
      // Only validate seafarer visa document if no existing document and no new document
      if (seafarerVisaDocument == null && !hasExistingSeafarerVisaDocument) {
        return 'Seafarer\'s Visa Document is required';
      }
    }
    // Only validate visa document if no existing document and no new document
    if (visaDocument == null && !hasExistingVisaDocument) {
      return 'Visa Document is required';
    }
    // Only validate residence permit document if no existing document and no new document
    if (residencePermitDocument == null && !hasExistingResidencePermitDocument) {
      return 'Residence Permit Document is required';
    }
    return null;
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
        case 'passport':
          passportDocument = file;
          hasExistingPassportDocument = true;
          break;
        case 'seaman':
          seamanDocument = file;
          hasExistingSeamanDocument = true;
          break;
        case 'seafarer_visa':
          seafarerVisaDocument = file;
          hasExistingSeafarerVisaDocument = true;
          break;
        case 'visa':
          visaDocument = file;
          hasExistingVisaDocument = true;
          break;
        case 'residence_permit':
          residencePermitDocument = file;
          hasExistingResidencePermitDocument = true;
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
if(file!=null) {
  switch (type) {
    case 'passport':
      passportDocument = file;
      hasExistingPassportDocument = true;
      break;
    case 'seaman':
      seamanDocument = file;
      hasExistingSeamanDocument = true;
      break;
    case 'seafarer_visa':
      seafarerVisaDocument = file;
      hasExistingSeafarerVisaDocument = true;
      break;
    case 'visa':
      visaDocument = file;
      hasExistingVisaDocument = true;
      break;
    case 'residence_permit':
      residencePermitDocument = file;
      hasExistingResidencePermitDocument = true;
      break;
  }
}
      notifyListeners();
    }
  }

  void removeAttachment(String type) {
    switch (type) {
      case 'passport':
        passportDocument = null;
        hasExistingPassportDocument = false;
        break;
      case 'seaman':
        seamanDocument = null;
        hasExistingSeamanDocument = false;
        break;
      case 'seafarer_visa':
        seafarerVisaDocument = null;
        hasExistingSeafarerVisaDocument = false;
        break;
      case 'visa':
        visaDocument = null;
        hasExistingVisaDocument = false;
        break;
      case 'residence_permit':
        residencePermitDocument = null;
        hasExistingResidencePermitDocument = false;
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose all controllers
    seafarerRegistrationNoController.dispose();
    passportNoController.dispose();
    passportIssueDateController.dispose();
    passportExpiryDateController.dispose();
    seamanBookNoController.dispose();
    seamanIssuingAuthorityController.dispose();
    seamanIssueDateController.dispose();
    seamanExpiryDateController.dispose();
    seafarerVisaNoController.dispose();
    seafarerVisaIssueDateController.dispose();
    seafarerVisaExpiryDateController.dispose();
    visaNoController.dispose();
    visaIssueDateController.dispose();
    visaExpiryDateController.dispose();
    residencePermitNoController.dispose();
    residencePermitIssueDateController.dispose();
    residencePermitExpiryDateController.dispose();
    
    // Dispose all focus nodes
    seafarerRegistrationNoFocusNode.dispose();
    passportNoFocusNode.dispose();
    passportIssueDateFocusNode.dispose();
    passportExpiryDateFocusNode.dispose();
    seamanBookNoFocusNode.dispose();
    seamanIssuingAuthorityFocusNode.dispose();
    seamanIssueDateFocusNode.dispose();
    seamanExpiryDateFocusNode.dispose();
    seafarerVisaNoFocusNode.dispose();
    seafarerVisaIssueDateFocusNode.dispose();
    seafarerVisaExpiryDateFocusNode.dispose();
    visaNoFocusNode.dispose();
    visaIssueDateFocusNode.dispose();
    visaExpiryDateFocusNode.dispose();
    residencePermitNoFocusNode.dispose();
    residencePermitIssueDateFocusNode.dispose();
    residencePermitExpiryDateFocusNode.dispose();
    
    super.dispose();
  }
}

class Passport {
  String passportNo;
  String country;
  String issueDate;
  String expiryDate;
  String documentUrl;

  Passport({
    required this.passportNo,
    required this.country,
    required this.issueDate,
    required this.expiryDate,
    required this.documentUrl,
  });
}

class SeamanBook {
  String seamanBookNo;
  String issuingCountry;
  String issuingAuthority;
  String issueDate;
  String expiryDate;
  bool neverExpire;
  String nationality;
  String documentUrl;

  SeamanBook({
    required this.seamanBookNo,
    required this.issuingCountry,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expiryDate,
    required this.neverExpire,
    required this.nationality,
    required this.documentUrl,
  });
}

class Visa {
  String issuingCountry;
  String visaNo;
  String issueDate;
  String expiryDate;
  String documentUrl;

  Visa({
    required this.issuingCountry,
    required this.visaNo,
    required this.issueDate,
    required this.expiryDate,
    required this.documentUrl,
  });
}

class ResidencePermit {
  String issuingCountry;
  String no;
  String issueDate;
  String expiryDate;
  String documentUrl;

  ResidencePermit({
    required this.issuingCountry,
    required this.no,
    required this.issueDate,
    required this.expiryDate,
    required this.documentUrl,
  });
}
