import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/qustionare/model/orders.dart';

class QuastionareOrdersAction extends ApiRequestAction<QuastionareOrdersModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/questionnair-orders";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<QuastionareOrdersModel> get responseBuilder =>
      (json) => QuastionareOrdersModel.fromJson(json);
}
