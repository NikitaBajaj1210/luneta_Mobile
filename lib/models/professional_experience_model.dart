import 'dart:io';

class ProfessionalExperienceResponse {
  final int statusCode;
  final String message;
  final List<ProfessionalExperience> data;

  ProfessionalExperienceResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProfessionalExperienceResponse.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperienceResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
          ?.map((item) => ProfessionalExperience.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class ProfessionalExperience {
  final String? id;
  final List<String>? positionsHeld;
  final List<String>? vesselTypeExperience;
  final String? userId;
  final String? experienceDocumentPath;
  final String? experienceDocumentOriginalName;
  final List<ProfessionalEmploymentHistory>? employmentHistory;
  final List<Reference>? references;
  final User? user;

  ProfessionalExperience({
    this.id,
    this.positionsHeld,
    this.vesselTypeExperience,
    this.userId,
    this.experienceDocumentPath,
    this.experienceDocumentOriginalName,
    this.employmentHistory,
    this.references,
    this.user,
  });

  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperience(
      id: json['id'],
      positionsHeld: (json['positionsHeld'] as List?)?.cast<String>() ?? [],
      vesselTypeExperience: (json['vesselTypeExperience'] as List?)?.cast<String>() ?? [],
      userId: json['userId'],
      experienceDocumentPath: json['experienceDocumentPath'],
      experienceDocumentOriginalName: json['experienceDocumentOriginalName'],
      employmentHistory: (json['employmentHistory'] as List?)
          ?.map((item) => ProfessionalEmploymentHistory.fromJson(item))
          .toList() ?? [],
      references: (json['references'] as List?)
          ?.map((item) => Reference.fromJson(item))
          .toList() ?? [],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'positionsHeld': positionsHeld,
      'vesselTypeExperience': vesselTypeExperience,
      'userId': userId,
      'experienceDocumentPath': experienceDocumentPath,
      'experienceDocumentOriginalName': experienceDocumentOriginalName,
      'employmentHistory': employmentHistory?.map((x) => x.toJson()).toList(),
      'references': references?.map((x) => x.toJson()).toList(),
      'user': user?.toJson(),
    };
  }
}

class ProfessionalEmploymentHistory {
  final String? id;
  final String? companyName;
  final String? position;
  final String? startDate;
  final String? professionalExperienceId;
  final String? endDate;
  final String? responsibilities;

  ProfessionalEmploymentHistory({
    this.id,
    this.companyName,
    this.position,
    this.startDate,
    this.professionalExperienceId,
    this.endDate,
    this.responsibilities,
  });

  factory ProfessionalEmploymentHistory.fromJson(Map<String, dynamic> json) {
    return ProfessionalEmploymentHistory(
      id: json['id'],
      companyName: json['companyName'],
      position: json['position'],
      startDate: json['startDate'],
      professionalExperienceId: json['professionalExperienceId'],
      endDate: json['endDate'],
      responsibilities: json['responsibilities'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'position': position,
      'startDate': startDate,
      'professionalExperienceId': professionalExperienceId,
      'endDate': endDate,
      'responsibilities': responsibilities,
    };
  }
}

class Reference {
  final String? id;
  final String? issuedBy;
  final String? issuingDate;
  final String? vesselOrCompanyName;
  final String? professionalExperienceId;
  String? experienceDocumentPath;
  String? experienceDocumentOriginalName;
  final String? documentPath;
  File? newReferenceDocument;
  bool hasExistingReferenceDocument;

  Reference({
    this.id,
    this.issuedBy,
    this.issuingDate,
    this.vesselOrCompanyName,
    this.professionalExperienceId,
    this.experienceDocumentPath,
    this.experienceDocumentOriginalName,
    this.documentPath,
    this.newReferenceDocument,
    this.hasExistingReferenceDocument = false,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      id: json['id'],
      issuedBy: json['issuedBy'],
      issuingDate: json['issuingDate'],
      vesselOrCompanyName: json['vesselOrCompanyName'],
      professionalExperienceId: json['professionalExperienceId'],
      experienceDocumentPath: json['experienceDocumentPath'],
      experienceDocumentOriginalName: json['experienceDocumentOriginalName'],
      documentPath: json['documentPath'],
      hasExistingReferenceDocument: (json['experienceDocumentPath'] != null && json['experienceDocumentPath'].isNotEmpty) || (json['documentPath'] != null && json['documentPath'].isNotEmpty),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'issuedBy': issuedBy,
      'issuingDate': issuingDate,
      'vesselOrCompanyName': vesselOrCompanyName,
      'professionalExperienceId': professionalExperienceId,
      'experienceDocumentPath': experienceDocumentPath,
      'experienceDocumentOriginalName': experienceDocumentOriginalName,
      'documentPath': documentPath,
    };
  }
}

class User {
  final String? id;
  final String? email;
  final String? otp;
  final String? otpExpiresAt;
  final String? fcmToken;
  final String? careerType;
  final String? refreshToken;
  final String? password;
  final bool? isEmailVerified;
  final bool? isActive;
  final bool? isJobAlerts;
  final bool? isNewsLetters;
  final bool? isPrivacyPolicy;
  final bool? isPasswordReset;
  final String? resetToken;
  final String? role;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.email,
    this.otp,
    this.otpExpiresAt,
    this.fcmToken,
    this.careerType,
    this.refreshToken,
    this.password,
    this.isEmailVerified,
    this.isActive,
    this.isJobAlerts,
    this.isNewsLetters,
    this.isPrivacyPolicy,
    this.isPasswordReset,
    this.resetToken,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'],
      fcmToken: json['fcmToken'],
      careerType: json['career_type'],
      refreshToken: json['refreshToken'],
      password: json['password'],
      isEmailVerified: json['isEmailVerified'],
      isActive: json['isActive'],
      isJobAlerts: json['isJobAlerts'],
      isNewsLetters: json['isNewsLetters'],
      isPrivacyPolicy: json['isPrivacyPolicy'],
      isPasswordReset: json['isPasswordReset'],
      resetToken: json['resetToken'],
      role: json['role'],
      isDeleted: json['is_deleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'otp': otp,
      'otpExpiresAt': otpExpiresAt,
      'fcmToken': fcmToken,
      'career_type': careerType,
      'refreshToken': refreshToken,
      'password': password,
      'isEmailVerified': isEmailVerified,
      'isActive': isActive,
      'isJobAlerts': isJobAlerts,
      'isNewsLetters': isNewsLetters,
      'isPrivacyPolicy': isPrivacyPolicy,
      'isPasswordReset': isPasswordReset,
      'resetToken': resetToken,
      'role': role,
      'is_deleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
} 