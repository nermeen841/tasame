import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class TutorRattingAction extends ApiRequestAction<BaseModel> {
  final int tutorId;
  final double rate;
  final String comment;

  TutorRattingAction(this.tutorId, this.rate, this.comment);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/add-rating";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {
        "tutor_id": tutorId,
        "rate": rate,
        "comment": comment,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
