class SuccessStoriesModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  SuccessStoriesModel({this.message, this.data, this.status, this.statusCode});

  SuccessStoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? country;
  String? video;
  String? job;
  String? views;
  String? description;

  Data(
      {this.id,
      this.name,
      this.country,
      this.video,
      this.job,
      this.views,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    video = json['video'];
    job = json['job'];
    views = json['views'];
    description = json['description'];
  }
}
