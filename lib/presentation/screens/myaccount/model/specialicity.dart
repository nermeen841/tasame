class SpecialicityModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  SpecialicityModel({this.message, this.data, this.status, this.statusCode});

  SpecialicityModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  List<Tutors>? tutors;

  Data({this.id, this.title, this.tutors});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['tutors'] != null) {
      tutors = <Tutors>[];
      json['tutors'].forEach((v) {
        tutors!.add(Tutors.fromJson(v));
      });
    }
  }
}

class Tutors {
  int? id;
  String? name;
  String? email;
  String? image;
  String? video;
  String? tutorCv;
  String? tutorBio;
  String? countryName;
  List<Languages>? languages;
  String? rate;
  bool? isFav;

  Tutors({
    this.id,
    this.name,
    this.email,
    this.image,
    this.video,
    this.tutorCv,
    this.tutorBio,
    this.countryName,
    this.languages,
    this.rate,
    this.isFav,
  });

  Tutors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    video = json['video'];
    tutorCv = json['tutor_cv'];
    tutorBio = json['tutor_bio'];
    countryName = json['countryName'];
    isFav = json['IsFav'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }

    rate = json['rate'];
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
