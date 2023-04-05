class WrittingModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  WrittingModel({this.message, this.data, this.status, this.statusCode});

  WrittingModel.fromJson(Map<String, dynamic> json) {
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
  String? tutor;
  String? description;
  String? image;
  String? date;
  String? views;

  Data({
    this.id,
    this.name,
    this.tutor,
    this.description,
    this.image,
    this.date,
    this.views,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tutor = json['tutor'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    views = json['views'];
  }
}
