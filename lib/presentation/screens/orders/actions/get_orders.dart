import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/orders/model/orders.dart';

import '../../../../core/constants/constants.dart';

class GetUserOrderActions extends ApiRequestAction<OrdersModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => (prefs.getString("user_type") == "consultant")
      ? "/consultant-orders"
      : "/student-orders";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<OrdersModel> get responseBuilder =>
      (json) => OrdersModel.fromJson(json);
}
