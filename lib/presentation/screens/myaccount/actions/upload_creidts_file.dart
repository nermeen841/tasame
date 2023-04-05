import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

import '../widget/select_credits.dart';

class UploadCreditsFile extends ApiRequestAction<BaseModel> {
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/add-credit-image";
  @override
  bool get authRequired => true;
  @override
  ContentDataType? get contentDataType => ContentDataType.formData;
  @override
  Map<String, dynamic> get toMap => {
        "image": SelectCreditsItem.filePathApi,
      };
  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
