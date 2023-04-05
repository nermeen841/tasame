import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/contactus/model/setting.dart';

class SettingAcyions extends ApiRequestAction<SettingModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/settings";

  @override
  ResponseBuilder<SettingModel> get responseBuilder =>
      (json) => SettingModel.fromJson(json);
}
