import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class EndRoomAction extends ApiRequestAction<BaseModel> {
  final int timeId;

  EndRoomAction(this.timeId);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  bool get authRequired => true;

  @override
  String get path => "/end-room";

  @override
  Map<String, dynamic> get toMap => {
        "time_id": timeId,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
