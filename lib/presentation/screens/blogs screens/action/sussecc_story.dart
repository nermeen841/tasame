import 'package:api_request/api_request.dart';
import '../model/success_stories.dart';

class GetSuccessStories extends ApiRequestAction<SuccessStoriesModel> {
  final int isAdmin;

  GetSuccessStories(this.isAdmin);
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/stories?admin=$isAdmin";

  @override
  ResponseBuilder<SuccessStoriesModel> get responseBuilder =>
      (json) => SuccessStoriesModel.fromJson(json);
}
