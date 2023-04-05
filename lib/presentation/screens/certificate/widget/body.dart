// import 'package:flutter/material.dart';
// import 'package:zat/core/constants/constants.dart';
// import 'package:zat/core/widgets/space_widget.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:zat/generator/locale_keys.dart';
// import '../../../../core/constants/colors.dart';
// import 'certificate_download.dart';

// class CertificateBody extends StatefulWidget {
//   const CertificateBody({Key? key}) : super(key: key);

//   @override
//   State<CertificateBody> createState() => _CertificateBodyState();
// }

// class _CertificateBodyState extends State<CertificateBody> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth(context) * 0.04,
//         vertical: screenHeight(context) * 0.02,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             height: screenHeight(context) * 0.09,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//               boxShadow: [
//                 BoxShadow(
//                   color: colorGrey.withOpacity(0.2),
//                   offset: const Offset(0, 1),
//                   spreadRadius: 1,
//                   blurRadius: 1,
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 LocaleKeys.CERTIFICATE_MESSAGE.tr(),
//                 textAlign: TextAlign.center,
//                 style: headingStyle.copyWith(
//                     fontWeight: FontWeight.w400,
//                     fontSize: screenWidth(context) * 0.035),
//               ),
//             ),
//           ),
//           const VerticalSpace(value: 2),
//           const CertificateDownload(),
//         ],
//       ),
//     );
//   }
// }
