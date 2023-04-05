import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

import '../../../../core/constants/constants.dart';

class LoginActions extends ApiRequestAction<UserModel> {
  final String phone;
  final String password;

  LoginActions(this.phone, this.password);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/login";

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);

  @override
  Map<String, dynamic> get toMap => {
        "mobile": phone,
        "password": password,
        "country_code": prefs.getString("country_code").toString(),
      };
}
