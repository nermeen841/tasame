// ignore_for_file: prefer_typing_uninitialized_variables

class AllConsultantOffersModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  AllConsultantOffersModel(
      {this.message, this.data, this.status, this.statusCode});

  AllConsultantOffersModel.fromJson(Map<String, dynamic> json) {
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

class Offers {
  int? id;
  String? consultant;
  String? numConsults;
  String? price;

  Offers({this.id, this.consultant, this.numConsults, this.price});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultant = json['consultant'];
    numConsults = json['num_consults'];
    price = json['price'];
  }
}

class Appoinments {
  int? id;
  String? availableDate;
  List<AvailableHours>? availableHours;

  Appoinments({this.id, this.availableDate, this.availableHours});

  Appoinments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availableDate = json['available_date'];
    if (json['available_hours'] != null) {
      availableHours = <AvailableHours>[];
      json['available_hours'].forEach((v) {
        availableHours!.add(AvailableHours.fromJson(v));
      });
    }
  }
}

class AvailableHours {
  int? timeId;
  String? offerId;
  String? time;
  String? date;
  String? tutor;
  String? booked;

  AvailableHours(
      {this.timeId,
      this.offerId,
      this.time,
      this.date,
      this.tutor,
      this.booked});

  AvailableHours.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    offerId = json['offer_id'];
    time = json['time'];
    date = json['date'];
    tutor = json['tutor'];
    booked = json['booked'];
  }
}

class Languages {
  String? name;
  String? icon;
  String? rate;

  Languages({this.name, this.icon, this.rate});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    rate = json['rate'];
  }
}

class Data {
  int? id;
  String? name;
  var image;
  bool? isFav;
  String? rate;
  List<Languages>? languages;
  Data({
    this.id,
    this.name,
    this.image,
    this.languages,
    this.isFav,
    this.rate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
  }
}
