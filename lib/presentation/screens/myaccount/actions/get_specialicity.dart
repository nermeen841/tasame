import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/myaccount/model/specialicity.dart';

class GetSpecialicityAction extends ApiRequestAction<SpecialicityModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/specialties";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<SpecialicityModel> get responseBuilder =>
      (json) => SpecialicityModel.fromJson(json);
}
