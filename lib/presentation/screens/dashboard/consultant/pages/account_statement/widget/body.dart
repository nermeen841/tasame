import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/account_statement/widget/componnent.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/widget/screen_title.dart';

class AccountStatementBody extends StatefulWidget {
  const AccountStatementBody({super.key});

  @override
  State<AccountStatementBody> createState() => _AccountStatementBodyState();
}

class _AccountStatementBodyState extends State<AccountStatementBody> {
  String? startdate;
  String? enddate;
  bool isFliterring = false;
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          GetIt.I<ProfileCubit>().getTutorSessions(startDate: "", endDate: ""),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        bloc: GetIt.I<ProfileCubit>(),
        builder: (context, state) {
          return (GetIt.I<ProfileCubit>().tutorSessionsModel != null)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.03,
                    vertical: screenHeight(context) * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTitle(
                        title: translateString(
                            "Account Statement", "كشف الحساب", ""),
                      ),
                      const VerticalSpace(value: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              await startDate(context);
                            },
                            child: filterItem(
                              startdate ??
                                  translateString(
                                      "Sart date", "تاريخ البدء", ""),
                              context,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await endDate(context);
                            },
                            child: filterItem(
                              enddate ??
                                  translateString(
                                      "End date", "تاريخ الانتهاء", ""),
                              context,
                            ),
                          ),
                          (!isFliterring)
                              ? SizedBox(
                                  width: screenWidth(context) * 0.3,
                                  height: screenHeight(context) * 0.05,
                                  child: (state is! TutorSessionsLoadingState)
                                      ? CustomGeneralButton(
                                          textColor: Colors.white,
                                          text: translateString(
                                              "Filter now", "تصفية الآن", ""),
                                          onTap: () {
                                            if (startdate != null &&
                                                enddate != null) {
                                              setState(
                                                () {
                                                  isFliterring = true;
                                                  showErrorText = false;
                                                },
                                              );
                                              if (isFliterring) {
                                                setState(() {
                                                  showErrorText = false;
                                                });
                                                GetIt.I<ProfileCubit>()
                                                    .getTutorSessions(
                                                        startDate: startdate!,
                                                        endDate: enddate!);
                                              }
                                            } else if (startdate == null &&
                                                enddate != null) {
                                              setState(() {
                                                isFliterring = false;
                                                showErrorText = true;
                                              });
                                            } else if (startdate != null &&
                                                enddate == null) {
                                              setState(() {
                                                isFliterring = false;
                                                showErrorText = true;
                                              });
                                            }
                                          },
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                            color: kMainColor,
                                          ),
                                        ),
                                )
                              : SizedBox(
                                  width: screenWidth(context) * 0.3,
                                  height: screenHeight(context) * 0.05,
                                  child: (state is! TutorSessionsLoadingState)
                                      ? CustomGeneralButton(
                                          textColor: Colors.white,
                                          text: translateString(
                                              "Cancel", "إلغاء", ""),
                                          onTap: () {
                                            setState(() {
                                              isFliterring = false;
                                              startdate = null;
                                              enddate = null;
                                              showErrorText = false;
                                            });
                                            GetIt.I<ProfileCubit>()
                                                .getTutorSessions(
                                                    startDate: "", endDate: "");
                                          },
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                            color: kMainColor,
                                          ),
                                        ),
                                ),
                        ],
                      ),
                      (showErrorText)
                          ? const VerticalSpace(value: 0.7)
                          : const SizedBox(),
                      (showErrorText)
                          ? Text(
                              translateString(
                                  "* you must select start date and end date",
                                  "* يجب تحديد تاريخ البدء والانتهاء",
                                  ""),
                              style: headingStyle.copyWith(
                                color: colorRed,
                                fontSize: screenWidth(context) * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : const SizedBox(),
                      const VerticalSpace(value: 2),
                      Divider(
                        color: kMainColor,
                        thickness: 1,
                      ),
                      const VerticalSpace(value: 4),
                      Text(
                        translateString("Account statement data : ",
                            "بيانات كشف الحساب : ", ""),
                        style: headingStyle.copyWith(
                          color: kMainColor,
                          fontSize: screenWidth(context) * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      showAccountDetail(
                        context: context,
                        title: translateString("Number of consultations : ",
                            "عدد الاستشارات  : ", ""),
                        data: GetIt.I<ProfileCubit>()
                            .tutorSessionsModel!
                            .sessionCount!
                            .toString(),
                      ),
                      const VerticalSpace(value: 1),
                      showAccountDetail(
                        context: context,
                        title: translateString("Total fees collected : ",
                            "إجمالي الرسوم المحصلة : ", ""),
                        data:
                            "${GetIt.I<ProfileCubit>().tutorSessionsModel!.totalFees!} SAR ",
                      ),
                      const VerticalSpace(value: 1),
                      showAccountDetail(
                        context: context,
                        title: translateString("Discount : ", "الخصم : ", ""),
                        data: "23 %",
                      ),
                      const VerticalSpace(value: 1),
                      showAccountDetail(
                        context: context,
                        title: translateString("net : ", "الصافي : ", ""),
                        data:
                            "${num.parse(GetIt.I<ProfileCubit>().tutorSessionsModel!.netFees!.toString()).toStringAsFixed(2)} SAR ",
                      ),
                    ],
                  ),
                )
              : loading();
        },
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////
  DateTime selectedDate = DateTime.now();
  Future<void> startDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startdate = "${picked.year}-${picked.month}-${picked.day}";
      });
      if (startdate != null && enddate != null) {
        setState(() {
          showErrorText = false;
        });
      }
    }
  }
  //////////////////////////////////////////////////////////////////

  DateTime selectedDate1 = DateTime.now();
  Future<void> endDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        enddate = "${picked.year}-${picked.month}-${picked.day}";
      });
      if (startdate != null && enddate != null) {
        setState(() {
          showErrorText = false;
        });
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////
}
