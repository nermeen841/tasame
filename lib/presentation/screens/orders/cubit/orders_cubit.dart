// ignore_for_file: depend_on_referenced_packages, avoid_print, deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/orders/actions/get_orders.dart';
import 'package:zat/presentation/screens/orders/actions/make_order_action.dart';
import 'package:zat/presentation/screens/orders/actions/send_promo_code.dart';
import 'package:zat/presentation/screens/orders/actions/user_booking.dart';
import 'package:zat/presentation/screens/orders/model/make_order_model.dart';
import 'package:zat/presentation/screens/orders/model/orders.dart';
import 'package:zat/presentation/screens/orders/model/user_booking.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  OrdersModel? ordersModel;
  getUserOrders() async {
    emit(GetOrderLoadingState());
    await GetUserOrderActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetOrderErrorState());
            },
            (r) {
              ordersModel = r;
              emit(GetOrderSuccessState());
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////////
  MakeOrderModel? makeOrderModel;
  postMakeOrder({
    required int offerID,
    required int paymentTypeId,
  }) async {
    emit(MakeOrderLoadingState());
    await MakeOrderAction(offerID, paymentTypeId).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(MakeOrderErrorState());
            },
            (r) async {
              if (r!.message! != "تم  الاشتراك فى هذه الباقه من قبل .") {
                if (paymentTypeId == 1) {
                  showToast(msg: r.message!, state: ToastStates.SUCCESS);
                  await launch(r.data!.redirectUrl!);
                  emit(MakeOrderSuccessState());
                  MagicRouter.pop();
                }
              } else {
                showToast(msg: r.message!, state: ToastStates.ERROR);
                emit(MakeOrderSuccessState());
                MagicRouter.pop();
              }
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////
  sendPromoCode(promoCode) async {
    emit(SendPromoCodeLoadingState());
    await SendPromoCodeAction(promoCode).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(SendPromoCodeErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(MakeOrderSuccessState());
              MagicRouter.navigateAndPopAll(const LayoutScreen());
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////////
  UserBookingModel? userBookingModel;
  getuserBookingData() async {
    emit(GetUserBookingLoadingState());
    await UserBookingAction().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(GetUserBookingErrorState());
            },
            (r) {
              userBookingModel = r;
              emit(GetUserBookingSuccessState());
              return userBookingModel;
            },
          ),
        );
  }
}
