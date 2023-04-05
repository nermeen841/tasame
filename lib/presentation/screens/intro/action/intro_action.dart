import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/intro/model/intro_model.dart';

class GetAppIntroAction extends ApiRequestAction<AppIntroModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/app-intro";

  @override
  ResponseBuilder<AppIntroModel> get responseBuilder =>
      (json) => AppIntroModel.fromJson(json);
}
