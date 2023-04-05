// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:zat/core/widgets/space_widget.dart';
// import 'package:zat/generator/locale_keys.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/constants/constants.dart';
// import 'package:easy_localization/easy_localization.dart';

// class CertificateDownload extends StatefulWidget {
//   const CertificateDownload({Key? key}) : super(key: key);

//   @override
//   State<CertificateDownload> createState() => _CertificateDownloadState();
// }

// class _CertificateDownloadState extends State<CertificateDownload> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth(context) * 0.05,
//         vertical: screenHeight(context) * 0.02,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//         boxShadow: [
//           BoxShadow(
//             color: colorGrey.withOpacity(0.2),
//             offset: const Offset(0, 1),
//             spreadRadius: 1,
//             blurRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: double.infinity,
//             height: screenHeight(context) * 0.09,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(screenWidth(context) * 0.015),
//               border: Border.all(
//                 color: colorGrey.withOpacity(0.3),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Text(
//                     LocaleKeys.HOURS_LEFT.tr(),
//                     textAlign: TextAlign.center,
//                     style: headingStyle.copyWith(
//                         fontWeight: FontWeight.w400,
//                         fontSize: screenWidth(context) * 0.035),
//                   ),
//                 ),
//                 const VerticalSpace(value: 0.5),
//                 LinearPercentIndicator(
//                   width: screenWidth(context) * 0.8,
//                   lineHeight: 14.0,
//                   percent: 0.1,
//                   center: const Text("10 %"),
//                   backgroundColor: backgroundColor,
//                   barRadius: Radius.circular(screenWidth(context) * 0.02),
//                   progressColor: colorRed,
//                 ),
//                 const VerticalSpace(value: 0.5),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth(context) * 0.035),
//                   child: Text(
//                     "1 Hours",
//                     textAlign: TextAlign.center,
//                     style: headingStyle.copyWith(
//                       fontWeight: FontWeight.w400,
//                       fontSize: screenWidth(context) * 0.035,
//                       color: colorGrey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const VerticalSpace(value: 3),
//           Container(
//             width: double.infinity,
//             height: screenHeight(context) * 0.25,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
//               boxShadow: [
//                 BoxShadow(
//                   color: colorGrey.withOpacity(0.2),
//                   offset: const Offset(0, 1),
//                   spreadRadius: 1,
//                   blurRadius: 1,
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
//               child: customCachedNetworkImage(
//                   url:
//                       "https://img.freepik.com/free-photo/certification-divorce-isolated-white-table_53876-33539.jpg?size=626&ext=jpg&ga=GA1.2.1193666936.1645267385&semt=sph",
//                   context: context,
//                   fit: BoxFit.cover),
//             ),
//           ),
//           const VerticalSpace(value: 3),
//           Center(
//             child: SizedBox(
//               width: screenWidth(context) * 0.35,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   elevation: MaterialStateProperty.all(2),
//                   backgroundColor: MaterialStateProperty.all(kMainColor),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(screenWidth(context) * 0.05),
//                     ),
//                   ),
//                 ),
//                 child: Text(
//                   LocaleKeys.DOWNLOAD.tr(),
//                   style: headingStyle.copyWith(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
