import 'package:api_request/api_request.dart';
import 'package:zat/core/network/baseModel.dart';

class AddorRemoveFavouriteActoin extends ApiRequestAction<BaseModel> {
  final int tutorID;

  AddorRemoveFavouriteActoin(this.tutorID);
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/favourite";

  @override
  bool get authRequired => true;

  @override
  Map<String, dynamic> get toMap => {
        "tutor_id": tutorID,
      };

  @override
  ResponseBuilder<BaseModel> get responseBuilder =>
      (json) => BaseModel.fromJson(json);
}
