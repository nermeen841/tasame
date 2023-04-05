import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';
import 'package:zat/presentation/screens/myaccount/model/tutuor_model.dart';

class GetUserProfileActions extends ApiRequestAction<UserModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/profile";
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);
}

class GetTutorProfileAction extends ApiRequestAction<TutorProfileModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/tutor-profile";
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<TutorProfileModel> get responseBuilder =>
      (json) => TutorProfileModel.fromJson(json);
}
