import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/home/model/all_consultant.dart';

class GetAllConsultants extends ApiRequestAction<AllConsultantModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/getTutors?offset=0&limit=1000";
  @override
  bool get authRequired => true;

  @override
  ResponseBuilder<AllConsultantModel> get responseBuilder =>
      (json) => AllConsultantModel.fromJson(json);
}
