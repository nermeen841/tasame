import 'package:api_request/api_request.dart';

import '../../../../core/constants/constants.dart';
import '../model/questions.dart';

class GetQuestionActions extends ApiRequestAction<QuestionsModel> {
  final int quastionareID;

  GetQuestionActions(this.quastionareID);
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path =>
      "/questionnaires/$quastionareID?lang=${prefs.getString("lang").toString()}";

  @override
  ResponseBuilder<QuestionsModel> get responseBuilder =>
      (json) => QuestionsModel.fromJson(json);
}
