import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class LogoutAction extends ApiRequestAction<BaseModel> {
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/logout-account";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
