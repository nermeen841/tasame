class QuastionaireResultModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  QuastionaireResultModel(
      {this.message, this.data, this.status, this.statusCode});

  QuastionaireResultModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? pdf;

  Data({this.id, this.pdf});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pdf = json['pdf'];
  }
}
