import 'package:flutter/material.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight(context) * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
        boxShadow: [
          BoxShadow(
            color: colorGrey.withOpacity(0.2),
            offset: const Offset(0, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
