import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class DeleteCreditsAction extends ApiRequestAction<BaseModel> {
  final int creditId;

  DeleteCreditsAction(this.creditId);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/delete-credit";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {"credit_id": creditId};

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
