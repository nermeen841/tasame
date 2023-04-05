// ignore_for_file: prefer_typing_uninitialized_variables

class QuastionareOrdersModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  QuastionareOrdersModel(
      {this.message, this.data, this.status, this.statusCode});

  QuastionareOrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? user;
  int? questionnairId;
  String? questionnairTitle;
  String? payment;
  var price;
  String? pdf;
  String? status;

  Data(
      {this.id,
      this.userId,
      this.user,
      this.questionnairId,
      this.questionnairTitle,
      this.payment,
      this.price,
      this.pdf,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'];
    questionnairId = json['questionnair_id'];
    questionnairTitle = json['questionnair_title'];
    payment = json['payment'];
    price = json['price'];
    pdf = json['pdf'];
    status = json['status'];
  }
}
