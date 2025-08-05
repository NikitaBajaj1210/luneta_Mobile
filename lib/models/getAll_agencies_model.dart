class GetAllAgenciesModel {
  int? statusCode;
  String? message;
  List<AgenciesData>? data;

  GetAllAgenciesModel({this.statusCode, this.message, this.data});

  GetAllAgenciesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'] as int?; // Explicitly cast and allow null
    message = json['message'] as String?;   // Explicitly cast and allow null
    if (json['data'] != null) {
      data = <AgenciesData>[];
      json['data'].forEach((v) {
        if (v != null) { // Check if each item is not null
          data!.add(AgenciesData.fromJson(v as Map<String, dynamic>));
        }
      });
    } else {
      data = null; // Explicitly set to null if json['data'] is null
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgenciesData {
  String? id;
  String? name;
  dynamic? createdBy; // Changed from Null to dynamic? to handle null or any type
  dynamic? updatedBy; // Changed from Null to dynamic? to handle null or any type
  bool? isDeleted;
  String? createdOn;
  String? updatedOn;

  AgenciesData({
    this.id,
    this.name,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
  });

  AgenciesData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;          // Explicitly cast and allow null
    name = json['name'] as String?;      // Explicitly cast and allow null
    createdBy = json['createdBy'];       // Allow null or any value
    updatedBy = json['updatedBy'];       // Allow null or any value
    isDeleted = json['is_deleted'] as bool?; // Explicitly cast and allow null
    createdOn = json['created_on'] as String?; // Explicitly cast and allow null
    updatedOn = json['updated_on'] as String?; // Explicitly cast and allow null
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}