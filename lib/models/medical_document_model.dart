
// MedicalDocumentResponse Model
class MedicalDocumentResponse {
  final int? statusCode; // Made optional to handle null
  final MedicalDocument? data; // Made optional to handle null
  final String? message;

  MedicalDocumentResponse({
    this.statusCode,
    this.data,
    this.message
  });

  factory MedicalDocumentResponse.fromJson(Map<String, dynamic> json) {
    return MedicalDocumentResponse(
      statusCode: json['statusCode'] as int?, // Handle null or missing statusCode
       message: json['message'] as String?,
      data: json['data'] != null ? MedicalDocument.fromJson(json['data']) : null, // Handle null data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (statusCode != null) 'statusCode': statusCode,
      if (message != null) 'message': statusCode,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

// MedicalDocument Model
class MedicalDocument {
  final String? id; // Made optional to handle null
  final String? userId; // Made optional to handle null
  final List<MedicalFitness>? medicalFitness; // Made optional to handle null or empty list
  final List<DrugAlcoholTest>? drugAlcoholTest; // Made optional to handle null or empty list
  final List<VaccinationCertificate>? vaccinationCertificates; // Made optional to handle null or empty list

  MedicalDocument({
    this.id,
    this.userId,
    this.medicalFitness = const [], // Default to empty list if null
    this.drugAlcoholTest = const [], // Default to empty list if null
    this.vaccinationCertificates = const [], // Default to empty list if null
  });

  factory MedicalDocument.fromJson(Map<String, dynamic> json) {
    return MedicalDocument(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      medicalFitness: (json['medicalFitness'] as List?)
          ?.map((item) => MedicalFitness.fromJson(item))
          .toList() ?? [], // Handle null or empty list
      drugAlcoholTest: (json['drugAlcoholTest'] as List?)
          ?.map((item) => DrugAlcoholTest.fromJson(item))
          .toList() ?? [], // Handle null or empty list
      vaccinationCertificates: (json['vaccinationCertificates'] as List?)
          ?.map((item) => VaccinationCertificate.fromJson(item))
          .toList() ?? [], // Handle null or empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (medicalFitness != null) 'medicalFitness': medicalFitness!.map((x) => x.toJson()).toList(),
      if (drugAlcoholTest != null) 'drugAlcoholTest': drugAlcoholTest!.map((x) => x.toJson()).toList(),
      if (vaccinationCertificates != null)
        'vaccinationCertificates': vaccinationCertificates!.map((x) => x.toJson()).toList(),
    };
  }
}

// MedicalFitness Model
class MedicalFitness {
  final String? documentType;
  final String? certificateNo;
  final String? issuingCountry;
  final String? issuingAuthority;
  final String? issuingDate;
  final String? expDate;
  final bool? neverExpire;
  final String? documentOriginalName;
  final String? documentPath;
  final String? originalName;

  MedicalFitness({
    this.documentType = '', // Default to empty string if null
    this.certificateNo = '', // Default to empty string if null
    this.issuingCountry = '', // Default to empty string if null
    this.issuingAuthority = '', // Default to empty string if null
    this.issuingDate = '', // Default to empty string if null
    this.expDate, // Optional, can be null
    this.neverExpire, // Optional, can be null
    this.documentOriginalName= '', // Optional, can be null
    this.documentPath, // Optional, can be null
    this.originalName, // Optional, can be null
  });

  factory MedicalFitness.fromJson(Map<String, dynamic> json) {
    return MedicalFitness(
      documentType: json['documentType'] as String? ?? '',
      certificateNo: json['certificateNo'] as String? ?? '',
      issuingCountry: json['issuingCountry'] as String? ?? '',
      issuingAuthority: json['issuingAuthority'] as String? ?? '',
      issuingDate: json['issuingDate'] as String? ?? '',
      expDate: json['expDate'] as String?,
      neverExpire: json['neverExpire'] as bool?,
      documentOriginalName: json['documentOriginalName'] as String?,
      documentPath: json['documentPath'] as String?,
      originalName: json['originalName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (documentType != null && documentType!.isNotEmpty) 'documentType': documentType,
      if (certificateNo != null && certificateNo!.isNotEmpty) 'certificateNo': certificateNo,
      if (issuingCountry != null && issuingCountry!.isNotEmpty) 'issuingCountry': issuingCountry,
      if (issuingAuthority != null && issuingAuthority!.isNotEmpty) 'issuingAuthority': issuingAuthority,
      if (issuingDate != null && issuingDate!.isNotEmpty) 'issuingDate': issuingDate,
      if (expDate != null) 'expDate': expDate,
      if (neverExpire != null) 'neverExpire': neverExpire,
      if (documentOriginalName != null) 'documentOriginalName': documentOriginalName,
      if (documentPath != null) 'documentPath': documentPath,
      if (originalName != null) 'originalName': originalName,
    };
  }
}

// DrugAlcoholTest Model
class DrugAlcoholTest {
  final String? documentType;
  final String? certificateNo;
  final String? issuingCountry;
  final String? issuingAuthority;
  final String? issuingDate;
  final String? expDate; // Optional field
  final bool? neverExpiry; // Optional field
  final String? documentOriginalName;
  final String? documentPath;
  final String? originalName;

  DrugAlcoholTest({
    this.documentType = '', // Default to empty string if null
    this.certificateNo = '', // Default to empty string if null
    this.issuingCountry = '', // Default to empty string if null
    this.issuingAuthority = '', // Default to empty string if null
    this.issuingDate = '', // Default to empty string if null
    this.expDate,
    this.neverExpiry,
    this.documentOriginalName,
    this.documentPath,
    this.originalName,
  });

  factory DrugAlcoholTest.fromJson(Map<String, dynamic> json) {
    return DrugAlcoholTest(
      documentType: json['documentType'] as String? ?? '',
      certificateNo: json['certificateNo'] as String? ?? '',
      issuingCountry: json['issuingCountry'] as String? ?? '',
      issuingAuthority: json['issuingAuthority'] as String? ?? '',
      issuingDate: json['issuingDate'] as String? ?? '',
      expDate: json['expDate'] as String?,
      neverExpiry: json['neverExpiry'] as bool?,
      documentOriginalName: json['documentOriginalName'] as String?,
      documentPath: json['documentPath'] as String?,
      originalName: json['originalName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (documentType != null && documentType!.isNotEmpty) 'documentType': documentType,
      if (certificateNo != null && certificateNo!.isNotEmpty) 'certificateNo': certificateNo,
      if (issuingCountry != null && issuingCountry!.isNotEmpty) 'issuingCountry': issuingCountry,
      if (issuingAuthority != null && issuingAuthority!.isNotEmpty) 'issuingAuthority': issuingAuthority,
      if (issuingDate != null && issuingDate!.isNotEmpty) 'issuingDate': issuingDate,
      if (expDate != null) 'expDate': expDate,
      if (neverExpiry != null) 'neverExpiry': neverExpiry,
      if (documentOriginalName != null) 'documentOriginalName': documentOriginalName,
      if (documentPath != null) 'documentPath': documentPath,
      if (originalName != null) 'originalName': originalName,
    };
  }
}

// VaccinationCertificate Model
class VaccinationCertificate {
  final String? documentType;
  final String? certificateNo;
  final String? issuingCountry;
  final String? issuingAuthority;
  final String? issuingDate;
  final String? expDate;
  final bool? neverExpire;
  final String? documentOriginalName;
  final String? documentPath;
  final String? originalName;

  VaccinationCertificate({
    this.documentType = '', // Default to empty string if null
    this.certificateNo = '', // Default to empty string if null
    this.issuingCountry = '', // Default to empty string if null
    this.issuingAuthority = '', // Default to empty string if null
    this.issuingDate = '', // Default to empty string if null
    this.expDate, // Optional, can be null
    this.neverExpire, // Optional, can be null
    this.documentOriginalName, // Optional, can be null
    this.documentPath, // Optional, can be null
    this.originalName, // Optional, can be null
  });

  factory VaccinationCertificate.fromJson(Map<String, dynamic> json) {
    return VaccinationCertificate(
      documentType: json['documentType'] as String? ?? '',
      certificateNo: json['certificateNo'] as String? ?? '',
      issuingCountry: json['issuingCountry'] as String? ?? '',
      issuingAuthority: json['issuingAuthority'] as String? ?? '',
      issuingDate: json['issuingDate'] as String? ?? '',
      expDate: json['expDate'] as String?,
      neverExpire: json['neverExpire'] as bool?,
      documentOriginalName: json['documentOriginalName'] as String?,
      documentPath: json['documentPath'] as String?,
      originalName: json['originalName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (documentType != null && documentType!.isNotEmpty) 'documentType': documentType,
      if (certificateNo != null && certificateNo!.isNotEmpty) 'certificateNo': certificateNo,
      if (issuingCountry != null && issuingCountry!.isNotEmpty) 'issuingCountry': issuingCountry,
      if (issuingAuthority != null && issuingAuthority!.isNotEmpty) 'issuingAuthority': issuingAuthority,
      if (issuingDate != null && issuingDate!.isNotEmpty) 'issuingDate': issuingDate,
      if (expDate != null) 'expDate': expDate,
      if (neverExpire != null) 'neverExpire': neverExpire,
      if (documentOriginalName != null) 'documentOriginalName': documentOriginalName,
      if (documentPath != null) 'documentPath': documentPath,
      if (originalName != null) 'originalName': originalName,
    };
  }
}