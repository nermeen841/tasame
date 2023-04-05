import 'package:api_request/api_request.dart';
import '../model/all_consultant_offer.dart';

class GetTutorOffersAction extends ApiRequestAction<AllConsultantOffersModel> {
  final int offerId;

  GetTutorOffersAction(this.offerId);
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/tutor-offers?offer_id=$offerId";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<AllConsultantOffersModel> get responseBuilder =>
      (json) => AllConsultantOffersModel.fromJson(json);
}
