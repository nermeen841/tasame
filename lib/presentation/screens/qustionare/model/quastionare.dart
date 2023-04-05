class QuastionarModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? statusCode;

  QuastionarModel({this.message, this.data, this.status, this.statusCode});

  QuastionarModel.fromJson(Map<String, dynamic> json) {
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
  String? price;
  List<Questions>? questions;

  Data({this.id, this.title, this.price, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }
}

class Questions {
  int? id;
  String? question;

  Questions({
    this.id,
    this.question,
  });

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
  }
}
