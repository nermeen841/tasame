import 'package:api_request/api_request.dart';
import '../model/all_request.dart';

class AllRequestAction extends ApiRequestAction<AllRequestModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/order-appointment";
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<AllRequestModel> get responseBuilder =>
      (json) => AllRequestModel.fromJson(json);
}
