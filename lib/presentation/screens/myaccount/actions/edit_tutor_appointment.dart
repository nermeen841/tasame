import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class EditTutorAppointmentAction extends ApiRequestAction<BaseModel> {
  final int timeId;
  final String availableHours;

  EditTutorAppointmentAction(this.timeId, this.availableHours);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/edit-appointment";

  @override
  Map<String, dynamic> get toMap => {
        "time_id": timeId,
        "available_hours": availableHours,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
