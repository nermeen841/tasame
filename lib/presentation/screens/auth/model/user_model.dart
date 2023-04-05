// ignore_for_file: prefer_typing_uninitialized_variables

class UserModel {
  String? message;
  Data? data;
  bool? status;
  String? accessToken;
  String? tokenType;
  int? statusCode;

  UserModel(
      {this.message,
      this.data,
      this.status,
      this.accessToken,
      this.tokenType,
      this.statusCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? birthday;
  var gender;
  var roleId;
  String? countryName;
  String? countryCode;
  var passCode;
  var rate;
  String? consultingCount;
  List<Bookings>? bookings;

  Data(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.image,
      this.birthday,
      this.gender,
      this.roleId,
      this.countryName,
      this.countryCode,
      this.passCode,
      this.rate,
      this.consultingCount,
      this.bookings});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    birthday = json['birthday'];
    gender = json['gender'];
    roleId = json['role_id'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    passCode = json['passCode'];
    rate = json['rate'];
    consultingCount = json['consulting_count'];
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }
}

class Bookings {
  int? timeId;
  String? offerId;
  String? time;
  String? date;
  String? tutor;
  String? booked;

  Bookings(
      {this.timeId,
      this.offerId,
      this.time,
      this.date,
      this.tutor,
      this.booked});

  Bookings.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    offerId = json['offer_id'];
    time = json['time'];
    date = json['date'];
    tutor = json['tutor'];
    booked = json['booked'];
  }
}
