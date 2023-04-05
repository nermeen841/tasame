import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

class ResetPassowrdActions extends ApiRequestAction<UserModel> {
  final String password;

  ResetPassowrdActions(this.password);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/updatePassword";

  @override
  Map<String, dynamic> get toMap => {
        "password": password,
      };
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);
}
