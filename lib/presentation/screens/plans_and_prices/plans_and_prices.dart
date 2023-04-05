// // ignore_for_file: deprecated_member_use

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:zat/generator/localization_constant.dart';
// import '../../../core/constants/colors.dart';
// import '../../../core/constants/constants.dart';
// import '../../../core/router/router.dart';
// import '../../../core/widgets/space_widget.dart';
// import '../myaccount/myaccount.dart';
// import '../splash/splash.dart';
// import 'pages/body.dart';

// class PlansAndPricesScreen extends StatefulWidget {
//   const PlansAndPricesScreen({Key? key}) : super(key: key);

//   @override
//   State<PlansAndPricesScreen> createState() => _PlansAndPricesScreenState();
// }

// class _PlansAndPricesScreenState extends State<PlansAndPricesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       body: const PlansAndPricesBody(),
//     );
//   }

//   AppBar appBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       elevation: 0.0,
//       backgroundColor: Colors.white,
//       leading: InkWell(
//         onTap: () => MagicRouter.pop(),
//         child: Container(
//           width: screenWidth(context) * 0.2,
//           margin: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//             border: Border.all(
//               color: Colors.black,
//             ),
//             color: Colors.white,
//           ),
//           child: const Center(
//             child: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         PopupMenuButton(
//           onSelected: (value) {
//             if (value == 1) {
//               setState(() {
//                 setLocale("en");
//                 context.locale = const Locale('en', '');
//                 prefs.setString("lang", "en");
//                 prefs.setString("language", "English");
//               });
//               MagicRouter.navigateAndPopAll(const SplashScreen());
//             } else if (value == 3) {
//               setState(() {
//                 setLocale("tr");
//                 context.locale = const Locale('tr', '');
//                 prefs.setString("lang", "tr");
//                 prefs.setString("language", "Türkçe");
//               });
//               MagicRouter.navigateAndPopAll(const SplashScreen());
//             } else if (value == 2) {
//               setState(() {
//                 setLocale("ar");
//                 context.locale = const Locale('ar', '');
//                 prefs.setString("lang", "ar");
//                 prefs.setString("language", "اللغة العربية");
//               });
//               MagicRouter.navigateAndPopAll(const SplashScreen());
//             }
//           },
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "English",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down, color: Colors.black87),
//             ],
//           ),
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               onTap: () async {},
//               value: 1,
//               child: Text(
//                 "English",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               onTap: () async {},
//               value: 2,
//               child: Text(
//                 "اللغة العربية",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               onTap: () async {},
//               value: 2,
//               child: Text(
//                 "Türkçe",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const HorizontalSpace(value: 2),
//         PopupMenuButton(
//           onSelected: (value) {
//             if (value == 1) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const MyProfileScreen()));
//             } else {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SplashScreen()),
//                   (route) => false);
//             }
//           },
//           child: CircleAvatar(
//             backgroundColor: colorGrey,
//             child: Text(
//               "N",
//               style: headingStyle.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 1,
//               child: Text(
//                 "My Profile",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               value: 2,
//               child: Text(
//                 "Log out",
//                 style: headingStyle.copyWith(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const HorizontalSpace(value: 1.5),
//       ],
//     );
//   }
// }
