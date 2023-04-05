class AppIntroModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  AppIntroModel({this.message, this.data, this.status, this.statusCode});

  AppIntroModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? subtitle;
  String? image;

  Data({this.id, this.title, this.subtitle, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
  }
}
