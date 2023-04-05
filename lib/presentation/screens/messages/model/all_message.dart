class AllMessagesModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  AllMessagesModel({this.message, this.data, this.status, this.statusCode});

  AllMessagesModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? senderId;
  String? message;
  String? createdAt;

  Data({this.id, this.userId, this.senderId, this.message, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    senderId = json['senderId'];
    message = json['message'];
    createdAt = json['created_at'];
  }
}
