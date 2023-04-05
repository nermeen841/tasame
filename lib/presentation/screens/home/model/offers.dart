// ignore_for_file: prefer_typing_uninitialized_variables
class OffersSliderModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  OffersSliderModel({this.message, this.data, this.status, this.statusCode});

  OffersSliderModel.fromJson(Map<String, dynamic> json) {
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
  var consultantId;
  String? consultant;
  String? numConsults;
  String? price;
  String? image;
  String? admin;

  Data(
      {this.id,
      this.consultantId,
      this.consultant,
      this.numConsults,
      this.price,
      this.image,
      this.admin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultantId = json['consultant_id'];
    consultant = json['consultant'];
    numConsults = json['num_consults'];
    price = json['price'];
    image = json['image'];
    admin = json['admin'];
  }
}
