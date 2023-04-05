class AllRequestModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  AllRequestModel({this.message, this.data, this.status, this.statusCode});

  AllRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? user;
  String? tutor;
  String? message;
  String? createdAt;

  Data({this.id, this.user, this.tutor, this.message, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    tutor = json['tutor'];
    message = json['message'];
    createdAt = json['created_at'];
  }
}
