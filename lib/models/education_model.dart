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
      statusCode: json['statusCode'] ?? 0,
      message: json['message'],
      data: json['data'] != null ? EducationData.fromJson(json['data']) : null,
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
      id: json['id'],
      userId: json['userId'],
      academicQualification: json['academicQualification'] != null
          ? List<AcademicQualificationModel>.from(
              json['academicQualification'].map((x) => AcademicQualificationModel.fromJson(x)))
          : null,
      certificationsAndTrainings: json['certificationsAndTrainings'] != null
          ? List<CertificationModel>.from(
              json['certificationsAndTrainings'].map((x) => CertificationModel.fromJson(x)))
          : null,
      languagesSpoken: json['languagesSpoken'] != null
          ? List<LanguageModel>.from(
              json['languagesSpoken'].map((x) => LanguageModel.fromJson(x)))
          : null,
      degreeDocumentPath: json['degreeDocumentPath'],
      certificateDocumentPath: json['certificateDocumentPath'],
      degreeDocumentOriginalName: json['degreeDocumentOriginalName'],
      certificateDocumentOriginalName: json['certificateDocumentOriginalName'],
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

  AcademicQualificationModel({
    this.educationalDegree,
    this.fieldOfStudy,
    this.educationalInstitution,
    this.country,
    this.graduationDate,
    this.degreeDocumentOriginalName,
    this.document,
  });

  factory AcademicQualificationModel.fromJson(Map<String, dynamic> json) {
    return AcademicQualificationModel(
      educationalDegree: json['educationalDegree'],
      fieldOfStudy: json['fieldOfStudy'],
      educationalInstitution: json['educationalInstitution'],
      country: json['country'],
      graduationDate: json['graduationDate'],
      degreeDocumentOriginalName: json['degreeDocumentOriginalName'],
      document: json['document'],
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
    return CertificationModel(
      certificationType: json['certificationType'],
      issuingAuthority: json['issuingAuthority'],
      issueDate: json['issueDate'],
      expiryDate: json['expiryDate'],
      neverExpire: json['neverExpire'],
      certificationsAndTrainingsDocumentOriginalName: json['certificationsAndTrainingsDocumentOriginalName'],
      document: json['document'],
      certificateDocumentPath: json['certificateDocumentPath'],
      certificateDocumentOriginalName: json['certificateDocumentOriginalName'],
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
    return LanguageModel(
      native: json['native'] != null ? List<String>.from(json['native']) : null,
      additionalLanguage: json['additionalLanguage'],
      level: json['level'],
    );
  }
} 