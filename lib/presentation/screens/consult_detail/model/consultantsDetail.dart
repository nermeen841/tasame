// ignore_for_file: file_names

class ConsultantDetailModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  ConsultantDetailModel(
      {this.message, this.data, this.status, this.statusCode});

  ConsultantDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? birthday;
  String? gender;
  dynamic image;
  dynamic video;
  String? cv;
  String? countryName;
  bool? featured;
  bool? isRegistered;
  List<Offers>? offers;
  List<Appoinments>? appoinments;
  List<Credits>? credits;
  List<Specialties>? specialties;
  String? creditsFile;
  List<Languages>? languages;
  List<Comments>? comments;
  String? durationConsultation;
  bool? isFav;
  String? rate;
  int? countBooking;
  int? countUsers;
  int? countSessions;
  int? countPackages;
  String? tutorBio;

  Data({
    this.id,
    this.countryName,
    this.name,
    this.email,
    this.mobile,
    this.birthday,
    this.gender,
    this.image,
    this.video,
    this.credits,
    this.cv,
    this.creditsFile,
    this.featured,
    this.isRegistered,
    this.offers,
    this.appoinments,
    this.languages,
    this.durationConsultation,
    this.specialties,
    this.isFav,
    this.rate,
    this.countBooking,
    this.countUsers,
    this.countSessions,
    this.comments,
    this.countPackages,
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
    creditsFile = json['credits_file'];
    countryName = json['countryName'];
    countPackages = json['countpackages'];
    featured = json['featured'];
    isRegistered = json['IsRegistered'];
    tutorBio = json['tutor_bio'];
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
    if (json['credits'] != null) {
      credits = <Credits>[];
      json['credits'].forEach((v) {
        credits!.add(Credits.fromJson(v));
      });
    }
    if (json['appoinments'] != null) {
      appoinments = <Appoinments>[];
      json['appoinments'].forEach((v) {
        appoinments!.add(Appoinments.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }

    durationConsultation = json['duration_consultation'];
    isFav = json['IsFav'];
    rate = json['rate'];
    countBooking = json['countbooking'];
    countUsers = json['countusers'];
    countSessions = json['countsessions'];
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

class Comments {
  String? user;
  String? comment;
  String? rate;
  String? date;

  Comments({this.user, this.comment, this.rate, this.date});

  Comments.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    comment = json['comment'];
    rate = json['rate'];
    date = json['date'];
  }
}

class Credits {
  int? id;
  String? name;

  Credits({this.id, this.name});

  Credits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
