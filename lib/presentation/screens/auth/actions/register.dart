import 'package:api_request/api_request.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

class RegisterActions extends ApiRequestAction<UserModel> {
  final String mobile;
  final String email;
  final String name;
  final String password;
  final int roleId;
  final int gender;

  RegisterActions(this.mobile, this.email, this.name, this.password,
      this.roleId, this.gender);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/register";

  @override
  Map<String, dynamic> get toMap => {
        "mobile": mobile,
        "password": password,
        "gender": gender.toString(),
        "country_code": prefs.getString("country_code").toString(),
        "name": name,
        "email": email,
        "role_id": roleId.toString(),
      };

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);
}
