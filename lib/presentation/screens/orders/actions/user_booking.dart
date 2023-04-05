import 'package:api_request/api_request.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/orders/model/user_booking.dart';

class UserBookingAction extends ApiRequestAction<UserBookingModel> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => (prefs.getString("user_type") == "user")
      ? "/user-bookings"
      : "/consultant-bookings";
  @override
  bool get authRequired => true;
  @override
  ResponseBuilder<UserBookingModel> get responseBuilder =>
      (json) => UserBookingModel.fromJson(json);
}
