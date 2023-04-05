import 'package:api_request/api_request.dart';
import '../../../../core/network/baseModel.dart';

class SendPromoCodeAction extends ApiRequestAction<BaseModel> {
  final String promoCode;

  SendPromoCodeAction(this.promoCode);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/orders";
  @override
  Map<String, dynamic> get toMap => {
        "promotionCode": promoCode,
        "payment_type_id": 2,
        "video_record_option": 0,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
