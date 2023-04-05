import 'package:api_request/api_request.dart';
import '../model/make_quastionare_ordder.dart';

class MakeQuestionareActions
    extends ApiRequestAction<MakeQuastionareOrderModel> {
  final int quastionareId;
  final int paymentType;

  MakeQuestionareActions(this.quastionareId, this.paymentType);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/make-questionnaireorder";

  @override
  Map<String, dynamic> get toMap => {
        "questionnair_id": quastionareId,
        "payment_type_id": paymentType,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<MakeQuastionareOrderModel> get responseBuilder =>
      (json) => MakeQuastionareOrderModel.fromJson(json);
}
