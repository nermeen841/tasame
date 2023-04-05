import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/blogs%20screens/model/story_detail.dart';

class GetSuccessStoryDetailAction
    extends ApiRequestAction<SuccessStoryDetailModel> {
  final int storyId;

  GetSuccessStoryDetailAction(this.storyId);

  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/stories/$storyId";

  @override
  ResponseBuilder<SuccessStoryDetailModel> get responseBuilder =>
      (json) => SuccessStoryDetailModel.fromJson(json);
}
