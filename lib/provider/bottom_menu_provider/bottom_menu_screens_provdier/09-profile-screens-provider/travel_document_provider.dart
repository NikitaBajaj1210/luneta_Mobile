import 'package:flutter/material.dart';

class TravelDocumentProvider extends ChangeNotifier {
  // Controllers
  final TextEditingController seafarerRegistrationNoController = TextEditingController();
  final TextEditingController passportNoController = TextEditingController();
  final TextEditingController passportIssueDateController = TextEditingController();
  final TextEditingController passportExpiryDateController = TextEditingController();
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

  void setResidencePermitExpiryDate(DateTime date) {
    residencePermitExpiryDateController.text = "${date.toLocal()}".split(' ')[0];
    notifyListeners();
  }

  String? validate() {
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
