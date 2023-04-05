import 'package:api_request/api_request.dart';

import '../model/offers.dart';

class AllOffersSliderAction extends ApiRequestAction<OffersSliderModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/offers";

  @override
  ResponseBuilder<OffersSliderModel> get responseBuilder =>
      (json) => OffersSliderModel.fromJson(json);
}
