import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/widgets/space_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';

class SubscriptionViwe extends StatefulWidget {
  const SubscriptionViwe({Key? key}) : super(key: key);

  @override
  State<SubscriptionViwe> createState() => _SubscriptionViweState();
}

class _SubscriptionViweState extends State<SubscriptionViwe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight(context) * 0.02,
        horizontal: screenWidth(context) * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subscripItem(
            context: context,
            child: Center(
              child: Text(
                translateString(
                    "Course plan : you don't have any subscription yet.",
                    "خطة الدورة: ليس لديك أي اشتراك حتى الآن.",
                    "Kurs planı: henüz herhangi bir aboneliğiniz yok."),
                style: headingStyle.copyWith(
                  fontSize: screenWidth(context) * 0.035,
                  fontWeight: FontWeight.w400,
                  color: colordeepGrey,
                ),
              ),
            ),
          ),
          const VerticalSpace(value: 2),
          subscripItem(
            context: context,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    translateString(
                        "video recording feature is on",
                        "ميزة تسجيل الفيديو قيد التشغيل",
                        "video kayıt özelliği açık"),
                    style: headingStyle.copyWith(
                      fontSize: screenWidth(context) * 0.035,
                      fontWeight: FontWeight.w400,
                      color: colordeepGrey,
                    ),
                  ),
                ),
                const HorizontalSpace(value: 1),
                CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          const VerticalSpace(value: 3),
          SizedBox(
            width: screenWidth(context) * 0.4,
            height: screenHeight(context) * 0.04,
            child: CustomGeneralButton(
              text: translateString(
                  "Subscribe now", "إشترك الآن", "Şimdi abone ol"),
              textColor: Colors.white,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

Widget subscripItem({required context, required Widget child}) {
  return Row(
    children: [
      Container(
        width: screenWidth(context) * 0.03,
        height: screenHeight(context) * 0.04,
        color: colordeepGrey.withOpacity(0.5),
      ),
      Container(
        width: screenWidth(context) * 0.8,
        height: screenHeight(context) * 0.04,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(screenWidth(context) * 0.05),
            bottomEnd: Radius.circular(screenWidth(context) * 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: colorGrey.withOpacity(0.2),
              offset: const Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: child,
      ),
    ],
  );
}
