import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class AddNewAppointmnetAction extends ApiRequestAction<BaseModel> {
  final String startDate;
  final String endDate;
  final String time;

  AddNewAppointmnetAction(
    this.startDate,
    this.endDate,
    this.time,
  );

  @override
  RequestMethod get method => RequestMethod.POST;
  @override
  bool get authRequired => true;

  @override
  String get path => "/tutor-appointment";

  @override
  Map<String, dynamic> get toMap => {
        "from_date": startDate,
        "end_date": endDate,
        "available_hours": time,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
