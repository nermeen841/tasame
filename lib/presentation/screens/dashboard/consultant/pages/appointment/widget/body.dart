import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/widgets/custom_buttons_widget.dart';
import 'add_new_appointment.dart';
import 'show_appointment.dart';

class ManageAppointmentBody extends StatefulWidget {
  const ManageAppointmentBody({Key? key}) : super(key: key);

  @override
  State<ManageAppointmentBody> createState() => _ManageAppointmentBodyState();
}

class _ManageAppointmentBodyState extends State<ManageAppointmentBody> {
  bool addNewAppointment = false;
  @override
  void initState() {
    addNewAppointment = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: Column(
          children: [
            const VerticalSpace(value: 2),
            CustomGeneralButton(
              color: kMainColor,
              textColor: Colors.white,
              text: translateString("Create New Appointment", "اضافة وقت جديد",
                  "Yeni Randevu Oluştur"),
              onTap: () {
                MagicRouter.navigateTo(const AddNewAppointment());
              },
            ),
            const VerticalSpace(value: 4),
            const ShowTutorApoointment(),
          ],
        ),
      ),
    );
  }
}
