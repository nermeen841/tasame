// ignore_for_file: deprecated_member_use

import 'package:api_request/api_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/contactus/body.dart';
import 'package:zat/presentation/widget/internalscreen_appbar.dart';

import '../../../core/router/router.dart';
import '../../../generator/localization_constant.dart';
import '../splash/splash.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ContactusBody(),
      appBar: internalScreensAppbar(
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

              prefs.setString("language", "اللغة العربية");
            });

            MagicRouter.navigateAndPopAll(const SplashScreen());
          }
        },
      ),
    );
  }
}