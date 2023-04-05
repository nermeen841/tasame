import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class AddNewOfferAction extends ApiRequestAction<BaseModel> {
  final String numofConsultant;
  final String price;

  AddNewOfferAction(this.numofConsultant, this.price);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/offers";

  @override
  Map<String, dynamic> get toMap => {
        "num_consults": numofConsultant,
        "price": price,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
