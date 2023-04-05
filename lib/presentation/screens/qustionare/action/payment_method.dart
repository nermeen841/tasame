import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/qustionare/model/payment_types.dart';

class PaymentTypesActions extends ApiRequestAction<PaymentTypesModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/payment-types";

  @override
  ResponseBuilder<PaymentTypesModel> get responseBuilder =>
      (json) => PaymentTypesModel.fromJson(json);
}
