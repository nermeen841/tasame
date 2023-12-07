// ignore_for_file: deprecated_member_use

import 'package:api_request/api_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/generator/localization_constant.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/account_statement/widget/body.dart';
import 'package:zat/presentation/screens/layout/appbar.dart';
import 'package:zat/presentation/screens/splash/splash.dart';

class AcccountStatemnetScreen extends StatefulWidget {
  const AcccountStatemnetScreen({super.key});

  @override
  State<AcccountStatemnetScreen> createState() =>
      _AcccountStatemnetScreenState();
}

class _AcccountStatemnetScreenState extends State<AcccountStatemnetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: layoutAppbar(
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
          } else if (value == 3) {
            setState(() {
              ApiRequestOptions.instance
                  ?.config(defaultHeaders: {"lang": "tr"});
              ApiRequestOptions.refreshConfig();
              setLocale("tr");
              context.locale = const Locale('tr', '');
              prefs.setString("lang", "tr");
              prefs.setString("language", "Türkçe");
            });

            MagicRouter.navigateAndPopAll(const SplashScreen());
          } else if (value == 2) {
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
      ),
      body: const AccountStatementBody(),
    );
  }
}
