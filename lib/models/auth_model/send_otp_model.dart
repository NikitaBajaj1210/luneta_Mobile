class SendOtpModel {
  String? email;

  SendOtpModel({this.email});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class SendOtpResponse {
  int? statusCode;
  String? message;
  bool? data;

  SendOtpResponse({this.statusCode, this.message, this.data});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
} 