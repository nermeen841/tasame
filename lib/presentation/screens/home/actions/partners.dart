import 'package:api_request/api_request.dart';

import '../model/partner.dart';

class PartnerActions extends ApiRequestAction<PartnerModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/partners";

  @override
  ResponseBuilder<PartnerModel> get responseBuilder =>
      (json) => PartnerModel.fromJson(json);
}
