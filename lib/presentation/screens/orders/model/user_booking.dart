class UserBookingModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  UserBookingModel({this.message, this.data, this.status, this.statusCode});

  UserBookingModel.fromJson(Map<String, dynamic> json) {
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
  int? timeId;
  String? offerId;
  String? time;
  String? date;
  String? tutor;
  String? user;
  String? booked;

  Data(
      {this.timeId,
      this.offerId,
      this.time,
      this.date,
      this.tutor,
      this.booked});

  Data.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    offerId = json['offer_id'];
    time = json['time'];
    date = json['date'];
    tutor = json['tutor'];
    booked = json['booked'];
    user = json['user_name'];
  }
}
