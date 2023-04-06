// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/dashboard/user/upcommingconsultation/widget/body.dart';

import '../../../../../core/router/router.dart';
import '../../../contactus/cubit/setting_cubit.dart';
import '../../../layout/layuot.dart';
import '../../../myaccount/cubit/profile_cubit.dart';

class UpcommingConsultationsScreen extends StatefulWidget {
  final String title;
  final bool fromAuth;
  final bool? fromHome;
  const UpcommingConsultationsScreen(
      {Key? key, required this.title, required this.fromAuth, this.fromHome})
      : super(key: key);

  @override
  State<UpcommingConsultationsScreen> createState() =>
      _UpcommingConsultationsScreenState();
}

class _UpcommingConsultationsScreenState
    extends State<UpcommingConsultationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromHome == null || widget.fromHome == false)
          ? customAppbar(
              title: widget.title,
              context: context,
              press: (widget.fromAuth == true)
                  ? () => MagicRouter.navigateAndPopAll(const LayoutScreen())
                  : () => MagicRouter.pop(),
            )
          : null,
      floatingActionButton: (widget.fromHome == true)
          ? BlocConsumer<SettingCubit, SettingState>(
              bloc: GetIt.I<SettingCubit>(),
              builder: (context, state) => FloatingActionButton(
                heroTag: "hero5",
                onPressed: () async {
                  if (Platform.isAndroid) {
                    await launch(
                        "https://wa.me/${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}/?text=${Uri.parse("")}"); // new line
                  } else {
                    await launch(
                        "https://api.whatsapp.com/send?phone=${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}=${Uri.parse("")}"); // new line
                  }
                },
                backgroundColor: Colors.green,
                child: Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: screenWidth(context) * 0.07,
                ),
              ),
              listener: (context, state) {},
            )
          : null,
      body: RefreshIndicator(
          onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
          child: const UpcommingConsultationsBody()),
    );
  }
}
