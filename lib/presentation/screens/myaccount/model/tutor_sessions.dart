// ignore_for_file: prefer_typing_uninitialized_variables

class TutorSessionsModel {
  int? sessionCount;
  var totalFees;
  var netFees;

  TutorSessionsModel({this.sessionCount, this.totalFees, this.netFees});

  TutorSessionsModel.fromJson(Map<String, dynamic> json) {
    sessionCount = json['session-count'];
    totalFees = json['total-fees'];
    netFees = json['net-fees'];
  }
}
