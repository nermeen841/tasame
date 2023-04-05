// ignore_for_file: deprecated_member_use

import 'package:api_request/api_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/splash/splash.dart';
import 'package:zat/presentation/screens/tutor_offers/widget/speialicity_tutors.dart';
import 'package:zat/presentation/widget/internalscreen_appbar.dart';

import '../../../core/constants/constants.dart';
import '../../../generator/localization_constant.dart';
import '../myaccount/model/specialicity.dart';
import 'widget/body.dart';

class TutorRelatedOffersScreen extends StatefulWidget {
  final List<Tutors>? tutors;
  const TutorRelatedOffersScreen({super.key, this.tutors});

  @override
  State<TutorRelatedOffersScreen> createState() =>
      _TutorRelatedOffersScreenState();
}

class _TutorRelatedOffersScreenState extends State<TutorRelatedOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: (widget.tutors != null && widget.tutors!.isNotEmpty)
          ? TutorsSpecialicityList(tutors: widget.tutors!)
          : const TutorsOfferList(),
    );
  }
}
