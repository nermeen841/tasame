import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/info/model/custom_page.dart';

class CustomPageActions extends ApiRequestAction<CustomPagesModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/custom-pages";

  @override
  ResponseBuilder<CustomPagesModel> get responseBuilder =>
      (json) => CustomPagesModel.fromJson(json);
}
