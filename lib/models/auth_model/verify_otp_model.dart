import 'package:flutter/foundation.dart';

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
  String? password;
  String? token;
  SeafarerProfile? seafarerProfile;

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
    this.password,
    this.token,
    this.seafarerProfile,
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
    password = json['password'];
    token = json['token'];
    seafarerProfile = json['seafarerProfile'] != null
        ? SeafarerProfile.fromJson(json['seafarerProfile'])
        : null;
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
    data['password'] = password;
    data['token'] = token;
    if (seafarerProfile != null) {
      data['seafarerProfile'] = seafarerProfile!.toJson();
    }
    return data;
  }
}

class SeafarerProfile {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? countryOfBirth;
  String? religion;
  String? sex;
  String? nationality;
  String? email;
  String? mobilePhone;
  String? directLinePhone;
  String? homeAddress;
  String? nearestAirport;
  String? onlineCommunication;
  String? maritalStatus;
  int? numberOfChildren;
  String? profilePhoto;
  String? profilePhotoOriginalName;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isCompletedMobile;
  int? points;
  String? contactEmail;
  String? rankId;
  String? createdBy;
  String? updatedBy;
  String? currentCountry;
  UserData? user;

  SeafarerProfile({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.countryOfBirth,
    this.religion,
    this.sex,
    this.nationality,
    this.email,
    this.mobilePhone,
    this.directLinePhone,
    this.homeAddress,
    this.nearestAirport,
    this.onlineCommunication,
    this.maritalStatus,
    this.numberOfChildren,
    this.profilePhoto,
    this.profilePhotoOriginalName,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.isCompletedMobile,
    this.points,
    this.contactEmail,
    this.rankId,
    this.createdBy,
    this.updatedBy,
    this.currentCountry,
    this.user,
  });

  SeafarerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    religion = json['religion'];
    sex = json['sex'];
    nationality = json['nationality'];
    email = json['email'];
    mobilePhone = json['mobilePhone'];
    directLinePhone = json['directLinePhone'];
    homeAddress = json['homeAddress'];
    nearestAirport = json['nearestAirport'];
    onlineCommunication = json['onlineCommunication'];
    maritalStatus = json['maritalStatus'];
    numberOfChildren = json['numberOfChildren'];
    profilePhoto = json['profilePhoto'];
    profilePhotoOriginalName = json['profilePhotoOriginalName'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    isCompletedMobile = json['is_completed_mobile'];
    points = json['points'];
    contactEmail = json['contactEmail'];
    rankId = json['rankId'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    currentCountry = json['currentCountry'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dateOfBirth'] = dateOfBirth;
    data['countryOfBirth'] = countryOfBirth;
    data['religion'] = religion;
    data['sex'] = sex;
    data['nationality'] = nationality;
    data['email'] = email;
    data['mobilePhone'] = mobilePhone;
    data['directLinePhone'] = directLinePhone;
    data['homeAddress'] = homeAddress;
    data['nearestAirport'] = nearestAirport;
    data['onlineCommunication'] = onlineCommunication;
    data['maritalStatus'] = maritalStatus;
    data['numberOfChildren'] = numberOfChildren;
    data['profilePhoto'] = profilePhoto;
    data['profilePhotoOriginalName'] = profilePhotoOriginalName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    data['is_completed_mobile'] = isCompletedMobile;
    data['points'] = points;
    data['contactEmail'] = contactEmail;
    data['rankId'] = rankId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['currentCountry'] = currentCountry;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class VerifyOtpForgotResponse {
  String? message;
  ForgotPasswordData? data;
  int? statusCode;

  VerifyOtpForgotResponse({this.message, this.data, this.statusCode});

  VerifyOtpForgotResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? ForgotPasswordData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ForgotPasswordData {
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

  ForgotPasswordData({
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

  ForgotPasswordData.fromJson(Map<String, dynamic> json) {
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