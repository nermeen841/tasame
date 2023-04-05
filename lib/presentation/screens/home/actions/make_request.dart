import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class MakeRequestAction extends ApiRequestAction<BaseModel> {
  final int tutorId;
  final String message;

  MakeRequestAction(this.tutorId, this.message);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/order-appointment";
  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {
        "tutor_id": tutorId,
        "message": message,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
