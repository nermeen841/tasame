// ignore_for_file: prefer_typing_uninitialized_variables

class TutorProfileModel {
  String? message;
  Data? data;
  bool? status;
  String? accessToken;
  String? tokenType;
  int? statusCode;

  TutorProfileModel(
      {this.message,
      this.data,
      this.status,
      this.accessToken,
      this.tokenType,
      this.statusCode});

  TutorProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? mobile;
  String? birthday;
  var gender;
  String? image;
  String? video;
  String? cv;
  String? countryName;
  List<Offers>? offers;
  List<Appoinments>? appoinments;
  List<Booking>? booking;
  List<Languages>? languages;
  List<Credits>? credits;
  List<Specialties>? specialties;
  String? bankName;
  String? countryBankName;
  String? accountNo;
  String? ipan;
  String? swiftCode;
  String? position;
  String? tutorBio;

  Data({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.birthday,
    this.gender,
    this.image,
    this.offers,
    this.appoinments,
    this.booking,
    this.countryName,
    this.cv,
    this.specialties,
    this.languages,
    this.video,
    this.credits,
    this.accountNo,
    this.bankName,
    this.countryBankName,
    this.ipan,
    this.position,
    this.swiftCode,
    this.tutorBio,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    birthday = json['birthday'];
    gender = json['gender'];
    image = json['image'];
    video = json['video'];
    cv = json['tutor_cv'];
    countryName = json['countryName'];
    bankName = json['bankName'];
    countryBankName = json['countryBankName'];
    accountNo = json['accountNo'];
    ipan = json['ipan'];
    swiftCode = json['swiftCode'];
    position = json['position'];
    tutorBio = json['tutor_bio'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['credits'] != null) {
      credits = <Credits>[];
      json['credits'].forEach((v) {
        credits!.add(Credits.fromJson(v));
      });
    }
    if (json['specialties'] != null) {
      specialties = <Specialties>[];
      json['specialties'].forEach((v) {
        specialties!.add(Specialties.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    if (json['appoinments'] != null) {
      appoinments = <Appoinments>[];
      json['appoinments'].forEach((v) {
        appoinments!.add(Appoinments.fromJson(v));
      });
    }
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(Booking.fromJson(v));
      });
    }
  }
}

class Credits {
  int? id;
  String? name;
  String? creditFile;
  Credits({this.id, this.name, this.creditFile});

  Credits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    creditFile = json['credit_file'];
  }
}

class Specialties {
  int? id;
  String? name;

  Specialties({this.id, this.name});

  Specialties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Languages {
  int? id;
  String? name;
  String? icon;
  String? rate;

  Languages({this.name, this.icon, this.rate, this.id});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    rate = json['rate'];
  }
}

class Offers {
  int? id;
  String? consultant;
  var numConsults;
  var price;

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
  String? time;
  String? booked;

  AvailableHours({this.timeId, this.time, this.booked});

  AvailableHours.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    time = json['time'];
    booked = json['booked'];
  }
}

class Booking {
  int? timeId;
  String? offerId;
  String? time;
  String? date;
  String? tutor;
  String? userId;
  String? userName;
  String? booked;

  Booking(
      {this.timeId,
      this.offerId,
      this.time,
      this.date,
      this.tutor,
      this.userId,
      this.userName,
      this.booked});

  Booking.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    offerId = json['offer_id'];
    time = json['time'];
    date = json['date'];
    tutor = json['tutor'];
    userId = json['user_id'];
    userName = json['user_name'];
    booked = json['booked'];
  }
}
