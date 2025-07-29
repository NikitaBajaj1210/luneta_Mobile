class CountryModel {
  String? name;
  String? code;
  String? dialCode;
  List<String>? nationalities;

  CountryModel({
    this.name,
    this.code,
    this.dialCode,
    this.nationalities,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    dialCode = json['dial_code'];
    nationalities = json['nationalities'] != null 
        ? List<String>.from(json['nationalities'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['dial_code'] = dialCode;
    data['nationalities'] = nationalities;
    return data;
  }
} 