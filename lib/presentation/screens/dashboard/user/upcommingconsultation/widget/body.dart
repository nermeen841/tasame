import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../../../myaccount/cubit/profile_cubit.dart';

class UpcommingConsultationsBody extends StatefulWidget {
  const UpcommingConsultationsBody({Key? key}) : super(key: key);

  @override
  State<UpcommingConsultationsBody> createState() =>
      _UpcommingConsultationsBodyState();
}

class _UpcommingConsultationsBodyState
    extends State<UpcommingConsultationsBody> {
  String getislammicDate(String date) {
    final List dateData = date.split('-');
    var hdate = HijriCalendar.fromDate(
      DateTime(int.parse(dateData[0].toString()),
          int.parse(dateData[1].toString()), int.parse(dateData[2].toString())),
    );
    return "${hdate.hYear} - ${hdate.hMonth} - ${hdate.hDay}";
  }

  String? remindDays;
  String? remindhours;
  getremindtimeAndDate(String time, String date) {
    final List dateData = date.split('-');
    final List timeData = time.split(':');
    DateTime firstDate = DateTime(int.parse(dateData[0].toString()),
        int.parse(dateData[1].toString()), int.parse(dateData[2].toString()));
    DateTime lastDate = DateTime.now();

    DateTime firstTime = DateTime(
        int.parse(timeData[0].toString()),
        int.parse(
          timeData[1].toString(),
        ));
    DateTime lastTime = DateTime.now();

    if (firstDate.day >= lastDate.day) {
      remindDays = (firstDate.day - lastDate.day).toString();
      return translateString("Remaining on the consultation: $remindDays days",
          "متبقي علي الاستشارة : $remindDays أيام ", "");
    }
    if (firstTime.hour >= lastTime.hour) {
      remindhours = (firstTime.hour - lastTime.hour).toString();
      return translateString(
          ",and : $remindhours hour", ", و : $remindhours ساعة", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        bloc: GetIt.I<ProfileCubit>(),
        builder: (context, state) {
          return (GetIt.I<ProfileCubit>().userModel != null)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight(context) * 0.02,
                    horizontal: screenWidth(context) * 0.04,
                  ),
                  child: (GetIt.I<ProfileCubit>()
                          .userModel!
                          .data!
                          .bookings!
                          .isNotEmpty)
                      ? Column(
                          children: List.generate(
                            GetIt.I<ProfileCubit>()
                                .userModel!
                                .data!
                                .bookings!
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
                                      Text(
                                        GetIt.I<ProfileCubit>()
                                            .userModel!
                                            .data!
                                            .bookings![index]
                                            .tutor!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
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
                                            GetIt.I<ProfileCubit>()
                                                .userModel!
                                                .data!
                                                .bookings![index]
                                                .date!,
                                            style: headingStyle.copyWith(
                                              color: colordeepGrey,
                                              fontSize:
                                                  screenWidth(context) * 0.04,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const HorizontalSpace(value: 1),
                                          Text(
                                            GetIt.I<ProfileCubit>()
                                                .userModel!
                                                .data!
                                                .bookings![index]
                                                .time!,
                                            style: headingStyle.copyWith(
                                              color: colordeepGrey,
                                              fontSize:
                                                  screenWidth(context) * 0.04,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Text(
                                        getislammicDate(GetIt.I<ProfileCubit>()
                                            .userModel!
                                            .data!
                                            .bookings![index]
                                            .date!),
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize: screenWidth(context) * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Wrap(
                                        children: [
                                          Text(
                                            getremindtimeAndDate(
                                              GetIt.I<ProfileCubit>()
                                                  .userModel!
                                                  .data!
                                                  .bookings![index]
                                                  .time!,
                                              GetIt.I<ProfileCubit>()
                                                  .userModel!
                                                  .data!
                                                  .bookings![index]
                                                  .date!,
                                            ),
                                            maxLines: 3,
                                            style: headingStyle.copyWith(
                                              color: colordeepGrey,
                                              fontSize:
                                                  screenWidth(context) * 0.035,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const VerticalSpace(value: 0.7),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            translateOrderStatuse(
                                                GetIt.I<ProfileCubit>()
                                                    .userModel!
                                                    .data!
                                                    .bookings![index]
                                                    .booked!),
                                            style: headingStyle.copyWith(
                                              color: kMainColor,
                                              fontSize:
                                                  screenWidth(context) * 0.04,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const HorizontalSpace(value: 6),
                                          SizedBox(
                                            width: screenWidth(context) * 0.25,
                                            height:
                                                screenHeight(context) * 0.04,
                                            child: CustomGeneralButton(
                                              onTap: () =>
                                                  GetIt.I<ProfileCubit>()
                                                      .postCancelAppointment(
                                                GetIt.I<ProfileCubit>()
                                                    .userModel!
                                                    .data!
                                                    .bookings![index]
                                                    .timeId!,
                                              ),
                                              text: translateString(
                                                  "Cancel", "الغاء", "İptal"),
                                              textColor: Colors.white,
                                              color: kMainColor,
                                              borderColor: Colors.transparent,
                                            ),
                                          ),
                                        ],
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
