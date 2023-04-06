// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:api_request/api_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/generator/localization_constant.dart';
import '../../../../../widget/internalscreen_appbar.dart';
import '../../../../contactus/cubit/setting_cubit.dart';
import '../../../../splash/splash.dart';
import 'widget/body.dart';

class ManageOffersScreen extends StatefulWidget {
  final bool? fromHome;
  const ManageOffersScreen({Key? key, this.fromHome}) : super(key: key);

  @override
  State<ManageOffersScreen> createState() => _ManageOffersScreenState();
}

class _ManageOffersScreenState extends State<ManageOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromHome == null || widget.fromHome == false)
          ? internalScreensAppbar(
              context,
              (value) {
                if (value == 1) {
                  setState(() {
                    ApiRequestOptions.instance
                        ?.config(defaultHeaders: {"lang": "en"});
                    ApiRequestOptions.refreshConfig();
                    setLocale("en");
                    context.locale = const Locale('en', '');
                    prefs.setString("lang", "en");
                    prefs.setString("language", "English");
                  });

                  MagicRouter.navigateAndPopAll(const SplashScreen());
                }
                // else if (value == 3) {
                //   setState(() {
                //     ApiRequestOptions.instance
                //         ?.config(defaultHeaders: {"lang": "tr"});
                //     ApiRequestOptions.refreshConfig();
                //     setLocale("tr");
                //     context.locale = const Locale('tr', '');
                //     prefs.setString("lang", "tr");
                //     prefs.setString("language", "Türkçe");
                //   });

                //   MagicRouter.navigateAndPopAll(const SplashScreen());
                // }
                else if (value == 2) {
                  setState(() {
                    ApiRequestOptions.instance
                        ?.config(defaultHeaders: {"lang": "ar"});
                    ApiRequestOptions.refreshConfig();
                    setLocale("ar");
                    context.locale = const Locale('ar', '');
                    prefs.setString("lang", "ar");

                    prefs.setString("language", "العربية");
                  });

                  MagicRouter.navigateAndPopAll(const SplashScreen());
                }
              },
            )
          : null,
      floatingActionButton: (widget.fromHome == true)
          ? BlocConsumer<SettingCubit, SettingState>(
              bloc: GetIt.I<SettingCubit>(),
              builder: (context, state) => FloatingActionButton(
                heroTag: "hero7",
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
      body: const ManageOffersBody(),
    );
  }
}
