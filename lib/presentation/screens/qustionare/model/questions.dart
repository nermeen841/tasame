class QuestionsModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  QuestionsModel({this.message, this.data, this.status, this.statusCode});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<Answers>? answers;

  Questions({this.id, this.question, this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }
}

class Answers {
  int? id;
  String? title;
  String? index;

  Answers({this.id, this.title, this.index});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    index = json['index'];
  }
}
