// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_drop_down.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/helper/validation.dart';
import '../../../../../../../core/router/router.dart';
import '../../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../../core/widgets/space_widget.dart';
import '../../../../../layout/layuot.dart';
import '../../../../../myaccount/cubit/profile_cubit.dart';

class AddNewAppointment extends StatefulWidget {
  final String? date;
  final String? time;
  final int? timeId;
  const AddNewAppointment({Key? key, this.date, this.time, this.timeId})
      : super(key: key);

  @override
  State<AddNewAppointment> createState() => _AddNewAppointmentState();
}

class _AddNewAppointmentState extends State<AddNewAppointment> {
  DateTime? selectedstartDate;
  DateTime? selectedendDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  var quarterHours = ["00", "15", "30", "45"];
  List<String> times = [];
  getTimeList() {
    for (var i = 0; i < 24; i++) {
      for (var j = 0; j < 4; j++) {
        String time = "$i:${quarterHours[j]}";
        if (i < 10) {
          time = "0$time";
        }
        times.add(time);
      }
    }

    print(times);
  }

  @override
  void initState() {
    chosenValue = null;
    getTimeList();
    if (widget.timeId != null) {
      startDateController.text = widget.date!;
      endDateController.text = widget.date!;
    } else {
      final DateTime time = DateTime.now();
      setState(() {
        startDateController.text = "${time.year}-${time.month}-${time.day}";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const VerticalSpace(value: 4),
            Text(
              "${translateString("Start Date", "تاريخ البدء", "Başlangıç ​​tarihi")} ",
              textAlign: TextAlign.start,
              style: headingStyle.copyWith(
                fontSize: screenWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              hint: "yy / mm / dd",
              controller: startDateController,
              readOnly: true,
              ontap: () async => await selectStartDate(context),
            ),
            const VerticalSpace(value: 2),
            Text(
              translateString("End Date", "تاريخ الانتهاء", "Bitiş tarihi"),
              textAlign: TextAlign.start,
              style: headingStyle.copyWith(
                fontSize: screenWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              hint: "yy / mm / dd",
              validator: (value) => validate(value!),
              readOnly: true,
              controller: endDateController,
              ontap: () async => await selectEndDate(context),
            ),
            const VerticalSpace(value: 2),
            Text(
              translateString(
                  "Available Hours", "الساعات المتاحة", "Müsait Saatler"),
              textAlign: TextAlign.start,
              style: headingStyle.copyWith(
                fontSize: screenWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomDropDown(
              items: times,
              text: (chosenValue != null)
                  ? chosenValue!
                  : (widget.time != null)
                      ? widget.time!
                      : "-- : --",
            ),
            const VerticalSpace(value: 4),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is EditAppointmentErrorState ||
                    state is EditAppointmentSuccessState) {
                  GetIt.I<ProfileCubit>().getUserProfile();

                  MagicRouter.navigateAndPopAll(const LayoutScreen(
                    index: 4,
                  ));
                  // MagicRouter.navigateAndPReplacement(
                  //     const ManageTutorAppointmentScreen());
                }
              },
              bloc: GetIt.I<ProfileCubit>(),
              builder: (context, state) {
                return (state is! AddNewAppointmentLoadingState)
                    ? CustomGeneralButton(
                        color: kMainColor,
                        textColor: Colors.white,
                        text: (widget.timeId != null)
                            ? translateString("Save", "حفظ", "Kaydetmek")
                            : translateString("Create", "اضافة", "oluşturmak"),
                        onTap: () {
                          if (widget.timeId != null) {
                            GetIt.I<ProfileCubit>().editTutorAppointment(
                              timeId: widget.timeId!,
                              availableHours: chosenValue ?? widget.time!,
                            );
                          } else {
                            if (chosenValue != null &&
                                startDateController.text.isNotEmpty &&
                                endDateController.text.isNotEmpty) {
                              GetIt.I<ProfileCubit>().addNewAppointment(
                                startDate: startDateController.text,
                                endDate: endDateController.text,
                                time: chosenValue!,
                              );
                            } else {
                              showToast(
                                  msg: translateString(
                                    "you must select date and time",
                                    "يجب اختيار الوقت والتاريخ",
                                    "tarih ve saati seçmelisiniz",
                                  ),
                                  state: ToastStates.ERROR);
                            }
                          }
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  Future<void> selectStartDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null && picked != selectedstartDate) {
      setState(() {
        selectedstartDate = picked;
        startDateController.text =
            "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<void> selectEndDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedendDate) {
      setState(() {
        selectedendDate = picked;
        endDateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }
}
