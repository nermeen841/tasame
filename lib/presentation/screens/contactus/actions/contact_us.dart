import 'package:api_request/api_request.dart';
import '../../../../core/network/baseModel.dart';

class ContactusActions extends ApiRequestAction<BaseModel> {
  final String name;
  final String email;
  final String phone;
  final String message;

  ContactusActions(this.name, this.email, this.phone, this.message);

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path =>
      "/contact-us?name=$name&email=$email&mobile=$phone&message=$message";

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
