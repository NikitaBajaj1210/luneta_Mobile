class VerifyOtpModel {
  String? email;
  String? otp;

  VerifyOtpModel({this.email, this.otp});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}

class VerifyOtpResponse {
  String? message;
  UserData? user;
  int? statusCode;

  VerifyOtpResponse({this.message, this.user, this.statusCode});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? email;
  String? otp;
  String? otpExpiresAt;
  String? fcmToken;
  String? careerType;
  String? refreshToken;
  bool? isEmailVerified;
  bool? isActive;
  bool? isJobAlerts;
  bool? isNewsLetters;
  bool? isPrivacyPolicy;
  bool? isPasswordReset;
  String? resetToken;
  String? role;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? token;

  UserData({
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
    this.token,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    otp = json['otp'];
    otpExpiresAt = json['otpExpiresAt'];
    fcmToken = json['fcmToken'];
    careerType = json['career_type'];
    refreshToken = json['refreshToken'];
    isEmailVerified = json['isEmailVerified'];
    isActive = json['isActive'];
    isJobAlerts = json['isJobAlerts'];
    isNewsLetters = json['isNewsLetters'];
    isPrivacyPolicy = json['isPrivacyPolicy'];
    isPasswordReset = json['isPasswordReset'];
    resetToken = json['resetToken'];
    role = json['role'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
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
    data['token'] = token;
    return data;
  }
} 