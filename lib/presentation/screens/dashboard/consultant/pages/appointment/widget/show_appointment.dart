import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/appointment/widget/add_new_appointment.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../../../../core/widgets/space_widget.dart';

class ShowTutorApoointment extends StatefulWidget {
  const ShowTutorApoointment({Key? key}) : super(key: key);

  @override
  State<ShowTutorApoointment> createState() => _ShowTutorApoointmentState();
}

class _ShowTutorApoointmentState extends State<ShowTutorApoointment> {
  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    super.initState();
  }

  int selectedDateIndex = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        bloc: GetIt.I<ProfileCubit>(),
        builder: (context, state) {
          return (GetIt.I<ProfileCubit>().tutorProfileModel != null)
              ? Column(
                  children: [
                    Center(
                      child: Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .appoinments!
                              .length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedDateIndex = index;
                              });
                            },
                            child: Container(
                              width: screenWidth(context) * 0.25,
                              height: screenHeight(context) * 0.08,
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
                                    GetIt.I<ProfileCubit>()
                                        .tutorProfileModel!
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
                    (GetIt.I<ProfileCubit>()
                            .tutorProfileModel!
                            .data!
                            .appoinments!
                            .isNotEmpty)
                        ? Center(
                            child: Wrap(
                              runSpacing: 15,
                              spacing: 15,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                GetIt.I<ProfileCubit>()
                                    .tutorProfileModel!
                                    .data!
                                    .appoinments![selectedDateIndex]
                                    .availableHours!
                                    .length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth(context) * 0.4,
                                      height: screenHeight(context) * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth(context) * 0.02),
                                        color:
                                            Colors.blueAccent.withOpacity(0.3),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              GetIt.I<ProfileCubit>()
                                                  .tutorProfileModel!
                                                  .data!
                                                  .appoinments![
                                                      selectedDateIndex]
                                                  .availableHours![index]
                                                  .time!
                                                  .substring(0, 5)
                                                  .toString(),
                                              style: headingStyle.copyWith(
                                                color: colordeepGrey,
                                                fontWeight: FontWeight.normal,
                                                fontSize:
                                                    screenWidth(context) * 0.03,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                child: Text(
                                                  translateString("Edit",
                                                      "تعديل", "Düzenlemek"),
                                                ),
                                                onPressed: () =>
                                                    MagicRouter.navigateTo(
                                                  AddNewAppointment(
                                                    date: GetIt.I<
                                                            ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .appoinments![
                                                            selectedDateIndex]
                                                        .availableDate!,
                                                    time: GetIt.I<
                                                            ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .appoinments![
                                                            selectedDateIndex]
                                                        .availableHours![index]
                                                        .time!,
                                                    timeId: GetIt.I<
                                                            ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .appoinments![
                                                            selectedDateIndex]
                                                        .availableHours![index]
                                                        .timeId!,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () => GetIt.I<
                                                        ProfileCubit>()
                                                    .deleteTutorAppointment(GetIt
                                                            .I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .appoinments![
                                                            selectedDateIndex]
                                                        .availableHours![index]
                                                        .timeId!),
                                                child: Text(
                                                  translateString("Delete",
                                                      "حذف", "Silmek"),
                                                  style: headingStyle.copyWith(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              translateString(
                                  "no time available yet ...",
                                  "لا توجد مواعيد بعد ...",
                                  "henüz uygun zaman yok..."),
                              style: headingStyle.copyWith(
                                color: kMainColor,
                              ),
                            ),
                          ),
                  ],
                )
              : loading();
        },
      ),
    );
  }
}
