import 'package:flutter/material.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';

Widget filterItem(String title, context) {
  return Container(
    width: screenWidth(context) * 0.3,
    height: screenHeight(context) * 0.05,
    margin: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.01),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(screenWidth(context) * 0.015),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: colorGrey.withOpacity(0.2),
          offset: const Offset(0, 1),
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: headingStyle.copyWith(
            color: Colors.black,
            fontSize: screenWidth(context) * 0.035,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Icon(Icons.arrow_drop_down, color: Colors.black87),
      ],
    ),
  );
}

/////////////////////////////////////////////////////////////////////////
Widget showAccountDetail(
    {required String title, required String data, required context}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: headingStyle.copyWith(
            color: kMainColor,
            fontSize: screenWidth(context) * 0.04,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: data,
          style: headingStyle.copyWith(
            color: colordeepGrey,
            fontSize: screenWidth(context) * 0.04,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
