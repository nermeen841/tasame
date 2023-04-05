import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';

class BestSellerPadge extends StatelessWidget {
  const BestSellerPadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenWidth(context) * 0.3,
        height: screenHeight(context) * 0.03,
        decoration: BoxDecoration(
          color: colorRed,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              screenWidth(context) * 0.04,
            ),
            topRight: Radius.circular(
              screenWidth(context) * 0.04,
            ),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.BEST_SELLER.tr(),
            style: headingStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: screenWidth(context) * 0.035,
            ),
          ),
        ),
      ),
    );
  }
}
