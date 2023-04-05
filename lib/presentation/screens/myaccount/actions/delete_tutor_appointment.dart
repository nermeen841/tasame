import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class DeleteTutorAppointmentAction extends ApiRequestAction<BaseModel> {
  final int timeId;

  DeleteTutorAppointmentAction(this.timeId);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/delete-appointment";
  @override
  Map<String, dynamic> get toMap => {
        "time_id": timeId,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
