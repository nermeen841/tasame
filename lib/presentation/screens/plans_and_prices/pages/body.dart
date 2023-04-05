// import 'package:flutter/material.dart';
// import 'package:zat/core/constants/colors.dart';
// import 'package:zat/core/constants/constants.dart';
// import 'package:zat/core/widgets/space_widget.dart';
// import 'package:zat/generator/locale_keys.dart';
// import 'package:easy_localization/easy_localization.dart';
// import '../widget/best_seller.dart';
// import '../widget/plan_detail.dart';
// import '../widget/time_period_select.dart';

// class PlansAndPricesBody extends StatefulWidget {
//   const PlansAndPricesBody({Key? key}) : super(key: key);

//   @override
//   State<PlansAndPricesBody> createState() => _PlansAndPricesBodyState();
// }

// class _PlansAndPricesBodyState extends State<PlansAndPricesBody> {
//   bool isVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth(context) * 0.04,
//         vertical: screenHeight(context) * 0.04,
//       ),
//       child: Column(
//         children: [
//           ListView.separated(
//             primary: false,
//             shrinkWrap: true,
//             itemBuilder: (context, index) => Column(
//               children: [
//                 (index == 0 || index == 2)
//                     ? const BestSellerPadge()
//                     : const SizedBox(),
//                 const PlansDetail(),
//                 Visibility(
//                     visible: isVisible, child: const TimePeroidSelection()),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       isVisible = !isVisible;
//                     });
//                   },
//                   child: Center(
//                     child: Container(
//                       width: screenWidth(context) * 0.9,
//                       height: screenHeight(context) * 0.04,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft:
//                               Radius.circular(screenWidth(context) * 0.02),
//                           bottomRight:
//                               Radius.circular(screenWidth(context) * 0.02),
//                         ),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(LocaleKeys.CUSTOMIZE_PLAN.tr()),
//                           const HorizontalSpace(value: 2),
//                           Icon(
//                             (!isVisible)
//                                 ? Icons.keyboard_arrow_down_outlined
//                                 : Icons.keyboard_arrow_up_outlined,
//                             color: colordeepGrey,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             separatorBuilder: (context, index) => const VerticalSpace(value: 4),
//             itemCount: 6,
//           ),
//           const VerticalSpace(value: 3),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.privacy_tip_outlined,
//                 color: colorBetrolly,
//               ),
//               const HorizontalSpace(value: 1.5),
//               Text(
//                 "All payments are secure with Strip",
//                 style: headingStyle.copyWith(
//                   color: colordeepGrey,
//                   fontSize: screenWidth(context) * 0.035,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
