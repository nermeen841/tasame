// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';

import '../../../../core/router/router.dart';
import '../../layout/layuot.dart';

class ResultScreen extends StatefulWidget {
  final String result;
  final String url;
  const ResultScreen({super.key, required this.result, required this.url});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              translateString("Result", "النتيجة", ""),
              style: headingStyle.copyWith(
                color: colordeepGrey,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
            const VerticalSpace(value: 1),
            Text(
              widget.result,
              style: headingStyle.copyWith(
                color: colordeepGrey,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.08,
              ),
            ),
            const VerticalSpace(value: 4),
            CustomGeneralButton(
              textColor: Colors.white,
              borderColor: Colors.transparent,
              color: kMainColor,
              text: translateString(
                  "Upload result file", "تحميل ملف النتيجة", ""),
              onTap: () async {
                await launch(widget.url);
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 4,
                ));
              },
            ),
            const VerticalSpace(value: 2),
            CustomGeneralButton(
              textColor: Colors.white,
              borderColor: Colors.transparent,
              color: kMainColor,
              text: translateString("Cancel", "إلغاء", ""),
              onTap: () async {
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 4,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
