class CommunicationsModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  CommunicationsModel({this.message, this.data, this.status, this.statusCode});

  CommunicationsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  int? id;
  String? name;
  String? active;

  Data({this.id, this.name, this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
  }
}




// class CommunicationsModel {
//   List<Data>? data;

//   CommunicationsModel({this.data});

//   CommunicationsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   String? active;

//   Data({this.id, this.name, this.active});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     active = json['active'];
//   }
// }
