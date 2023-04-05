import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class DeleteSpecialicityAction extends ApiRequestAction<BaseModel> {
  final int specialicityId;

  DeleteSpecialicityAction(this.specialicityId);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/delete-specialty";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {"specialty_id": specialicityId};

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
