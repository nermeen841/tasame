import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class CancelAppointmentAction extends ApiRequestAction<BaseModel> {
  final int timeId;

  CancelAppointmentAction(this.timeId);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/cancel-appointment";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {
        "time_id": timeId,
      };

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
