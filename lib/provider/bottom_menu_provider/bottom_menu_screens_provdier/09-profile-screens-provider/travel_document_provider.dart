import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';

class TravelDocumentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  List<String> countries = [];

  TravelDocumentProvider() {
    countries = CountryService().getAll().map((country) => country.name).toList();
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
      return 'Seafarer’s Registration No. is required';
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
    if (passportDocumentController.text.isEmpty) {
      return 'Passport Document is required';
    }
    if (seamanBookNoController.text.isEmpty) {
      return 'Seaman’s Book No. is required';
    }
    if (seamanIssuingAuthorityController.text.isEmpty) {
      return 'Seaman’s Book Issuing Authority is required';
    }
    if (seamanIssueDateController.text.isEmpty) {
      return 'Seaman’s Book Issue Date is required';
    }
    if (seamanExpiryDateController.text.isEmpty && !seamanNeverExpire) {
      return 'Seaman’s Book Expiry Date is required';
    }
    if (seamanDocumentController.text.isEmpty) {
      return 'Seaman’s Book Document is required';
    }
    if (validSeafarerVisa) {
      if (seafarerVisaNoController.text.isEmpty) {
        return 'Seafarer’s Visa No. is required';
      }
      if (seafarerVisaIssueDateController.text.isEmpty) {
        return 'Seafarer’s Visa Issue Date is required';
      }
      if (seafarerVisaExpiryDateController.text.isEmpty) {
        return 'Seafarer’s Visa Expiry Date is required';
      }
      if (seafarerVisaDocumentController.text.isEmpty) {
        return 'Seafarer’s Visa Document is required';
      }
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
          break;
        case 'seaman':
          seamanDocument = file;
          break;
        case 'seafarer_visa':
          seafarerVisaDocument = file;
          break;
        case 'visa':
          visaDocument = file;
          break;
        case 'residence_permit':
          residencePermitDocument = file;
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
        case 'passport':
          passportDocument = file;
          break;
        case 'seaman':
          seamanDocument = file;
          break;
        case 'seafarer_visa':
          seafarerVisaDocument = file;
          break;
        case 'visa':
          visaDocument = file;
          break;
        case 'residence_permit':
          residencePermitDocument = file;
          break;
      }
      notifyListeners();
    }
  }

  void removeAttachment(String type) {
    switch (type) {
      case 'passport':
        passportDocument = null;
        break;
      case 'seaman':
        seamanDocument = null;
        break;
      case 'seafarer_visa':
        seafarerVisaDocument = null;
        break;
      case 'visa':
        visaDocument = null;
        break;
      case 'residence_permit':
        residencePermitDocument = null;
        break;
    }
    notifyListeners();
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
