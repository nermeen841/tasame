import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/qustionare/model/quastionare.dart';

class GetQuastionareActions extends ApiRequestAction<QuastionarModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/questionnaires";

  @override
  ResponseBuilder<QuastionarModel> get responseBuilder =>
      (json) => QuastionarModel.fromJson(json);
}
