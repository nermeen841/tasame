class CountryModel {
  String? message;
  List<Country>? data;
  bool? status;
  int? statusCode;

  CountryModel({this.message, this.data, this.status, this.statusCode});

  CountryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Country>[];
      json['data'].forEach((v) {
        data!.add(Country.fromJson(v));
      });
    }
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Country {
  int? id;
  String? image;
  String? name;
  String? code;
  String? isoCode;
  String? currencyCode;
  String? countNum;
  String? active;

  Country(
      {this.id,
      this.image,
      this.name,
      this.code,
      this.isoCode,
      this.currencyCode,
      this.countNum,
      this.active});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    code = json['code'];
    isoCode = json['iso_code'];
    currencyCode = json['currency_code'];
    countNum = json['count_num'];
    active = json['active'];
  }
}
