import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/orders/cubit/orders_cubit.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/widgets/space_widget.dart';

class UserPrevoiseConsultationsBody extends StatefulWidget {
  const UserPrevoiseConsultationsBody({Key? key}) : super(key: key);

  @override
  State<UserPrevoiseConsultationsBody> createState() =>
      _UserPrevoiseConsultationsBodyState();
}

class _UserPrevoiseConsultationsBodyState
    extends State<UserPrevoiseConsultationsBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<OrdersCubit>().getuserBookingData(),
      child: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        bloc: GetIt.I<OrdersCubit>(),
        builder: (context, state) {
          return (GetIt.I<OrdersCubit>().userBookingModel != null)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight(context) * 0.02,
                    horizontal: screenWidth(context) * 0.04,
                  ),
                  child: (GetIt.I<OrdersCubit>()
                          .userBookingModel!
                          .data!
                          .isNotEmpty)
                      ? Column(
                          children: List.generate(
                            GetIt.I<OrdersCubit>()
                                .userBookingModel!
                                .data!
                                .length,
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
                                  const HorizontalSpace(value: 3),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (prefs.getString("user_type") == "user")
                                          ? Text(
                                              GetIt.I<OrdersCubit>()
                                                      .userBookingModel!
                                                      .data![index]
                                                      .tutor ??
                                                  "",
                                              style: headingStyle.copyWith(
                                                color: colordeepGrey,
                                                fontSize:
                                                    screenWidth(context) * 0.04,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : Text(
                                              GetIt.I<OrdersCubit>()
                                                      .userBookingModel!
                                                      .data![index]
                                                      .user ??
                                                  "",
                                              style: headingStyle.copyWith(
                                                color: colordeepGrey,
                                                fontSize:
                                                    screenWidth(context) * 0.04,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      const VerticalSpace(value: 0.7),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            GetIt.I<OrdersCubit>()
                                                .userBookingModel!
                                                .data![index]
                                                .date!,
                                            style: headingStyle.copyWith(
                                              color: colordeepGrey,
                                              fontSize:
                                                  screenWidth(context) * 0.04,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const HorizontalSpace(value: 0.05),
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: " , ",
                                                style: headingStyle.copyWith(
                                                  color: colordeepGrey,
                                                  fontSize:
                                                      screenWidth(context) *
                                                          0.04,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: GetIt.I<OrdersCubit>()
                                                    .userBookingModel!
                                                    .data![index]
                                                    .time!
                                                    .substring(0, 5)
                                                    .toString(),
                                                style: headingStyle.copyWith(
                                                  color: colordeepGrey,
                                                  fontSize:
                                                      screenWidth(context) *
                                                          0.04,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        translateOrderStatuse(
                                            GetIt.I<OrdersCubit>()
                                                .userBookingModel!
                                                .data![index]
                                                .booked!),
                                        style: headingStyle.copyWith(
                                          color: kMainColor,
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
                          padding:
                              EdgeInsets.only(top: screenHeight(context) * 0.2),
                          child: Center(
                            child: Text(
                              translateString(
                                  "no Booking here  yet",
                                  "لا توجد حجوزات بعد",
                                  "burada henüz Rezervasyon yok"),
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
