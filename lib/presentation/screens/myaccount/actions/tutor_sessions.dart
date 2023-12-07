import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/myaccount/model/tutor_sessions.dart';

class TutorSessionAction extends ApiRequestAction<TutorSessionsModel> {
  final String startDate;
  final String endDate;

  TutorSessionAction(this.startDate, this.endDate);
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/tutor-sessions?start_at=$startDate&end_at=$endDate";

  @override
  bool get authRequired => true;

  @override
  ResponseBuilder<TutorSessionsModel> get responseBuilder =>
      (json) => TutorSessionsModel.fromJson(json);
}
