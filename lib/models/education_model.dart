class EducationResponse {
  final int statusCode;
  final String? message;
  final EducationData? data;

  EducationResponse({
    required this.statusCode,
    this.message,
    this.data,
  });

  factory EducationResponse.fromJson(Map<String, dynamic> json) {
    return EducationResponse(
      statusCode: json['statusCode'] is int ? json['statusCode'] : (int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0),
      message: json['message']?.toString(),
      data: json['data'] != null && json['data'] is Map<String, dynamic> ? EducationData.fromJson(json['data']) : null,
    );
  }
}

class EducationData {
  final String? id;
  final String? userId;
  final List<AcademicQualificationModel>? academicQualification;
  final List<CertificationModel>? certificationsAndTrainings;
  final List<LanguageModel>? languagesSpoken;
  final String? degreeDocumentPath;
  final String? certificateDocumentPath;
  final String? degreeDocumentOriginalName;
  final String? certificateDocumentOriginalName;

  EducationData({
    this.id,
    this.userId,
    this.academicQualification,
    this.certificationsAndTrainings,
    this.languagesSpoken,
    this.degreeDocumentPath,
    this.certificateDocumentPath,
    this.degreeDocumentOriginalName,
    this.certificateDocumentOriginalName,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) {
    return EducationData(
      id: json['id']?.toString(),
      userId: json['userId']?.toString(),
      academicQualification: json['academicQualification'] != null && json['academicQualification'] is List
          ? List<AcademicQualificationModel>.from(
              json['academicQualification'].map((x) => AcademicQualificationModel.fromJson(x)))
          : null,
      certificationsAndTrainings: json['certificationsAndTrainings'] != null && json['certificationsAndTrainings'] is List
          ? List<CertificationModel>.from(
              json['certificationsAndTrainings'].map((x) => CertificationModel.fromJson(x)))
          : null,
      languagesSpoken: json['languagesSpoken'] != null && json['languagesSpoken'] is List
          ? List<LanguageModel>.from(
              json['languagesSpoken'].map((x) => LanguageModel.fromJson(x)))
          : null,
      degreeDocumentPath: json['degreeDocumentPath']?.toString(),
      certificateDocumentPath: json['certificateDocumentPath']?.toString(),
      degreeDocumentOriginalName: json['degreeDocumentOriginalName']?.toString(),
      certificateDocumentOriginalName: json['certificateDocumentOriginalName']?.toString(),
    );
  }
}

class AcademicQualificationModel {
  final String? educationalDegree;
  final String? fieldOfStudy;
  final String? educationalInstitution;
  final String? country;
  final String? graduationDate;
  final String? degreeDocumentOriginalName;
  final String? document;
  final String? degreeDocumentPath;

  AcademicQualificationModel({
    this.educationalDegree,
    this.fieldOfStudy,
    this.educationalInstitution,
    this.country,
    this.graduationDate,
    this.degreeDocumentOriginalName,
    this.document,
    this.degreeDocumentPath,
  });

  factory AcademicQualificationModel.fromJson(Map<String, dynamic> json) {
    return AcademicQualificationModel(
      educationalDegree: json['educationalDegree']?.toString(),
      fieldOfStudy: json['fieldOfStudy']?.toString(),
      educationalInstitution: json['educationalInstitution']?.toString(),
      country: json['country']?.toString(),
      graduationDate: json['graduationDate']?.toString(),
      degreeDocumentOriginalName: json['degreeDocumentOriginalName']?.toString(),
      document: json['document']?.toString(),
      degreeDocumentPath: json['degreeDocumentPath']?.toString(),
    );
  }
}

class CertificationModel {
  final String? certificationType;
  final String? issuingAuthority;
  final String? issueDate;
  final String? expiryDate;
  final bool? neverExpire;
  final String? certificationsAndTrainingsDocumentOriginalName;
  final String? document;
  final String? certificateDocumentPath;
  final String? certificateDocumentOriginalName;

  CertificationModel({
    this.certificationType,
    this.issuingAuthority,
    this.issueDate,
    this.expiryDate,
    this.neverExpire,
    this.certificationsAndTrainingsDocumentOriginalName,
    this.document,
    this.certificateDocumentPath,
    this.certificateDocumentOriginalName,
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    // Handle certificationType which might come as List or String
    String? certificationType;
    if (json['certificationType'] is List) {
      // If it's a list, take the first element or join them
      List<dynamic> certTypes = json['certificationType'];
      certificationType = certTypes.isNotEmpty ? certTypes.first?.toString() : null;
    } else {
      certificationType = json['certificationType']?.toString();
    }
    
    return CertificationModel(
      certificationType: certificationType,
      issuingAuthority: json['issuingAuthority']?.toString(),
      issueDate: json['issueDate']?.toString(),
      expiryDate: json['expiryDate']?.toString(),
      neverExpire: json['neverExpire'] is bool ? json['neverExpire'] : false,
      certificationsAndTrainingsDocumentOriginalName: json['certificationsAndTrainingsDocumentOriginalName']?.toString(),
      document: json['document']?.toString(),
      certificateDocumentPath: json['certificateDocumentPath']?.toString(),
      certificateDocumentOriginalName: json['certificateDocumentOriginalName']?.toString(),
    );
  }
}

class LanguageModel {
  final List<String>? native;
  final String? additionalLanguage;
  final String? level;

  LanguageModel({
    this.native,
    this.additionalLanguage,
    this.level,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    // Handle native languages list safely
    List<String>? nativeLanguages;
    if (json['native'] != null) {
      if (json['native'] is List) {
        nativeLanguages = List<String>.from(json['native'].map((e) => e?.toString() ?? ''));
      } else {
        // If it's a single string, convert to list
        nativeLanguages = [json['native'].toString()];
      }
    }
    
    return LanguageModel(
      native: nativeLanguages,
      additionalLanguage: json['additionalLanguage']?.toString(),
      level: json['level']?.toString(),
    );
  }
} 