class GetAllRankModel {
  int? statusCode;
  String? message;
  List<RankData>? data;

  GetAllRankModel({this.statusCode, this.message, this.data});

  GetAllRankModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      statusCode = null;
      message = null;
      data = null;
      return;
    }
    statusCode = json['statusCode'] as int?;
    message = json['message'] as String?;
    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((v) => RankData.fromJson(v as Map<String, dynamic>?))
          .where((v) => v != null)
          .cast<RankData>()
          .toList();
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['statusCode'] = statusCode;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class RankData {
  String? id;
  String? rankName;
  int? orderId;
  String? createdAt; // Changed from Null? to String?
  String? updatedAt; // Changed from Null? to String?
  String? createdBy; // Changed from Null? to String?
  String? updatedBy; // Changed from Null? to String?
  int? isDeleted;
  int? multiplier;

  RankData({
    this.id,
    this.rankName,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.multiplier,
  });

  RankData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      id = null;
      rankName = null;
      orderId = null;
      createdAt = null;
      updatedAt = null;
      createdBy = null;
      updatedBy = null;
      isDeleted = null;
      multiplier = null;
      return;
    }
    id = json['id'] as String?;
    rankName = json['rank_name'] as String?;
    orderId = json['orderId'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    createdBy = json['created_by'] as String?;
    updatedBy = json['updated_by'] as String?;
    isDeleted = json['is_deleted'] as int?;
    multiplier = json['multiplier'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rank_name'] = rankName;
    data['orderId'] = orderId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['is_deleted'] = isDeleted;
    data['multiplier'] = multiplier;
    return data;
  }
}