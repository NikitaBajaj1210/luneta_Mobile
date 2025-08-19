class CargoResponse {
  final int? statusCode;
  final String? message;
  final List<CargoData>? data;

  CargoResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory CargoResponse.fromJson(Map<String, dynamic> json) {
    return CargoResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CargoData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CargoData {
  final String? id;
  final String? name;

  CargoData({
    this.id,
    this.name,
  });

  factory CargoData.fromJson(Map<String, dynamic> json) {
    return CargoData(
      id: json['id'],
      name: json['name'],
    );
  }
}
