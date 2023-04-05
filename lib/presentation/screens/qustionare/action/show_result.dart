import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/qustionare/model/quastionare_result.dart';

class ShowResultQuationareAction
    extends ApiRequestAction<QuastionaireResultModel> {
  final int quastionareId;
  final int result;

  ShowResultQuationareAction(this.quastionareId, this.result);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/make-questionnaire";
  @override
  bool get authRequired => true;
  @override
  Map<String, dynamic> get toMap => {
        "questionnaire_id": quastionareId,
        "result": result,
      };
  @override
  ResponseBuilder<QuastionaireResultModel> get responseBuilder =>
      (json) => QuastionaireResultModel.fromJson(json);
}
