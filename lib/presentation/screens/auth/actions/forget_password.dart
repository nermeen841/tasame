import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

import '../../../../core/constants/constants.dart';

class ForgetPasswordActions extends ApiRequestAction<UserModel> {
  final String phone;

  ForgetPasswordActions(this.phone);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/forgetPassword";

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);

  @override
  Map<String, dynamic> get toMap => {
        "mobile": phone,
        "country_code": prefs.getString("country_code").toString(),
      };
}
