// ignore_for_file: deprecated_member_use

// import 'package:api_request/api_request.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:zat/core/constants/colors.dart';
// import 'package:zat/presentation/widget/internalscreen_appbar.dart';

// import '../../../core/constants/constants.dart';
// import '../../../core/router/router.dart';
// import '../../../generator/localization_constant.dart';
// import '../splash/splash.dart';
// import 'widget/body.dart';

// class CertificateScreen extends StatefulWidget {
//   const CertificateScreen({Key? key}) : super(key: key);

//   @override
//   State<CertificateScreen> createState() => _CertificateScreenState();
// }

// class _CertificateScreenState extends State<CertificateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: internalScreensAppbar(
//         context,
//         (value) {
//           if (value == 1) {
//             setState(() {
//               ApiRequestOptions.instance
//                   ?.config(defaultHeaders: {"lang": "en"});
//               ApiRequestOptions.refreshConfig();
//               setLocale("en");
//               context.locale = const Locale('en', '');
//               prefs.setString("lang", "en");
//               prefs.setString("language", "English");
//             });

//             MagicRouter.navigateAndPopAll(const SplashScreen());
//           }
//           // else if (value == 3) {
//           //   setState(() {
//           //     ApiRequestOptions.instance
//           //         ?.config(defaultHeaders: {"lang": "tr"});
//           //     ApiRequestOptions.refreshConfig();
//           //     setLocale("tr");
//           //     context.locale = const Locale('tr', '');
//           //     prefs.setString("lang", "tr");
//           //     prefs.setString("language", "Türkçe");
//           //   });

//           //   MagicRouter.navigateAndPopAll(const SplashScreen());
//           // }
//           else if (value == 2) {
//             setState(() {
//               ApiRequestOptions.instance
//                   ?.config(defaultHeaders: {"lang": "ar"});
//               ApiRequestOptions.refreshConfig();
//               setLocale("ar");
//               context.locale = const Locale('ar', '');
//               prefs.setString("lang", "ar");

//               prefs.setString("language", "اللغة العربية");
//             });

//             MagicRouter.navigateAndPopAll(const SplashScreen());
//           }
//         },
//       ),
//       backgroundColor: backgroundColor,
//       body: const CertificateBody(),
//     );
//   }
// }
