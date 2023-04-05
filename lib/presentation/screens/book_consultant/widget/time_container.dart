// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:zat/generator/locale_keys.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../../core/widgets/custom_buttons_widget.dart';
// import '../../../../core/widgets/space_widget.dart';

// class TimeContainerSelection extends StatefulWidget {
//   const TimeContainerSelection({Key? key}) : super(key: key);

//   @override
//   State<TimeContainerSelection> createState() => _TimeContainerSelectionState();
// }

// class _TimeContainerSelectionState extends State<TimeContainerSelection> {
//   List<String> days = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"];
//   List<String> dates = [
//     "12/14",
//     "12/15",
//     "12/16",
//     "12/17",
//     "12/18",
//     "12/19",
//     "12/20"
//   ];
//   int? changeColor;
//   List<int> selected = [];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//           horizontal: screenWidth(context) * 0.01,
//           vertical: screenHeight(context) * 0.01),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//         color: Colors.white,
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
//         children: [
//           const VerticalSpace(value: 1),
//           Text(
//             LocaleKeys.PICK_DAY.tr(),
//             style: headingStyle.copyWith(
//               color: colordeepGrey,
//               fontWeight: FontWeight.normal,
//               fontSize: screenWidth(context) * 0.035,
//             ),
//           ),
//           const VerticalSpace(value: 1),
//           Wrap(
//             runSpacing: 2,
//             spacing: 2,
//             children: List.generate(
//               dates.length,
//               (index) => SizedBox(
//                 width: screenWidth(context) * 0.1,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       days[index],
//                       style: headingStyle.copyWith(
//                         color: colordeepGrey,
//                         fontWeight: FontWeight.normal,
//                         fontSize: screenWidth(context) * 0.03,
//                       ),
//                     ),
//                     const VerticalSpace(value: 1),
//                     Text(
//                       dates[index],
//                       style: headingStyle.copyWith(
//                         color: colordeepGrey,
//                         fontWeight: FontWeight.normal,
//                         fontSize: screenWidth(context) * 0.03,
//                       ),
//                     ),
//                     const VerticalSpace(value: 1),
//                     InkWell(
//                       onTap: () {
//                         if (selected.contains(index)) {
//                           setState(() {
//                             selected.remove(index);
//                           });
//                         } else {
//                           setState(() {
//                             selected.add(index);
//                           });
//                         }
//                       },
//                       child: Container(
//                         width: screenWidth(context) * 0.1,
//                         height: screenHeight(context) * 0.04,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: colordeepGrey,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                               screenWidth(context) * 0.01),
//                           color: (selected.contains(index))
//                               ? colordeepGrey
//                               : Colors.white,
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.check,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const VerticalSpace(value: 1),
//           Container(
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(
//               horizontal: screenWidth(context) * 0.01,
//             ),
//             height: screenHeight(context) * 0.15,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//               border: Border.all(color: colorGrey),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           CupertinoIcons.clock,
//                           color: colorGrey,
//                         ),
//                         const HorizontalSpace(value: 0.5),
//                         Text(
//                           LocaleKeys.TIME_PERIOD.tr(),
//                           style: headingStyle.copyWith(
//                             color: colordeepGrey,
//                             fontWeight: FontWeight.normal,
//                             fontSize: screenWidth(context) * 0.03,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const HorizontalSpace(value: 1),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           CupertinoIcons.clock,
//                           color: colorGrey,
//                         ),
//                         const HorizontalSpace(value: 0.5),
//                         Text(
//                           LocaleKeys.CONSULTATION_TIME.tr(),
//                           style: headingStyle.copyWith(
//                             color: colordeepGrey,
//                             fontWeight: FontWeight.normal,
//                             fontSize: screenWidth(context) * 0.03,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const VerticalSpace(value: 1),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () => showTimeMenu(context: context),
//                           child: Container(
//                             width: screenWidth(context) * 0.2,
//                             height: screenHeight(context) * 0.03,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: colorLightGrey),
//                               color: colorGrey.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(
//                                 screenWidth(context) * 0.01,
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "00:00",
//                                   textAlign: TextAlign.center,
//                                   style: headingStyle.copyWith(
//                                     color: colordeepGrey,
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: screenWidth(context) * 0.03,
//                                   ),
//                                 ),
//                                 const HorizontalSpace(value: 0.5),
//                                 Icon(
//                                   Icons.keyboard_arrow_down_outlined,
//                                   color: colordeepGrey,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const HorizontalSpace(value: 0.5),
//                         const Text("-"),
//                         const HorizontalSpace(value: 0.5),
//                         InkWell(
//                           onTap: () => showTimeMenu(context: context),
//                           child: Container(
//                             width: screenWidth(context) * 0.2,
//                             height: screenHeight(context) * 0.03,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: colorLightGrey),
//                               color: colorGrey.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(
//                                 screenWidth(context) * 0.01,
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "23:00",
//                                   textAlign: TextAlign.center,
//                                   style: headingStyle.copyWith(
//                                     color: colordeepGrey,
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: screenWidth(context) * 0.03,
//                                   ),
//                                 ),
//                                 const HorizontalSpace(value: 0.5),
//                                 Icon(
//                                   Icons.keyboard_arrow_down_outlined,
//                                   color: colordeepGrey,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const HorizontalSpace(value: 1),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               changeColor = 0;
//                             });
//                           },
//                           child: Container(
//                             width: screenWidth(context) * 0.1,
//                             height: screenHeight(context) * 0.03,
//                             color: (changeColor == 0)
//                                 ? colordeepGrey
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 "50 min",
//                                 textAlign: TextAlign.center,
//                                 style: headingStyle.copyWith(
//                                   color: (changeColor == 0)
//                                       ? Colors.white
//                                       : colordeepGrey,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: screenWidth(context) * 0.03,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const HorizontalSpace(value: 0.5),
//                         const Text("-"),
//                         const HorizontalSpace(value: 0.5),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               changeColor = 1;
//                             });
//                           },
//                           child: Container(
//                             width: screenWidth(context) * 0.1,
//                             height: screenHeight(context) * 0.03,
//                             color: (changeColor == 1)
//                                 ? colordeepGrey
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 "25 min",
//                                 textAlign: TextAlign.center,
//                                 style: headingStyle.copyWith(
//                                   color: (changeColor == 1)
//                                       ? Colors.white
//                                       : colordeepGrey,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: screenWidth(context) * 0.03,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const VerticalSpace(value: 2),
//           SizedBox(
//             width: screenWidth(context) * 0.7,
//             height: screenHeight(context) * 0.04,
//             child: Center(
//               child: CustomGeneralButton(
//                 text: LocaleKeys.SEARCH.tr(),
//                 textColor: Colors.white,
//                 onTap: () {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
