// ignore_for_file: non_constant_identifier_names

import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class BookApointmentAction extends ApiRequestAction<BaseModel> {
  final String available_date;
  final String available_hours;
  final int tutor_id;

  BookApointmentAction(
      this.available_date, this.available_hours, this.tutor_id);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/book-appointment";

  @override
  bool get authRequired => true;
  @override
  Map<String, dynamic> get toMap => {
        "available_date": available_date,
        "available_hours": available_hours,
        "tutor_id": tutor_id,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
