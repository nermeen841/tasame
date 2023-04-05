import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/messages/model/communications.dart';

class CommunicationActions extends ApiRequestAction<CommunicationsModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/active-communications";

  @override
  ResponseBuilder<CommunicationsModel> get responseBuilder =>
      (json) => CommunicationsModel.fromJson(json);
}
