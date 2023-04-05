import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/orders/model/make_order_model.dart';

class MakeOrderAction extends ApiRequestAction<MakeOrderModel> {
  final int offerID;
  final int paymentTypeId;

  MakeOrderAction(this.offerID, this.paymentTypeId);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  bool get authRequired => true;
  @override
  String get path => "/orders";

  @override
  Map<String, dynamic> get toMap => {
        "offer_id": offerID,
        "payment_type_id": paymentTypeId,
        "video_record_option": 0
      };
  @override
  ResponseBuilder<MakeOrderModel> get responseBuilder =>
      (json) => MakeOrderModel.fromJson(json);
}
