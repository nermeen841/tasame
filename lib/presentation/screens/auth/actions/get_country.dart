import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/country.dart';

class GetCountryActions extends ApiRequestAction<CountryModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/countries";

  @override
  ResponseBuilder<CountryModel> get responseBuilder =>
      (json) => CountryModel.fromJson(json);
}
