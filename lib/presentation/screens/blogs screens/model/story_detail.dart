class SuccessStoryDetailModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  SuccessStoryDetailModel(
      {this.message, this.data, this.status, this.statusCode});

  SuccessStoryDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? video;
  int? views;
  String? name;
  String? job;
  String? description;

  Data({
    this.id,
    this.video,
    this.views,
    this.name,
    this.job,
    this.description,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    views = json['views'];
    name = json['name'];
    job = json['job'];
    description = json['description'];
  }
}
