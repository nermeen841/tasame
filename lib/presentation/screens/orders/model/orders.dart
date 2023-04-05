class OrdersModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  OrdersModel({this.message, this.data, this.status, this.statusCode});

  OrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? consultant;
  String? consultationDuration;
  String? payment;
  String? price;
  String? numConsultation;
  String? remainingConsultations;

  Data(
      {this.id,
      this.userId,
      this.user,
      this.consultant,
      this.consultationDuration,
      this.payment,
      this.price,
      this.numConsultation,
      this.remainingConsultations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'];
    consultant = json['consultant'];
    consultationDuration = json['ConsultationDuration'];
    payment = json['payment'];
    price = json['price'];
    numConsultation = json['numConsultation'];
    remainingConsultations = json['remaining_consultations'];
  }
}
