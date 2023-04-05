import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';

class SplashContent extends StatelessWidget {
  final String text, image, title;

  const SplashContent(
      {Key? key, required this.text, required this.image, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(16),
            height: h * 0.3,
            width: w * 1,
            child: customCachedNetworkImage(
                url: image, context: context, fit: BoxFit.contain)),
        SizedBox(
          height: h * 0.02,
        ),
        SizedBox(
          width: w * 0.85,
          child: Text(
            title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        SizedBox(
          width: w * 0.85,
          child: Text(
            text,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w400,
                color: colorGrey),
          ),
        ),
      ],
    );
  }
}
