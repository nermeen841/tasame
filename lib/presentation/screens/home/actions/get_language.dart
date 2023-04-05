import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/home/model/language.dart';

class GetLanguageAction extends ApiRequestAction<LanguageModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/languages";

  @override
  ResponseBuilder<LanguageModel> get responseBuilder =>
      (json) => LanguageModel.fromJson(json);
}
