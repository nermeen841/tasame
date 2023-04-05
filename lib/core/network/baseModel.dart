// ignore_for_file: file_names

class BaseModel {
  String? message;
  bool? status;
  int? statusCode;

  BaseModel({this.message, this.status, this.statusCode});

  BaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
  }
}
