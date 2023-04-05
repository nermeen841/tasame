import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

class ConfirmCodeActions extends ApiRequestAction<UserModel> {
  final String code;

  ConfirmCodeActions(this.code);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/confirmPasswordCode";

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);

  @override
  bool get authRequired => true;
  @override
  Map<String, dynamic> get toMap => {
        "code": code,
      };
}
