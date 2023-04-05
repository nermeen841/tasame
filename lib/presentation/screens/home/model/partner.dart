class PartnerModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  PartnerModel({this.message, this.data, this.status, this.statusCode});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? name;
  String? logo;
  String? link;

  Data({this.id, this.name, this.logo, this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    link = json['link'];
  }
}
