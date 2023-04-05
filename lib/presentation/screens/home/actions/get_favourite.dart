import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/favourite/model/favourite.dart';

class GetFavouriteAction extends ApiRequestAction<FavouriteModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "/favourite";

  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<FavouriteModel> get responseBuilder =>
      (json) => FavouriteModel.fromJson(json);
}
