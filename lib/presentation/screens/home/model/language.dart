class LanguageModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  LanguageModel({this.message, this.data, this.status, this.statusCode});

  LanguageModel.fromJson(Map<String, dynamic> json) {
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
  dynamic icon;

  Data({this.id, this.name, this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }
}
