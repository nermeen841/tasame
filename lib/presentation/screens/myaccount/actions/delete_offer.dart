import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class DeleteOfferAction extends ApiRequestAction<BaseModel> {
  final int offerID;

  DeleteOfferAction(this.offerID);
  @override
  RequestMethod get method => RequestMethod.DELETE;

  @override
  String get path => "/offers/$offerID";
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
