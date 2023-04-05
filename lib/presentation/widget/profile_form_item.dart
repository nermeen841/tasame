import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';

class ProfileFormItem extends StatelessWidget {
  final String title;
  final bool isRequired;
  final Widget widget;
  const ProfileFormItem(
      {Key? key,
      required this.title,
      required this.isRequired,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: title,
                  style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(context) * 0.03,
                  )),
              TextSpan(
                  text: (isRequired == true) ? "* " : "",
                  style: headingStyle.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(context) * 0.03,
                  )),
            ],
          ),
        ),
        SizedBox(
          // width: screenWidth(context) * 0.4,
          height: screenHeight(context) * 0.08,
          child: widget,
        ),
      ],
    );
  }
}
