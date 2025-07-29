class LoginModel {
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({this.statusCode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      statusCode = null;
      message = null;
      data = null;
      return;
    }
    statusCode = json['statusCode'] as int?;
    message = json['message'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>?) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic>? json) {
    user = json != null && json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>?) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? otp; // Changed from Null? to String? for consistency
  String? otpExpiresAt; // Changed from Null? to String?
  String? fcmToken; // Changed from Null? to String?
  String? careerType; // Changed from Null? to String?
  String? refreshToken; // Changed from Null? to String?
  bool? isEmailVerified;
  bool? isActive;
  bool? isJobAlerts;
  bool? isNewsLetters;
  bool? isPrivacyPolicy;
  bool? isPasswordReset;
  String? resetToken; // Changed from Null? to String?
  String? role;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.email,
    this.otp,
    this.otpExpiresAt,
    this.fcmToken,
    this.careerType,
    this.refreshToken,
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

  User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      id = null;
      email = null;
      otp = null;
      otpExpiresAt = null;
      fcmToken = null;
      careerType = null;
      refreshToken = null;
      isEmailVerified = null;
      isActive = null;
      isJobAlerts = null;
      isNewsLetters = null;
      isPrivacyPolicy = null;
      isPasswordReset = null;
      resetToken = null;
      role = null;
      isDeleted = null;
      createdAt = null;
      updatedAt = null;
      return;
    }
    id = json['id'] as String?;
    email = json['email'] as String?;
    otp = json['otp'] as String?;
    otpExpiresAt = json['otpExpiresAt'] as String?;
    fcmToken = json['fcmToken'] as String?;
    careerType = json['career_type'] as String?;
    refreshToken = json['refreshToken'] as String?;
    isEmailVerified = json['isEmailVerified'] as bool?;
    isActive = json['isActive'] as bool?;
    isJobAlerts = json['isJobAlerts'] as bool?;
    isNewsLetters = json['isNewsLetters'] as bool?;
    isPrivacyPolicy = json['isPrivacyPolicy'] as bool?;
    isPasswordReset = json['isPasswordReset'] as bool?;
    resetToken = json['resetToken'] as String?;
    role = json['role'] as String?;
    isDeleted = json['is_deleted'] as bool?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['otp'] = otp;
    data['otpExpiresAt'] = otpExpiresAt;
    data['fcmToken'] = fcmToken;
    data['career_type'] = careerType;
    data['refreshToken'] = refreshToken;
    data['isEmailVerified'] = isEmailVerified;
    data['isActive'] = isActive;
    data['isJobAlerts'] = isJobAlerts;
    data['isNewsLetters'] = isNewsLetters;
    data['isPrivacyPolicy'] = isPrivacyPolicy;
    data['isPasswordReset'] = isPasswordReset;
    data['resetToken'] = resetToken;
    data['role'] = role;
    data['is_deleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}