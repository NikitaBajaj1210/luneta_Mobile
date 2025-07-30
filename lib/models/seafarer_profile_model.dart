class SeafarerProfileModel {
  String? userId;
  String? currentCountry;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? contactEmail;
  String? mobilePhone;
  String? sex;

  SeafarerProfileModel({
    this.userId,
    this.currentCountry,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.contactEmail,
    this.mobilePhone,
    this.sex,
  });

  SeafarerProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    currentCountry = json['currentCountry'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    contactEmail = json['contactEmail'];
    mobilePhone = json['mobilePhone'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['currentCountry'] = currentCountry;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dateOfBirth'] = dateOfBirth;
    data['contactEmail'] = contactEmail;
    data['mobilePhone'] = mobilePhone;
    data['sex'] = sex;
    return data;
  }
}

class SeafarerProfileResponse {
  int? statusCode;
  String? message;
  SeafarerProfileData? data;

  SeafarerProfileResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  SeafarerProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? SeafarerProfileData.fromJson(json['data']) : null;
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

class SeafarerProfileData {
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
  int? points;
  String? contactEmail;
  String? createdBy;
  String? updatedBy;
  String? currentCountry;
  UserData? user;

  SeafarerProfileData({
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
    this.points,
    this.contactEmail,
    this.createdBy,
    this.updatedBy,
    this.currentCountry,
    this.user,
  });

  SeafarerProfileData.fromJson(Map<String, dynamic> json) {
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
    points = json['points'];
    contactEmail = json['contactEmail'];
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
    data['points'] = points;
    data['contactEmail'] = contactEmail;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['currentCountry'] = currentCountry;
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