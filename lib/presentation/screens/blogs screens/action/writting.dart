import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/blogs%20screens/model/writting.dart';

class GetWrittingAction extends ApiRequestAction<WrittingModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/blogs";
  // (prefs.getString("user_type") == "consultant")
  //     ? "/consultant-blogs"
  //     : "/blogs";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<WrittingModel> get responseBuilder =>
      (json) => WrittingModel.fromJson(json);
}
