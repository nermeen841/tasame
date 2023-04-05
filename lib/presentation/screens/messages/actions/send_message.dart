import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class SendMessageAction extends ApiRequestAction<BaseModel> {
  final int recieverId;
  final String message;

  SendMessageAction(this.recieverId, this.message);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  bool get authRequired => true;
  @override
  String get path => "/store-message";

  @override
  Map<String, dynamic> get toMap => {
        "id": recieverId,
        "message": message,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
