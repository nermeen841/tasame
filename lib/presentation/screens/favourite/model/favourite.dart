class FavouriteModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  FavouriteModel({this.message, this.data, this.status, this.statusCode});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? image;
  List<Languages>? languages;
  String? rate;

  Data({this.id, this.name, this.image, this.languages, this.rate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
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
  String? name;
  String? icon;

  Languages({this.name, this.icon});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }
}
