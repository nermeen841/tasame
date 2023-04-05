class CustomPagesModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  CustomPagesModel({this.message, this.data, this.status, this.statusCode});

  CustomPagesModel.fromJson(Map<String, dynamic> json) {
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
  String? body;
  String? image;

  Data({this.id, this.title, this.body, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
  }
}
