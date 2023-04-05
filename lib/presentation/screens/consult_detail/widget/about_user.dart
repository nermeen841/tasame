// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/validation.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/router/router.dart';
import '../../home/cubit/home_cubit.dart';

class AboutUser extends StatefulWidget {
  const AboutUser({Key? key}) : super(key: key);

  @override
  State<AboutUser> createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  int selectedDateIndex = 0;
  String? availableDate;
  String? availableTime;
  TextEditingController message = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    selectedDateIndex = 0;
    availableDate = null;
    availableTime = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is BookApointmentSuccessState) {
          GetIt.I<HomeCubit>().getConsultantDetail(
              GetIt.I<HomeCubit>().consultantDetailModel!.data!.id!, false);
        }
      },
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (GetIt.I<HomeCubit>().consultantDetailModel!.data!.cv != null)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${LocaleKeys.ABOUT.tr()} : ",
                        style: headingStyle,
                      ),
                      Wrap(
                        children: [
                          SizedBox(
                            width: screenWidth(context) * .65,
                            child: Text(
                              GetIt.I<HomeCubit>()
                                      .consultantDetailModel!
                                      .data!
                                      .cv ??
                                  "",
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: colordeepGrey,
                                fontSize: screenWidth(context) * 0.035,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            (GetIt.I<HomeCubit>().consultantDetailModel!.data!.cv != null)
                ? const VerticalSpace(value: 2)
                : const SizedBox(),
            const VerticalSpace(
              value: 1,
            ),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .credits!
                    .isNotEmpty)
                ? Text(
                    translateString("Creidts  : ", "الاعتمادات : ", "kredi : "),
                    style: headingStyle,
                  )
                : const SizedBox(),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .credits!
                    .isNotEmpty)
                ? const VerticalSpace(
                    value: 1,
                  )
                : const SizedBox(),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .credits!
                    .isNotEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          GetIt.I<HomeCubit>()
                              .consultantDetailModel!
                              .data!
                              .credits!
                              .length,
                          (index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: kMainColor,
                                size: screenWidth(context) * 0.025,
                              ),
                              const HorizontalSpace(value: 1),
                              Text(
                                GetIt.I<HomeCubit>()
                                    .consultantDetailModel!
                                    .data!
                                    .credits![index]
                                    .name!,
                                style: headingStyle.copyWith(
                                  color: kMainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .credits!
                    .isNotEmpty)
                ? const VerticalSpace(
                    value: 2,
                  )
                : const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translateString(
                      "Statistics : ", "احصائيات : ", "İstatistik : "),
                  style: headingStyle,
                ),
                const VerticalSpace(value: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            Text(translateString("users", "مستفيدين", "")),
                          ],
                        ),
                        const VerticalSpace(value: 0.5),
                        Text(GetIt.I<HomeCubit>()
                            .consultantDetailModel!
                            .data!
                            .countUsers
                            .toString()),
                      ],
                    ),
                    const HorizontalSpace(value: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.green,
                            ),
                            Text(translateString(
                                "Sessions", "جلسات", "oturumlar")),
                          ],
                        ),
                        const VerticalSpace(value: 0.5),
                        Text(GetIt.I<HomeCubit>()
                            .consultantDetailModel!
                            .data!
                            .countSessions
                            .toString()),
                      ],
                    ),
                    const HorizontalSpace(value: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: colorBetrolly,
                            ),
                            Text(
                              translateString("Package", "باقات", ""),
                            ),
                          ],
                        ),
                        const VerticalSpace(value: 0.5),
                        Text(GetIt.I<HomeCubit>()
                            .consultantDetailModel!
                            .data!
                            .countPackages
                            .toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            (GetIt.I<HomeCubit>().consultantDetailModel!.data!.cv != null)
                ? const VerticalSpace(
                    value: 2,
                  )
                : const SizedBox(),
            Divider(
              color: colordeepGrey,
            ),
            const VerticalSpace(value: 2),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .appoinments!
                    .isNotEmpty)
                ? Column(
                    children: [
                      Text(
                        translateString(
                            "Appointment Calender", "جدول المواعيد", ""),
                        style: headingStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth(context) * 0.045,
                          color: colorBlue,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      Center(
                        child: Wrap(
                          runSpacing: 2,
                          spacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .appoinments!
                                .length,
                            (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDateIndex = index;
                                  availableDate = GetIt.I<HomeCubit>()
                                      .consultantDetailModel!
                                      .data!
                                      .appoinments![index]
                                      .availableDate!;
                                });
                              },
                              child: Container(
                                width: screenWidth(context) * 0.2,
                                height: screenHeight(context) * 0.06,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (selectedDateIndex == index)
                                        ? kMainColor
                                        : colordeepGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth(context) * 0.01),
                                  color: (selectedDateIndex == index)
                                      ? kMainColor
                                      : Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      GetIt.I<HomeCubit>()
                                          .consultantDetailModel!
                                          .data!
                                          .appoinments![index]
                                          .availableDate!,
                                      style: headingStyle.copyWith(
                                        color: (selectedDateIndex == index)
                                            ? Colors.white
                                            : colordeepGrey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: screenWidth(context) * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      Center(
                        child: Wrap(
                          runSpacing: 10,
                          spacing: 1,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .appoinments![selectedDateIndex]
                                .availableHours!
                                .length,
                            (index) => SizedBox(
                              width: screenWidth(context) * 0.15,
                              height: screenHeight(context) * 0.06,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth(context) * 0.15,
                                    height: screenHeight(context) * 0.06 / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth(context) * 0.02),
                                        topRight: Radius.circular(
                                            screenWidth(context) * 0.02),
                                      ),
                                      color: Colors.blueAccent.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        GetIt.I<HomeCubit>()
                                            .consultantDetailModel!
                                            .data!
                                            .appoinments![selectedDateIndex]
                                            .availableHours![index]
                                            .time!,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: screenWidth(context) * 0.03,
                                        ),
                                      ),
                                    ),
                                  ),
                                  (prefs.getString("user_type") == "user")
                                      ? InkWell(
                                          onTap: () {
                                            if (GetIt.I<HomeCubit>()
                                                    .consultantDetailModel!
                                                    .data!
                                                    .appoinments![
                                                        selectedDateIndex]
                                                    .availableHours![index]
                                                    .booked !=
                                                "booked") {
                                              GetIt.I<HomeCubit>().postAppointment(
                                                  available_date: availableDate ??
                                                      GetIt.I<HomeCubit>()
                                                          .consultantDetailModel!
                                                          .data!
                                                          .appoinments![
                                                              selectedDateIndex]
                                                          .availableDate!,
                                                  available_hours: GetIt.I<
                                                          HomeCubit>()
                                                      .consultantDetailModel!
                                                      .data!
                                                      .appoinments![
                                                          selectedDateIndex]
                                                      .availableHours![index]
                                                      .time!,
                                                  tutor_id: GetIt.I<HomeCubit>()
                                                      .consultantDetailModel!
                                                      .data!
                                                      .id!);
                                              // MagicRouter.navigateTo(
                                              //     const PaymentTypeSelection(
                                              //   fromQuestions: false,
                                              // ));
                                            }
                                          },
                                          child: Container(
                                            width: screenWidth(context) * 0.15,
                                            height: screenHeight(context) *
                                                0.06 /
                                                2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(
                                                    screenWidth(context) *
                                                        0.02),
                                                bottomLeft: Radius.circular(
                                                    screenWidth(context) *
                                                        0.02),
                                              ),
                                              color: (GetIt.I<HomeCubit>()
                                                          .consultantDetailModel!
                                                          .data!
                                                          .appoinments![
                                                              selectedDateIndex]
                                                          .availableHours![
                                                              index]
                                                          .booked ==
                                                      "booked")
                                                  ? Colors.blueAccent
                                                      .withOpacity(0.3)
                                                  : colorBlue,
                                            ),
                                            child: Center(
                                              child: Text(
                                                (GetIt.I<HomeCubit>()
                                                            .consultantDetailModel!
                                                            .data!
                                                            .appoinments![
                                                                selectedDateIndex]
                                                            .availableHours![
                                                                index]
                                                            .booked ==
                                                        "booked")
                                                    ? GetIt.I<HomeCubit>()
                                                        .consultantDetailModel!
                                                        .data!
                                                        .appoinments![
                                                            selectedDateIndex]
                                                        .availableHours![index]
                                                        .booked!
                                                    : LocaleKeys.BOOK.tr(),
                                                style: headingStyle.copyWith(
                                                  color: (GetIt.I<HomeCubit>()
                                                              .consultantDetailModel!
                                                              .data!
                                                              .appoinments![
                                                                  selectedDateIndex]
                                                              .availableHours![
                                                                  index]
                                                              .booked ==
                                                          "booked")
                                                      ? colordeepGrey
                                                      : Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      screenWidth(context) *
                                                          0.03,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      (prefs.getString("user_type") == "user")
                          ? Column(
                              children: [
                                const VerticalSpace(value: 2),
                                Center(
                                  child: Text(
                                    LocaleKeys.NOT_FOUND_TIME.tr(),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: headingStyle.copyWith(
                                      fontSize: screenWidth(context) * 0.035,
                                      fontWeight: FontWeight.w300,
                                      color: colordeepGrey,
                                    ),
                                  ),
                                ),
                                const VerticalSpace(value: 2),
                                Center(
                                  child: SizedBox(
                                    width: screenWidth(context) * 0.4,
                                    height: screenHeight(context) * 0.04,
                                    child: CustomGeneralButton(
                                      text: LocaleKeys.MAKE_REQUEST.tr(),
                                      textColor: Colors.white,
                                      onTap: () {
                                        homeBottomSheet(
                                          context: context,
                                          child: Form(
                                            key: formKey,
                                            child: SingleChildScrollView(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    screenHeight(context) *
                                                        0.02,
                                                horizontal:
                                                    screenWidth(context) * 0.02,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topEnd,
                                                    child: TextButton(
                                                      onPressed: () =>
                                                          MagicRouter.pop(),
                                                      child: Text(
                                                        translateString("Close",
                                                            "اغلاق", "kapat"),
                                                        style: headingStyle
                                                            .copyWith(
                                                          color: kMainColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: screenWidth(
                                                                  context) *
                                                              0.045,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const VerticalSpace(value: 1),
                                                  CustomTextFormField(
                                                    hint:
                                                        LocaleKeys.MESSAGE.tr(),
                                                    controller: message,
                                                    maxLines: 5,
                                                    validator: (value) =>
                                                        validate(value!),
                                                  ),
                                                  const VerticalSpace(value: 3),
                                                  CustomGeneralButton(
                                                    text: LocaleKeys.SEND.tr(),
                                                    textColor: Colors.white,
                                                    onTap: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        GetIt.I<HomeCubit>()
                                                            .postMakeRequest(
                                                                tutorId: GetIt.I<
                                                                        HomeCubit>()
                                                                    .consultantDetailModel!
                                                                    .data!
                                                                    .id!,
                                                                message: message
                                                                    .text);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  )
                : Center(
                    child: Text(
                      translateString("no time available yet ...",
                          "لا توجد مواعيد ...", "henüz uygun zaman yok..."),
                      style: headingStyle.copyWith(
                        color: kMainColor,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
