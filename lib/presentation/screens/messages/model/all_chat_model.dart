class AllChatsModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  AllChatsModel({this.message, this.data, this.status, this.statusCode});

  AllChatsModel.fromJson(Map<String, dynamic> json) {
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

  Data({
    this.id,
    this.name,
    this.image,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    image = json['image'];
  }
}
