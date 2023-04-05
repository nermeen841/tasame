// import 'package:flutter/material.dart';
// import 'package:zat/core/constants/colors.dart';
// import 'package:zat/core/constants/constants.dart';
// import 'package:zat/core/widgets/space_widget.dart';
// import 'package:zat/generator/locale_keys.dart';
// import 'time_container.dart';
// import 'package:easy_localization/easy_localization.dart';

// class TimeSelectionForBooking extends StatefulWidget {
//   const TimeSelectionForBooking({Key? key}) : super(key: key);

//   @override
//   State<TimeSelectionForBooking> createState() =>
//       _TimeSelectionForBookingState();
// }

// class _TimeSelectionForBookingState extends State<TimeSelectionForBooking> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           height: screenHeight(context) * 0.05,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: colorGrey.withOpacity(0.2),
//                 offset: const Offset(0, 1),
//                 spreadRadius: 1,
//                 blurRadius: 1,
//               ),
//             ],
//           ),
//           child: Center(
//               child: Text(
//             LocaleKeys.BOOK_MESSAGE.tr(),
//             textAlign: TextAlign.center,
//             style: headingStyle.copyWith(
//               color: colordeepGrey,
//               fontWeight: FontWeight.w300,
//               fontSize: screenWidth(context) * 0.035,
//             ),
//           )),
//         ),
//         const VerticalSpace(value: 1.5),
//         const TimeContainerSelection(),
//       ],
//     );
//   }
// }
