import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/orders/cubit/orders_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/space_widget.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({Key? key}) : super(key: key);

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<OrdersCubit>().getUserOrders(),
      child: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        bloc: GetIt.I<OrdersCubit>(),
        builder: (context, state) {
          return (GetIt.I<OrdersCubit>().ordersModel != null)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.04,
                    vertical: screenHeight(context) * 0.02,
                  ),
                  child: (GetIt.I<OrdersCubit>().ordersModel!.data!.isNotEmpty)
                      ? Column(
                          children: List.generate(
                            GetIt.I<OrdersCubit>().ordersModel!.data!.length,
                            (index) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth(context) * 0.02,
                                vertical: screenHeight(context) * 0.015,
                              ),
                              margin: EdgeInsets.all(
                                screenWidth(context) * 0.015,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  screenWidth(context) * 0.015,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.bagShopping,
                                    color: kMainColor,
                                  ),
                                  const HorizontalSpace(value: 1),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (prefs.getString("user_type") == "user")
                                            ? GetIt.I<OrdersCubit>()
                                                .ordersModel!
                                                .data![index]
                                                .consultant!
                                            : GetIt.I<OrdersCubit>()
                                                .ordersModel!
                                                .data![index]
                                                .user!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        translateString("price : ", "السعر : ",
                                                "fiyat: ") +
                                            getPrice(
                                                price: num.parse(
                                                    GetIt.I<OrdersCubit>()
                                                        .ordersModel!
                                                        .data![index]
                                                        .price!
                                                        .toString())),
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        translateString(
                                                "payment type : ",
                                                "طريقة الدفع : ",
                                                "ödeme türü") +
                                            GetIt.I<OrdersCubit>()
                                                .ordersModel!
                                                .data![index]
                                                .payment!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        translateString(
                                                "number of consultations : ",
                                                " عدد الاستشارات : ",
                                                "danışma sayısı : ") +
                                            GetIt.I<OrdersCubit>()
                                                .ordersModel!
                                                .data![index]
                                                .numConsultation!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        translateString(
                                                "remainning consultations : ",
                                                " الاستشارات المتبقية: ",
                                                "kalan istişareler : ") +
                                            GetIt.I<OrdersCubit>()
                                                .ordersModel!
                                                .data![index]
                                                .remainingConsultations!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.25),
                          child: Center(
                            child: Text(
                              (prefs.getString("user_type") == "user")
                                  ? translateString(
                                      "No package has been subscribed yet",
                                      "لم يتم الاشتراك في اي باقة بعد ",
                                      "")
                                  : translateString(
                                      "No Package subscriptions yet",
                                      "لا توجد اشتراكات الباقات بعد ",
                                      ""),
                              style: headingStyle.copyWith(
                                color: kMainColor,
                              ),
                            ),
                          ),
                        ),
                )
              : loading();
        },
      ),
    );
  }
}
