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
  final String id;
  final String userId;
  final String seafarerRegNo;
  final String passportNo;
  final String passportCountry;
  final String passportIssueDate;
  final String passportExpDate;
  final String passportDocumentPath;
  final String passportDocumentOriginalName;
  final String seamansBookNo;
  final String seamansBookIssuingCountry;
  final String seamansBookIssuingAuthority;
  final String seamansBookIssueDate;
  final String seamansBookExpDate;
  final bool seamansBookNeverExpire;
  final String seamansBookNationality;
  final String seamansBookDocumentPath;
  final String seamansBookDocumentOriginalName;
  final bool validSeafarerVisa;
  final String seafarerVisaIssuingCountry;
  final String seafarerVisaNo;
  final String seafarerVisaIssuingDate;
  final String seafarerVisaExpDate;
  final String seafarerVisaDocumentPath;
  final String seafarerVisaDocumentOriginalName;
  final String visaIssuingCountry;
  final String visaNo;
  final String visaIssuingDate;
  final String visaExpDate;
  final String visaDocumentPath;
  final String visaDocumentOriginalName;
  final String residencePermitIssuingCountry;
  final String residencePermitNo;
  final String residencePermitIssuingDate;
  final String residencePermitExpDate;
  final String residencePermitDocumentPath;
  final String residencePermitDocumentOriginalName;

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