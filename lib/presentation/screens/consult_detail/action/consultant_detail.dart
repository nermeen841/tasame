import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/consult_detail/model/consultantsDetail.dart';

class GetConsultantDetailAction
    extends ApiRequestAction<ConsultantDetailModel> {
  final int consultantId;

  GetConsultantDetailAction(this.consultantId);

  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/getTutors/$consultantId";

  @override
  bool get authRequired => true;

  @override
  ResponseBuilder<ConsultantDetailModel> get responseBuilder =>
      (json) => ConsultantDetailModel.fromJson(json);
}
