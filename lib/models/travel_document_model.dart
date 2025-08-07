class TravelDocumentResponse {
  final int statusCode;
  String? message;
  final List<TravelDocument> data;

  TravelDocumentResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TravelDocumentResponse.fromJson(Map<String, dynamic> json) {
    return TravelDocumentResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => TravelDocument.fromJson(item))
          .toList() ?? [],
    );
  }
}

class CreateUpdateTravelDocumentResponse {
  final int statusCode;
  final String message;
  final bool data;

  CreateUpdateTravelDocumentResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CreateUpdateTravelDocumentResponse.fromJson(Map<String, dynamic> json) {
    return CreateUpdateTravelDocumentResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? false,
    );
  }
}

class TravelDocument {
  String id;
  String userId;
  String seafarerRegNo;
  String passportNo;
  String passportCountry;
  String passportIssueDate;
  String passportExpDate;
  String passportDocumentPath;
  String passportDocumentOriginalName;
  String seamansBookNo;
  String seamansBookIssuingCountry;
  String seamansBookIssuingAuthority;
  String seamansBookIssueDate;
  String seamansBookExpDate;
  bool seamansBookNeverExpire;
  String seamansBookNationality;
  String seamansBookDocumentPath;
  String seamansBookDocumentOriginalName;
  bool validSeafarerVisa;
  String seafarerVisaIssuingCountry;
  String seafarerVisaNo;
  String seafarerVisaIssuingDate;
  String seafarerVisaExpDate;
  String seafarerVisaDocumentPath;
  String seafarerVisaDocumentOriginalName;
  String visaIssuingCountry;
  String visaNo;
  String visaIssuingDate;
  String visaExpDate;
  String visaDocumentPath;
  String visaDocumentOriginalName;
  String residencePermitIssuingCountry;
  String residencePermitNo;
  String residencePermitIssuingDate;
  String residencePermitExpDate;
  String residencePermitDocumentPath;
  String residencePermitDocumentOriginalName;

  TravelDocument({
    required this.id,
    required this.userId,
    required this.seafarerRegNo,
    required this.passportNo,
    required this.passportCountry,
    required this.passportIssueDate,
    required this.passportExpDate,
    required this.passportDocumentPath,
    required this.passportDocumentOriginalName,
    required this.seamansBookNo,
    required this.seamansBookIssuingCountry,
    required this.seamansBookIssuingAuthority,
    required this.seamansBookIssueDate,
    required this.seamansBookExpDate,
    required this.seamansBookNeverExpire,
    required this.seamansBookNationality,
    required this.seamansBookDocumentPath,
    required this.seamansBookDocumentOriginalName,
    required this.validSeafarerVisa,
    required this.seafarerVisaIssuingCountry,
    required this.seafarerVisaNo,
    required this.seafarerVisaIssuingDate,
    required this.seafarerVisaExpDate,
    required this.seafarerVisaDocumentPath,
    required this.seafarerVisaDocumentOriginalName,
    required this.visaIssuingCountry,
    required this.visaNo,
    required this.visaIssuingDate,
    required this.visaExpDate,
    required this.visaDocumentPath,
    required this.visaDocumentOriginalName,
    required this.residencePermitIssuingCountry,
    required this.residencePermitNo,
    required this.residencePermitIssuingDate,
    required this.residencePermitExpDate,
    required this.residencePermitDocumentPath,
    required this.residencePermitDocumentOriginalName,
  });

  factory TravelDocument.fromJson(Map<String, dynamic> json) {
    return TravelDocument(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      seafarerRegNo: json['seafarerRegNo'] ?? '',
      passportNo: json['passportNo'] ?? '',
      passportCountry: json['passportCountry'] ?? '',
      passportIssueDate: json['passportIssueDate'] ?? '',
      passportExpDate: json['passportExpDate'] ?? '',
      passportDocumentPath: json['passportDocumentPath'] ?? '',
      passportDocumentOriginalName: json['passportDocumentOriginalName'] ?? '',
      seamansBookNo: json['seamansBookNo'] ?? '',
      seamansBookIssuingCountry: json['seamansBookIssuingCountry'] ?? '',
      seamansBookIssuingAuthority: json['seamansBookIssuingAuthority'] ?? '',
      seamansBookIssueDate: json['seamansBookIssueDate'] ?? '',
      seamansBookExpDate: json['seamansBookExpDate'] ?? '',
      seamansBookNeverExpire: json['seamansBookNeverExpire'] ?? false,
      seamansBookNationality: json['seamansBookNationality'] ?? '',
      seamansBookDocumentPath: json['seamansBookDocumentPath'] ?? '',
      seamansBookDocumentOriginalName: json['seamansBookDocumentOriginalName'] ?? '',
      validSeafarerVisa: json['validSeafarerVisa'] ?? false,
      seafarerVisaIssuingCountry: json['seafarerVisaIssuingCountry'] ?? '',
      seafarerVisaNo: json['seafarerVisaNo'] ?? '',
      seafarerVisaIssuingDate: json['seafarerVisaIssuingDate'] ?? '',
      seafarerVisaExpDate: json['seafarerVisaExpDate'] ?? '',
      seafarerVisaDocumentPath: json['seafarerVisaDocumentPath'] ?? '',
      seafarerVisaDocumentOriginalName: json['seafarerVisaDocumentOriginalName'] ?? '',
      visaIssuingCountry: json['visaIssuingCountry'] ?? '',
      visaNo: json['visaNo'] ?? '',
      visaIssuingDate: json['visaIssuingDate'] ?? '',
      visaExpDate: json['visaExpDate'] ?? '',
      visaDocumentPath: json['visaDocumentPath'] ?? '',
      visaDocumentOriginalName: json['visaDocumentOriginalName'] ?? '',
      residencePermitIssuingCountry: json['residencePermitIssuingCountry'] ?? '',
      residencePermitNo: json['residencePermitNo'] ?? '',
      residencePermitIssuingDate: json['residencePermitIssuingDate'] ?? '',
      residencePermitExpDate: json['residencePermitExpDate'] ?? '',
      residencePermitDocumentPath: json['residencePermitDocumentPath'] ?? '',
      residencePermitDocumentOriginalName: json['residencePermitDocumentOriginalName'] ?? '',
    );
  }
} 