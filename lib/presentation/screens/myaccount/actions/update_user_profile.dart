import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';

import '../../../../core/constants/constants.dart';

class UpdateUserProfileActions extends ApiRequestAction<UserModel> {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String birthdate;
  final int gender;

  UpdateUserProfileActions(this.name, this.phone, this.email, this.password,
      this.birthdate, this.gender);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/update-user-profile";

  @override
  bool get authRequired => true;
  @override
  Map<String, dynamic> get toMap => {
        "name": name,
        "mobile": phone,
        "email": email,
        "gender": gender.toString(),
        "password": password,
        "country_code": prefs.getString("country_code") ?? "",
        "birthday": birthdate
      };
  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (json) => UserModel.fromJson(json);
}
