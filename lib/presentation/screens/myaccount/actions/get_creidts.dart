import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/myaccount/model/credits.dart';

class GetCreditsAction extends ApiRequestAction<CreidtsModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/credits";

  @override
  ResponseBuilder<CreidtsModel> get responseBuilder =>
      (json) => CreidtsModel.fromJson(json);
}
