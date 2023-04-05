import 'package:flutter/material.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/plans_and_prices/pages/payment_type_selection.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/space_widget.dart';

class PlansDetail extends StatefulWidget {
  const PlansDetail({Key? key}) : super(key: key);

  @override
  State<PlansDetail> createState() => _PlansDetailState();
}

class _PlansDetailState extends State<PlansDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: screenWidth(context) * 0.7,
          height: screenHeight(context) * 0.2,
          padding: EdgeInsets.symmetric(
            horizontal: screenHeight(context) * 0.04,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colorGrey.withOpacity(0.2),
                offset: const Offset(0, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(
                screenWidth(context) * 0.04,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " 1 ",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.05,
                        color: colordeepGrey,
                      ),
                    ),
                    TextSpan(
                      text: "Month",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: screenWidth(context) * 0.045,
                        color: colordeepGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(value: 1),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " 3 ",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.05,
                        color: colordeepGrey,
                      ),
                    ),
                    TextSpan(
                      text: "Lessons / per week",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: screenWidth(context) * 0.045,
                        color: colordeepGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(value: 1),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " 25 ",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.05,
                        color: colordeepGrey,
                      ),
                    ),
                    TextSpan(
                      text: "minutes / per lesson",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: screenWidth(context) * 0.045,
                        color: colordeepGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(value: 1),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " 290.90 ",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.05,
                        color: colordeepGrey,
                      ),
                    ),
                    TextSpan(
                      text: "\$",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: screenWidth(context) * 0.045,
                        color: colordeepGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(value: 1.3),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  width: screenWidth(context) * 0.2,
                  height: screenHeight(context) * 0.02,
                  decoration: BoxDecoration(
                    color: colorRed.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        screenWidth(context) * 0.03,
                      ),
                      topRight: Radius.circular(
                        screenWidth(context) * 0.03,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "save 25 %",
                      style: headingStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontSize: screenWidth(context) * 0.035,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            MagicRouter.navigateTo(const PaymentTypeSelection(
              fromQuestions: false,
            ));
          },
          child: Container(
            width: screenWidth(context) * 0.21,
            height: screenHeight(context) * 0.2,
            padding: EdgeInsets.symmetric(
              horizontal: screenHeight(context) * 0.02,
              vertical: screenHeight(context) * 0.01,
            ),
            decoration: BoxDecoration(
              color: kMainColor,
              boxShadow: [
                BoxShadow(
                  color: colorGrey.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(
                  screenWidth(context) * 0.04,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Start",
                  style: headingStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(context) * 0.045,
                  ),
                ),
                const VerticalSpace(value: 3),
                Icon(
                  Icons.double_arrow_sharp,
                  color: Colors.white,
                  size: screenWidth(context) * 0.08,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
