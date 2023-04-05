import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class DeleteLanguageAction extends ApiRequestAction<BaseModel> {
  final int languageId;

  DeleteLanguageAction(this.languageId);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/delete-language";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {"language_id": languageId};

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
