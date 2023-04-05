import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/messages/model/all_chat_model.dart';

class GetAllChatsAction extends ApiRequestAction<AllChatsModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  bool get authRequired => true;
  @override
  String get path => "/users-profile";

  @override
  ResponseBuilder<AllChatsModel> get responseBuilder =>
      (json) => AllChatsModel.fromJson(json);
}
